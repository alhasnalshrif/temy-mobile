import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/reservations/logic/simple_multi_reservation_manager.dart';

class CompleteReservationCard extends StatelessWidget {
  const CompleteReservationCard({super.key});

  @override
  Widget build(BuildContext context) {
    final manager = MultiReservationManager();

    return ListenableBuilder(
      listenable: manager,
      builder: (context, _) {
        if (manager.reservations.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorsManager.lightBlue,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ColorsManager.mainBlue.withAlpha(20)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(5),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.receipt_long_rounded,
                  color: ColorsManager.mainBlue,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'home_screen.complete_reservation_title'.tr(),
                      style: TextStyles.font16DarkBold.copyWith(
                        fontSize: 14,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'home_screen.pending_reservations'.tr(
                        args: [manager.reservations.length.toString()],
                      ),
                      style: TextStyles.font14GrayRegular.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () {
                  if (manager.reservations.isNotEmpty) {
                    final lastReservation = manager.reservations.last;
                    manager.removeReservationAt(
                      manager.reservations.length - 1,
                    );
                    context.pushNamed(
                      AppRoutes.bookingConfirmationName,
                      extra: lastReservation,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.mainBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(0, 36),
                ),
                child: Text(
                  'home_screen.continue_booking'.tr(),
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
