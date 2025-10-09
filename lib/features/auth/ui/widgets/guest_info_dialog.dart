import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/app_text_button.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorsManager.background,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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

                // Name field
                Text(
                  'auth.full_name'.tr(),
                  style: TextStyles.font14DarkBlueMedium,
                ),
                verticalSpace(8),
                TextFormField(
                  controller: _nameController,
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
                      child: AppTextButton(
                        buttonText: 'common.continue'.tr(),
                        textStyle: TextStyles.font16WhiteSemiBold,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            final guestInfo = GuestInfo(
                              name: _nameController.text.trim(),
                              phone: _phoneController.text.trim(),
                            );
                            Navigator.pop(context, guestInfo);
                          }
                        },
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
