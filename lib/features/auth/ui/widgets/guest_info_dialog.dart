import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/app_buttons.dart';
import 'package:temy_barber/core/widgets/form_widgets.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/reservations/logic/reservation_cubit.dart';
import 'package:temy_barber/features/reservations/logic/reservation_state.dart';
import 'package:temy_barber/features/auth/ui/widgets/otp_verification_dialog.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';

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

  Future<void> _showOtpDialog(String phone, String name) async {
    final otp = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      backgroundColor: Colors.transparent,
      builder: (context) => OtpVerificationDialog(
        phoneNumber: phone,
        onResendOtp: () {
          context.read<ReservationCubit>().requestGuestVerification(phone: phone);
        },
      ),
    );

    if (otp != null && mounted) {
      final guestInfo = GuestInfo(name: name, phone: phone);
      Navigator.pop(context, {'guestInfo': guestInfo, 'otp': otp});
    }
  }

  void _handleSubmit(bool isRateLimitError) {
    if (!_formKey.currentState!.validate()) return;

    final phone = _phoneController.text.trim();
    final name = _nameController.text.trim();

    if (isRateLimitError) {
      _showOtpDialog(phone, name);
    } else {
      context.read<ReservationCubit>().requestGuestVerification(phone: phone);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReservationCubit, ReservationState>(
      listener: (context, state) {
        state.maybeWhen(
          otpRequestSuccess: (_) {
            final phone = _phoneController.text.trim();
            final name = _nameController.text.trim();
            _showOtpDialog(phone, name);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state.maybeWhen(otpRequestLoading: () => true, orElse: () => false);
        final hasError = state.maybeWhen(otpRequestError: (_) => true, orElse: () => false);
        final errorMessage = state.maybeWhen(
          otpRequestError: (error) => error.apiErrorModel.message ?? 'auth.error_sending_otp'.tr(),
          orElse: () => null,
        );
        final isRateLimitError = GuestFormValidator.isOtpRateLimitError(errorMessage);

        return Container(
          decoration: const BoxDecoration(
            color: ColorsManager.background,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BottomSheetHandle(),
                    Text('auth.guest_booking'.tr(), style: TextStyles.font24BlackBold),
                    verticalSpace(8),
                    Text('auth.guest_booking_subtitle'.tr(), style: TextStyles.font14GrayRegular),
                    verticalSpace(24),
                    if (isLoading) ...[
                      const _LoadingIndicator(),
                    ] else if (hasError && isRateLimitError) ...[
                      InfoBanner.rateLimit(errorMessage ?? 'auth.otp_already_sent_info'.tr()),
                      verticalSpace(12),
                      _EnterOtpButton(
                        onPressed: () {
                          final phone = _phoneController.text.trim();
                          final name = _nameController.text.trim();
                          if (phone.isNotEmpty && name.isNotEmpty) {
                            _showOtpDialog(phone, name);
                          }
                        },
                      ),
                      verticalSpace(16),
                    ] else if (hasError) ...[
                      InfoBanner.error(errorMessage ?? 'common.error'.tr()),
                      verticalSpace(16),
                    ],
                    _NameField(enabled: !isLoading),
                    verticalSpace(16),
                    _PhoneField(enabled: !isLoading),
                    verticalSpace(24),
                    _ActionButtons(
                      isLoading: isLoading,
                      isRateLimitError: isRateLimitError,
                      onCancel: () => context.pop(),
                      onContinue: () => _handleSubmit(isRateLimitError),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  const _LoadingIndicator();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const CircularProgressIndicator(color: ColorsManager.mainBlue),
          verticalSpace(16),
          Text('auth.sending_otp'.tr(), style: TextStyles.font14GrayRegular),
        ],
      ),
    );
  }
}

class _EnterOtpButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _EnterOtpButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.dialpad, size: 20),
        label: Text('auth.enter_otp_code'.tr(), style: TextStyles.font14DarkBlueMedium),
        style: TextButton.styleFrom(
          foregroundColor: ColorsManager.mainBlue,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          backgroundColor: ColorsManager.lightBlue.withAlpha(77),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  final bool enabled;

  const _NameField({required this.enabled});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'auth.full_name'.tr(),
      hintText: 'auth.enter_full_name'.tr(),
      enabled: enabled,
      validator: GuestFormValidator.validateName,
    );
  }
}

class _PhoneField extends StatelessWidget {
  final bool enabled;

  const _PhoneField({required this.enabled});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      label: 'auth.phone_number'.tr(),
      hintText: 'auth.enter_phone_number'.tr(),
      keyboardType: TextInputType.phone,
      enabled: enabled,
      validator: GuestFormValidator.validatePhone,
    );
  }
}

class _ActionButtons extends StatelessWidget {
  final bool isLoading;
  final bool isRateLimitError;
  final VoidCallback onCancel;
  final VoidCallback onContinue;

  const _ActionButtons({
    required this.isLoading,
    required this.isRateLimitError,
    required this.onCancel,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppOutlinedButton(
            text: 'common.cancel'.tr(),
            onPressed: isLoading ? null : onCancel,
          ),
        ),
        horizontalSpace(12),
        Expanded(
          child: AppPrimaryButton(
            text: 'common.continue'.tr(),
            onPressed: isLoading ? null : onContinue,
            isFullWidth: true,
            height: 48,
          ),
        ),
      ],
    );
  }
}
