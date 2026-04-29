import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/app_avatar.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';

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

class BarberInfoSection extends StatelessWidget {
  final BarberDetailData? barberData;

  const BarberInfoSection({super.key, required this.barberData});

  @override
  Widget build(BuildContext context) {
    if (barberData == null) return const SizedBox.shrink();

    return _ConfirmationCard(
      child: Row(
        children: [
          AppAvatar(imageUrl: barberData?.avatar, radius: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "${'booking_confirmation.barber_label'.tr()}: ${barberData?.name ?? 'booking_confirmation.unknown_barber'.tr()}",
              style: TextStyles.font14DarkBlueMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
