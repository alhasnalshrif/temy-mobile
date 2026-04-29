import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';

/// Info card for confirmation sections
class _ConfirmationCard extends StatelessWidget {
  final Widget child;

  const _ConfirmationCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.lightBlue),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: child,
    );
  }
}

/// Services list widget
class _ServicesList extends StatelessWidget {
  final List<BarberService> services;

  const _ServicesList({required this.services});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      separatorBuilder: (_, __) =>
          const Divider(height: 12, color: ColorsManager.lightBlue),
      itemBuilder: (context, index) {
        final service = services[index];
        return Row(
          children: [
            Expanded(
              child: Text(service.name, style: TextStyles.font14DarkBlueMedium),
            ),
            Text(
              "${service.duration} ${'booking.min'.tr()}",
              style: TextStyles.font14GrayRegular.copyWith(fontSize: 12),
            ),
            const SizedBox(width: 12),
            Text(
              "${service.price.toStringAsFixed(2)} ${'common.currency'.tr()}",
              style: TextStyles.font14DarkBlueMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      },
    );
  }
}

/// Total row widget
class _TotalRow extends StatelessWidget {
  final String label;
  final double amount;

  const _TotalRow({required this.label, required this.amount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyles.font16DarkBold),
        Text(
          "${amount.toStringAsFixed(2)} ${'common.currency'.tr()}",
          style: TextStyles.font16DarkBold.copyWith(
            color: ColorsManager.mainBlue,
          ),
        ),
      ],
    );
  }
}

/// Single reservation order summary
class SingleOrderSummary extends StatelessWidget {
  final ReservationArguments arguments;

  const SingleOrderSummary({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'booking_confirmation.summary_services'.tr(),
          style: TextStyles.font16DarkBold,
        ),
        const SizedBox(height: 12),
        _ConfirmationCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ServicesList(services: arguments.selectedServices),
              const Divider(height: 24, color: ColorsManager.lightBlue),
              _TotalRow(
                label: 'booking_confirmation.total_final'.tr(),
                amount: arguments.totalPrice,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
