import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/app_text_button.dart';
import 'package:temy_barber/core/helpers/spacing.dart';

class OtpVerificationDialog extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback onResendOtp;

  const OtpVerificationDialog({
    super.key,
    required this.phoneNumber,
    required this.onResendOtp,
  });

  @override
  State<OtpVerificationDialog> createState() => _OtpVerificationDialogState();
}

class _OtpVerificationDialogState extends State<OtpVerificationDialog> {
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isOtpComplete = false;
  int _secondsRemaining = 300; // 5 minutes
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 300;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  String get _formattedTime {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _handleResend() {
    if (_secondsRemaining > 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('auth.otp_wait_before_resend'.tr()),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    widget.onResendOtp();
    _startTimer();
    _otpController.clear();
    setState(() {
      _isOtpComplete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorsManager.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 8.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: ColorsManager.gray,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Icon
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: ColorsManager.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.phone_android,
                    size: 40,
                    color: ColorsManager.mainBlue,
                  ),
                ),
                verticalSpace(16),

                // Title
                Text(
                  'auth.verify_otp'.tr(),
                  style: TextStyles.font24BlackBold,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(8),

                // Subtitle with phone number
                Text(
                  '${'auth.otp_sent_to'.tr()} ${widget.phoneNumber}',
                  style: TextStyles.font14GrayRegular,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(24),

                // OTP Input Field
                TextFormField(
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyles.font24BlackBold.copyWith(letterSpacing: 8),
                  maxLength: 6,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    hintText: '000000',
                    counterText: '',
                    filled: true,
                    fillColor: ColorsManager.lighterGray,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: ColorsManager.mainBlue,
                        width: 1.5,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _isOtpComplete = value.length == 6;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'auth.otp_required'.tr();
                    }
                    if (value.length != 6) {
                      return 'auth.otp_invalid_length'.tr();
                    }
                    return null;
                  },
                ),
                verticalSpace(16),

                // Timer
                if (_secondsRemaining > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.lightBlue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.timer_outlined,
                          size: 18,
                          color: ColorsManager.mainBlue,
                        ),
                        horizontalSpace(8),
                        Text(
                          _formattedTime,
                          style: TextStyles.font14DarkBlueMedium,
                        ),
                      ],
                    ),
                  ),
                verticalSpace(24),

                // Resend OTP button
                TextButton(
                  onPressed: _handleResend,
                  child: Text(
                    'auth.resend_otp'.tr(),
                    style: TextStyles.font13BlueSemiBold.copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                verticalSpace(16),

                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          side: const BorderSide(
                            color: ColorsManager.mainBlue,
                            width: 1.5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'common.cancel'.tr(),
                          style: TextStyles.font13BlueSemiBold,
                        ),
                      ),
                    ),
                    horizontalSpace(12),
                    Expanded(
                      child: Opacity(
                        opacity: _isOtpComplete ? 1.0 : 0.5,
                        child: AppTextButton(
                          buttonText: 'auth.verify'.tr(),
                          textStyle: TextStyles.font16WhiteSemiBold,
                          onPressed: () {
                            if (_isOtpComplete &&
                                _formKey.currentState!.validate()) {
                              Navigator.pop(context, _otpController.text);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
