import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';

/// Reusable service selection card
class ServiceSelectionCard extends StatelessWidget {
  final BarberService service;
  final bool isSelected;
  final VoidCallback onTap;

  const ServiceSelectionCard({
    super.key,
    required this.service,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected ? ColorsManager.mainBlue.withAlpha(10) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? ColorsManager.mainBlue : ColorsManager.lighterGray,
          width: isSelected ? 2 : 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                _buildCheckbox(),
                const SizedBox(width: 14),
                Expanded(child: _buildServiceInfo()),
                const SizedBox(width: 10),
                _buildPriceBadge(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckbox() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: isSelected ? ColorsManager.mainBlue : ColorsManager.moreLighterGray,
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? Colors.transparent : ColorsManager.gray,
        ),
      ),
      child: isSelected
          ? const Icon(Icons.check_rounded, color: Colors.white, size: 16)
          : null,
    );
  }

  Widget _buildServiceInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          service.name,
          style: TextStyles.font13DarkBlueRegular,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Row(
          children: [
            const Icon(Icons.access_time_rounded, size: 14, color: ColorsManager.gray),
            const SizedBox(width: 4),
            Text(
              'barber.duration'.tr(args: [service.duration.toString()]),
              style: TextStyles.font13GrayRegular,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: isSelected ? ColorsManager.mainBlue : ColorsManager.thirdfMain,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        'barber.price'.tr(args: [service.price.toString()]),
        style: isSelected ? TextStyles.font14WhiteSemiBold : TextStyles.font14BlueSemiBold,
      ),
    );
  }
}
