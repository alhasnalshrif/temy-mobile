import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/ui/widgets/barber_detail_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/barber_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_status_stepper.dart';
import 'package:temy_barber/features/booking/ui/widgets/cancel_booking_button.dart';
import 'package:temy_barber/features/booking/ui/widgets/cancelled_indicator.dart';
import 'package:temy_barber/features/booking/ui/widgets/date_time_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/services_list_view.dart';

class BookingCard extends StatelessWidget {
  final BookingData booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    bool isCompleted = booking.status == 'completed';
    bool isCancelled = booking.status == 'cancelled';
    bool isActive = !isCompleted && !isCancelled;
    bool isPending = booking.status == 'pending';

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isActive)
            BookingStatusStepper(status: booking.status ?? 'pending'),
          if (isActive) verticalSpace(16),
          BarberSection(
            name: booking.barber?.name ?? 'booking.default_barber_name'.tr(),
            avatarUrl: booking.barber?.avatar,
            location: 'booking.default_location'.tr(),
            rating: '5.0',
            reviewCount: 24, 
          ),
          verticalSpace(16),
          const Divider(),
          verticalSpace(16),
          DateTimeSection(booking: booking),
          verticalSpace(16),
          ServicesListView(booking: booking.services ?? []),
          verticalSpace(16),
          BarberDetailSection(booking: booking),
          verticalSpace(16),
          if (isPending)
            CancelBookingButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0)),
                  ),
                  backgroundColor: Colors.white,
                  builder: (BuildContext dialogContext) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(dialogContext).viewInsets.bottom,
                        left: 16.0,
                        right: 16.0,
                        top: 16.0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Title
                          Text(
                            'booking.cancel_title'.tr(),
                            style: Theme.of(dialogContext)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12.0),
                          // Description
                          Text(
                            'booking.cancel_message'.tr(),
                            style: Theme.of(dialogContext)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Colors.black54,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24.0),
                          // Buttons
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () =>
                                      Navigator.of(dialogContext).pop(),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    side: const BorderSide(color: Colors.grey),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text(
                                    'booking.keep_booking'.tr(),
                                    style: Theme.of(dialogContext)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: Colors.black87,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12.0),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                    if (booking.id != null) {
                                      context
                                          .read<BookingCubit>()
                                          .cancelBooking(booking.id!);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              'booking.error_cancel_no_id'
                                                  .tr()),
                                          backgroundColor: Colors.redAccent,
                                        ),
                                      );
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12.0),
                                    backgroundColor: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  child: Text(
                                    'booking.confirm_cancel'.tr(),
                                    style: Theme.of(dialogContext)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          if (isCancelled) const CancelledIndicator(),
        ],
      ),
    );
  }
}
