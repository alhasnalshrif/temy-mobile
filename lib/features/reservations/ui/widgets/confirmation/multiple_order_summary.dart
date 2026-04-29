import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';

part 'multiple_order_summary_impl.dart';

/// Multiple reservations order summary
class MultipleOrderSummary extends StatelessWidget {
  final List<ReservationArguments> reservations;
  final double grandTotal;
  final void Function(int index) onRemoveReservation;

  const MultipleOrderSummary({
    super.key,
    required this.reservations,
    required this.grandTotal,
    required this.onRemoveReservation,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'booking_confirmation.summary'.tr(
                args: [reservations.length.toString()],
              ),
              style: TextStyles.font16DarkBold,
            ),
            Text(
              "${grandTotal.toStringAsFixed(2)} ${'common.currency'.tr()}",
              style: TextStyles.font14DarkBlueMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorsManager.mainBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: reservations.length,
          itemBuilder: (context, index) {
            final isCurrentReservation = index == reservations.length - 1;
            return _ReservationCard(
              reservation: reservations[index],
              showRemoveButton: !isCurrentReservation,
              onRemove: () => onRemoveReservation(index),
            );
          },
        ),
        _GrandTotalCard(grandTotal: grandTotal),
      ],
    );
  }
}
