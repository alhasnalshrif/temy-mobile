import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';

/// Info row with label and value
class InvoiceInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const InvoiceInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyles.font13GrayRegular),
        Text(
          value,
          style: TextStyles.font14DarkBlueMedium.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

/// Section card with icon and title
class InvoiceSectionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;

  const InvoiceSectionCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor ?? ColorsManager.lightBlue),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: ColorsManager.mainBlue),
              const SizedBox(width: 8),
              Text(title, style: TextStyles.font14DarkBlueMedium),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

/// Service item for invoice
class InvoiceServiceItem extends StatelessWidget {
  final ServiceModel service;

  const InvoiceServiceItem({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              service.name,
              style: TextStyles.font14GrayRegular,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "${service.price.toInt()} EGP",
            style: TextStyles.font14DarkBlueMedium,
          ),
        ],
      ),
    );
  }
}

/// Guest notification banner
class GuestNotificationBanner extends StatelessWidget {
  final String? phone;

  const GuestNotificationBanner({super.key, this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF81C784)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'invoice.guest_booking'.tr(),
                  style: TextStyles.font14DarkBlueMedium.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text('invoice.guest_notification'.tr(), style: TextStyles.font13GrayRegular),
                if (phone != null) ...[
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.phone, size: 14, color: Color(0xFF4CAF50)),
                      const SizedBox(width: 6),
                      Text(
                        phone!,
                        style: TextStyles.font13GrayRegular.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Total card for invoice
class InvoiceTotalCard extends StatelessWidget {
  final double total;
  final bool isMultiple;

  const InvoiceTotalCard({
    super.key,
    required this.total,
    this.isMultiple = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            isMultiple ? 'common.grand_total'.tr() : 'invoice.total'.tr(),
            style: TextStyles.font16WhiteMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorsManager.black,
            ),
          ),
          Text(
            "${total.toInt()} EGP",
            style: TextStyles.font18WhiteSemiBold.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorsManager.black,
            ),
          ),
        ],
      ),
    );
  }
}

/// Queue info card for queue reservations
class QueueInfoCard extends StatelessWidget {
  final int? queueNumber;
  final int? queuePosition;

  const QueueInfoCard({
    super.key,
    this.queueNumber,
    this.queuePosition,
  });

  @override
  Widget build(BuildContext context) {
    final displayNumber = queueNumber ?? queuePosition;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.mainBlue.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorsManager.mainBlue.withAlpha(77)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.people_outline, size: 18, color: ColorsManager.mainBlue),
              const SizedBox(width: 8),
              Text('invoice.queue_info'.tr(), style: TextStyles.font14DarkBlueMedium),
            ],
          ),
          const SizedBox(height: 12),
          if (displayNumber != null)
            InvoiceInfoRow(label: 'invoice.queue_number'.tr(), value: "#$displayNumber"),
          if (queuePosition != null && queuePosition! > 0) ...[
            const SizedBox(height: 8),
            InvoiceInfoRow(label: 'invoice.people_before_you'.tr(), value: "${queuePosition! - 1}"),
          ],
        ],
      ),
    );
  }
}
