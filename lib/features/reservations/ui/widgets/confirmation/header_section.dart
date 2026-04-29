import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';

/// Header widget showing review details info
class ConfirmationHeader extends StatelessWidget {
  const ConfirmationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline,
            size: 24,
            color: ColorsManager.mainBlue,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'booking_confirmation.review_details'.tr(),
              style: TextStyles.font14DarkBlueMedium,
            ),
          ),
        ],
      ),
    );
  }
}
