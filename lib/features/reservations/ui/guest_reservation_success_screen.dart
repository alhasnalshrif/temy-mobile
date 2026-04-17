import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';

class GuestReservationSuccessScreen extends StatelessWidget {
  final ReservationResponseModel reservation;

  const GuestReservationSuccessScreen({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    final reservationData = reservation.data;

    return Scaffold(
      backgroundColor: ColorsManager.mainBlue,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorsManager.mainBlue,
              Color(0xFF0D47A1),
              Color(0xFFF8FBFF),
            ],
            stops: [0.0, 0.42, 0.42],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () => context.goNamed(AppRoutes.homeName),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(230),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(26),
                        blurRadius: 24,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 52,
                    color: ColorsManager.mainBlue,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'invoice.booking_success'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyles.font24BlackBold.copyWith(
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'invoice.guest_notification'.tr(),
                  textAlign: TextAlign.center,
                  style: TextStyles.font14GrayRegular.copyWith(
                    color: Colors.white.withAlpha(222),
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(18),
                        blurRadius: 30,
                        offset: const Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InfoRow(
                        icon: Icons.person_outline,
                        label: 'invoice.barber'.tr(),
                        value: reservationData.barber.name,
                      ),
                      const SizedBox(height: 14),
                      _InfoRow(
                        icon: Icons.event_outlined,
                        label: 'invoice.appointment_date'.tr(),
                        value: reservationData.date,
                      ),
                      const SizedBox(height: 14),
                      _InfoRow(
                        icon: Icons.schedule_outlined,
                        label: 'invoice.time'.tr(),
                        value: reservationData.startTime,
                      ),
                      const SizedBox(height: 14),
                      _InfoRow(
                        icon: Icons.content_cut,
                        label: 'invoice.services'.tr(),
                        value: reservationData.services
                            .map((service) => service.name)
                            .join(', '),
                      ),
                      if (reservationData.userPhone != null) ...[
                        const SizedBox(height: 14),
                        _InfoRow(
                          icon: Icons.phone_outlined,
                          label: 'auth.phone_number'.tr(),
                          value: reservationData.userPhone!,
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () => context.goNamed(
                      AppRoutes.invoiceName,
                      extra: reservation,
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: ColorsManager.mainBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      'invoice.view_invoice'.tr(),
                      style: TextStyles.font16DarkBold.copyWith(
                        color: ColorsManager.mainBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => context.goNamed(AppRoutes.homeName),
                  child: Text(
                    'invoice.back_to_home'.tr(),
                    style: TextStyles.font14GrayRegular.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: ColorsManager.lightBlue.withAlpha(160),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: ColorsManager.mainBlue, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyles.font13GrayRegular.copyWith(
                  color: ColorsManager.gray,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyles.font14DarkBlueMedium.copyWith(height: 1.35),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
