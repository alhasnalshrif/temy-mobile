import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/app_text_button.dart';
import 'package:temy_barber/core/widgets/app_text_form_field.dart';
import 'package:temy_barber/features/auth/logic/verification_cubit.dart';
import 'package:temy_barber/features/auth/ui/widgets/verification_bloc_listener.dart';
import 'package:easy_localization/easy_localization.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool shouldAutoResend;
  final bool comingFromLogin;

  const VerificationScreen({
    super.key,
    required this.phoneNumber,
    this.shouldAutoResend = false,
    this.comingFromLogin = false,
  });

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  @override
  void initState() {
    super.initState();
    // Set the phone number for verification when the screen is built
    final cubit = context.read<VerificationCubit>();
    cubit.setPhoneNumber(widget.phoneNumber);
    cubit.setComingFromLogin(widget.comingFromLogin);

    debugPrint('=== Verification Screen Initialized ===');
    debugPrint('Phone Number: ${widget.phoneNumber}');
    debugPrint('Should Auto Resend: ${widget.shouldAutoResend}');
    debugPrint('Coming From Login: ${widget.comingFromLogin}');

    // Auto-resend OTP if coming from login screen for unverified user
    if (widget.shouldAutoResend) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        debugPrint('Auto-resending verification code...');
        cubit.resendCode();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // the back button remove
        automaticallyImplyLeading: false,
        title: Text(
          'verification.screen_title'.tr(),
          style: TextStyles.font18WhiteBold,
        ),
        backgroundColor: ColorsManager.mainBlue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.verified_user_outlined,
                  size: 80,
                  color: ColorsManager.mainBlue,
                ),
                verticalSpace(24),
                Text(
                  'verification.check_phone_title'.tr(),
                  style: TextStyles.font26BlueBold,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(12),
                Text(
                  'verification.code_sent_message'.tr(
                    args: [widget.phoneNumber],
                  ),
                  style: TextStyles.font16GrayRegular,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(36),
                Form(
                  key: context.read<VerificationCubit>().formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'verification.verification_code_label'.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      verticalSpace(12),
                      AppTextFormField(
                        hintText: '123456',
                        keyboardType: TextInputType.number,
                        controller: context
                            .read<VerificationCubit>()
                            .codeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'verification.code_required_error'.tr();
                          }
                          return null;
                        },
                      ),
                      verticalSpace(40),
                      AppTextButton(
                        buttonText: "verification.verify_button".tr(),
                        textStyle: TextStyles.font16WhiteSemiBold,
                        onPressed: () {
                          validateThenVerify(context);
                        },
                      ),
                      verticalSpace(24),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            // Call the resend code functionality
                            context.read<VerificationCubit>().resendCode();

                            // Show a snackbar to indicate the code was resent
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'verification.resend_code_success'.tr(),
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          child: Text(
                            'verification.resend_code_button'.tr(),
                            style: TextStyles.font14BlueSemiBold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const VerificationBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void validateThenVerify(BuildContext context) {
    if (context.read<VerificationCubit>().formKey.currentState!.validate()) {
      context.read<VerificationCubit>().verifyCode();
    }
  }
}
