import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';

/// Validation logic for guest form
class GuestFormValidator {
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.name_required'.tr();
    }
    if (value.length < 3) {
      return 'auth.name_too_short'.tr();
    }
    return null;
  }

  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'auth.phone_required'.tr();
    }
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) {
      return 'auth.phone_invalid'.tr();
    }
    return null;
  }

  static bool isOtpRateLimitError(String? message) {
    if (message == null || message.isEmpty) return false;
    final normalized = message.toLowerCase();
    return normalized.contains('already sent') ||
        message.contains('تم إرسال رمز التحقق بالفعل') ||
        message.contains('يرجى الانتظار قبل طلب رمز جديد');
  }
}

/// Reusable text input field for forms
class AppTextField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final bool enabled;
  final String? Function(String?)? validator;
  final int maxLines;

  const AppTextField({
    super.key,
    this.label,
    this.hintText,
    this.controller,
    this.keyboardType,
    this.enabled = true,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: TextStyles.font14DarkBlueMedium),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          enabled: enabled,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
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
              borderSide: const BorderSide(color: ColorsManager.mainBlue, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: ColorsManager.red, width: 1.3),
            ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}

/// Info banner for displaying messages
class InfoBanner extends StatelessWidget {
  final String message;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final Color? borderColor;

  const InfoBanner({
    super.key,
    required this.message,
    required this.icon,
    this.backgroundColor = ColorsManager.lightBlue,
    this.iconColor = ColorsManager.mainBlue,
    this.textColor = ColorsManager.darkBlue,
    this.borderColor,
  });

  factory InfoBanner.error(String message) {
    return InfoBanner(
      message: message,
      icon: Icons.error_outline,
      backgroundColor: ColorsManager.red.withAlpha(26),
      iconColor: ColorsManager.red,
      textColor: ColorsManager.red,
      borderColor: ColorsManager.red.withAlpha(77),
    );
  }

  factory InfoBanner.rateLimit(String message) {
    return InfoBanner(
      message: message,
      icon: Icons.info_outline,
      borderColor: ColorsManager.mainBlue.withAlpha(77),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: borderColor != null ? Border.all(color: borderColor!) : null,
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyles.font14GrayRegular.copyWith(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}

/// Bottom sheet drag handle
class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 40,
        height: 4,
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: ColorsManager.gray,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
