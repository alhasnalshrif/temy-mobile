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
    // Access the singleton
    final manager = MultiReservationManager();

    return ListenableBuilder(
      listenable: manager,
      builder: (context, _) {
        // If there are no reservations, don't show the card
        if (manager.reservations.isEmpty) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: ColorsManager.lightBlue,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'home_screen.complete_reservation_title'.tr(),
                          style: TextStyles.font16DarkBold,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'home_screen.pending_reservations'.tr(
                            args: [manager.reservations.length.toString()],
                          ),
                          style: TextStyles.font14GrayRegular,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (manager.reservations.isNotEmpty) {
                        // Get the last reservation to pass as "current"
                        final lastReservation = manager.reservations.last;

                        // We remove it from the list because BookingConfirmation
                        // treats the passed argument as a *new* reservation to be added.
                        // If we don't remove it, it will be duplicated (one in existing list, one as new arg).
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      textStyle: TextStyles.font14DarkBlueMedium.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    child: Text('home_screen.continue_booking'.tr()),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
