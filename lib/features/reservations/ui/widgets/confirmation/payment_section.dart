import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';

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

/// Payment info section widget
class PaymentInfoSection extends StatelessWidget {
  const PaymentInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
    return _ConfirmationCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorsManager.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.payments_outlined,
              color: ColorsManager.mainBlue,
              size: 18,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'booking_confirmation.payment_on_arrival'.tr(),
            style: TextStyles.font14DarkBlueMedium,
          ),
          const Spacer(),
          const Icon(
            Icons.check_circle,
            color: ColorsManager.mainBlue,
            size: 18,
          ),
        ],
      ),
    );
  }
}
