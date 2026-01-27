import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';

/// Widget displaying queue mode information when queue booking is enabled
class QueueModeSection extends StatelessWidget {
  const QueueModeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.mainBlue.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorsManager.mainBlue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 12),
          _buildDescription(),
          const SizedBox(height: 8),
          _buildBenefits(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        const Icon(
          Icons.people_outline,
          color: ColorsManager.mainBlue,
          size: 24,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'booking.queue_mode'.tr(),
            style: TextStyles.font18DarkBlueBold.copyWith(
              color: ColorsManager.mainBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Text(
      'booking.queue_mode_description'.tr(),
      style: TextStyles.font14GrayRegular,
    );
  }

  Widget _buildBenefits() {
    return Text(
      '${'booking.queue_mode_benefit_1'.tr()}\n'
      '${'booking.queue_mode_benefit_2'.tr()}\n',
      style: TextStyles.font14GrayRegular.copyWith(height: 1.5),
    );
  }
}
