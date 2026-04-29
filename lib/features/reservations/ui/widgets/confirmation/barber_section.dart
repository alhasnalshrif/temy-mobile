import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';

/// Barber avatar widget
class _BarberAvatar extends StatelessWidget {
  final String? avatarUrl;

  const _BarberAvatar({this.avatarUrl});

  bool get _hasValidAvatar =>
      avatarUrl != null && avatarUrl!.isNotEmpty && avatarUrl != 'null';

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: Colors.grey.shade100,
      backgroundImage: _hasValidAvatar ? NetworkImage(avatarUrl!) : null,
      onBackgroundImageError: _hasValidAvatar
          ? (exception, stackTrace) {
              // Handle network errors gracefully
            }
          : null,
      child: !_hasValidAvatar
          ? const Icon(Icons.person, size: 20, color: Colors.grey)
          : null,
    );
  }
}

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

/// Barber info section widget
class BarberInfoSection extends StatelessWidget {
  final BarberDetailData? barberData;

  const BarberInfoSection({super.key, required this.barberData});

  @override
  Widget build(BuildContext context) {
    if (barberData == null) return const SizedBox.shrink();

    return _ConfirmationCard(
      child: Row(
        children: [
          _BarberAvatar(avatarUrl: barberData?.avatar),
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
