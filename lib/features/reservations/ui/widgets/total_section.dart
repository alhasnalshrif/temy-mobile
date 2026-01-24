import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/features/reservations/ui/widgets/common_widgets.dart';

/// Displays the total price summary for the reservation
class TotalSection extends StatelessWidget {
  final double totalPrice;

  const TotalSection({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'common.total'.tr(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          _buildPriceDisplay(),
        ],
      ),
    );
  }

  Widget _buildPriceDisplay() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          totalPrice.toStringAsFixed(0),
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: ColorsManager.mainBlue,
          ),
        ),
        const Text(
          ' EGP',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: ColorsManager.mainBlue,
          ),
        ),
      ],
    );
  }
}
