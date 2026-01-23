import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/app_text_button.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'package:temy_barber/features/reservations/logic/reservation_cubit.dart';
import 'package:temy_barber/features/reservations/logic/reservation_state.dart';
import 'package:temy_barber/features/auth/ui/widgets/otp_verification_dialog.dart';

class GuestInfoDialog extends StatefulWidget {
  const GuestInfoDialog({super.key});

  @override
  State<GuestInfoDialog> createState() => _GuestInfoDialogState();
}

class _GuestInfoDialogState extends State<GuestInfoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _requestOtpAndShowDialog() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final phone = _phoneController.text.trim();

    // Request OTP from the backend for reservation
    context.read<ReservationCubit>().requestGuestVerification(phone: phone);
  }

  Future<void> _showOtpDialog(String phone, String name) async {
    final otp = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) => OtpVerificationDialog(
        phoneNumber: phone,
        onResendOtp: () {
          // Request OTP again for reservation
          context.read<ReservationCubit>().requestGuestVerification(
            phone: phone,
          );
        },
      ),
    );

    if (otp != null && mounted) {
      print('✅ GuestInfoDialog: OTP received from dialog: $otp');
      // Return guest info with OTP to parent
      final guestInfo = GuestInfo(name: name, phone: phone);

      // Return both guest info and OTP as a map
      Navigator.pop(context, {'guestInfo': guestInfo, 'otp': otp});
    } else {
      print('❌ GuestInfoDialog: OTP dialog cancelled or returned null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReservationCubit, ReservationState>(
      listener: (context, state) {
        state.maybeWhen(
          otpRequestSuccess: (response) {
            // OTP sent successfully, show OTP dialog
            final phone = _phoneController.text.trim();
            final name = _nameController.text.trim();
            _showOtpDialog(phone, name);
          },
          otpRequestError: (error) {
            // Error will be shown in the UI via BlocBuilder
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        // Determine current state
        final isLoading = state.maybeWhen(
          otpRequestLoading: () => true,
          orElse: () => false,
        );

        final hasError = state.maybeWhen(
          otpRequestError: (_) => true,
          orElse: () => false,
        );

        final errorMessage = state.maybeWhen(
          otpRequestError: (error) =>
              error.apiErrorModel.message ?? 'Error sending OTP',
          orElse: () => null,
        );

        // Check if it's a rate limit error (OTP already sent)
        final isRateLimitError =
            errorMessage?.contains('already sent') ?? false;

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  // Title
                  Text(
                    'auth.guest_booking'.tr(),
                    style: TextStyles.font24BlackBold,
                  ),
                  verticalSpace(8),
                  Text(
                    'auth.guest_booking_subtitle'.tr(),
                    style: TextStyles.font14GrayRegular,
                  ),
                  verticalSpace(24),

                  // Show loading indicator or error/info feedback
                  if (isLoading) ...[
                    Center(
                      child: Column(
                        children: [
                          const CircularProgressIndicator(
                            color: ColorsManager.mainBlue,
                          ),
                          verticalSpace(16),
                          Text(
                            'Sending OTP...',
                            style: TextStyles.font14GrayRegular,
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(24),
                  ] else if (hasError && isRateLimitError) ...[
                    // Show rate limit as info (blue) instead of error (red)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: ColorsManager.lightBlue,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ColorsManager.mainBlue.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.info_outline,
                            color: ColorsManager.mainBlue,
                            size: 24,
                          ),
                          horizontalSpace(12),
                          Expanded(
                            child: Text(
                              'OTP already sent! Please check your phone and enter the code below.',
                              style: TextStyles.font14DarkBlueMedium,
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(12),
                    // Add button to manually enter OTP
                    Center(
                      child: TextButton.icon(
                        onPressed: () {
                          final phone = _phoneController.text.trim();
                          final name = _nameController.text.trim();
                          if (phone.isNotEmpty && name.isNotEmpty) {
                            _showOtpDialog(phone, name);
                          }
                        },
                        icon: const Icon(Icons.dialpad, size: 20),
                        label: Text(
                          'Enter OTP Code',
                          style: TextStyles.font14DarkBlueMedium,
                        ),
                        style: TextButton.styleFrom(
                          foregroundColor: ColorsManager.mainBlue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          backgroundColor: ColorsManager.lightBlue.withOpacity(
                            0.3,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    verticalSpace(16),
                  ] else if (hasError) ...[
                    // Show actual errors in red
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.red.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 24,
                          ),
                          horizontalSpace(12),
                          Expanded(
                            child: Text(
                              errorMessage ?? 'An error occurred',
                              style: TextStyles.font14GrayRegular.copyWith(
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(16),
                  ],

                  // Form
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Name field
                        Text(
                          'auth.full_name'.tr(),
                          style: TextStyles.font14DarkBlueMedium,
                        ),
                        verticalSpace(8),
                        TextFormField(
                          controller: _nameController,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            hintText: 'auth.enter_full_name'.tr(),
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
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.3,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'auth.name_required'.tr();
                            }
                            if (value.length < 3) {
                              return 'auth.name_too_short'.tr();
                            }
                            return null;
                          },
                        ),
                        verticalSpace(16),

                        // Phone field
                        Text(
                          'auth.phone_number'.tr(),
                          style: TextStyles.font14DarkBlueMedium,
                        ),
                        verticalSpace(8),
                        TextFormField(
                          controller: _phoneController,
                          keyboardType: TextInputType.phone,
                          enabled: !isLoading,
                          decoration: InputDecoration(
                            hintText: 'auth.enter_phone_number'.tr(),
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
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: const BorderSide(
                                color: Colors.red,
                                width: 1.3,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'auth.phone_required'.tr();
                            }
                            // Basic phone validation - adjust regex as needed
                            if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
                              return 'auth.phone_invalid'.tr();
                            }
                            return null;
                          },
                        ),
                        verticalSpace(24),

                        // Buttons
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: isLoading
                                    ? null
                                    : () => Navigator.pop(context),
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
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
                              child: AppTextButton(
                                buttonText: 'common.continue'.tr(),
                                textStyle: TextStyles.font16WhiteSemiBold,
                                onPressed: isLoading
                                    ? () {}
                                    : () {
                                        _requestOtpAndShowDialog();
                                      },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
