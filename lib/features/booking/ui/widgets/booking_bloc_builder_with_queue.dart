import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/logic/booking_state.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_card.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_shimmer.dart';
import 'package:temy_barber/features/booking/ui/widgets/queue_booking_card.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_tabs.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart'; // Import ResponsiveUtils

class BookingBlocBuilderWithQueue extends StatefulWidget {
  const BookingBlocBuilderWithQueue({super.key});

  @override
  State<BookingBlocBuilderWithQueue> createState() =>
      _BookingBlocBuilderWithQueueState();
}

class _BookingBlocBuilderWithQueueState
    extends State<BookingBlocBuilderWithQueue> {
  bool _showActiveBookings = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return state.maybeMap(
          bookingSuccess: (successState) {
            final activeBookings = successState.activeBookings;
            final historyBookings = successState.historyBookings;

            final bookingsToShow = _showActiveBookings
                ? activeBookings
                : historyBookings;

            // Separate queue and time-slot bookings
            final queueBookings = bookingsToShow
                .where((booking) => booking.isQueueReservation == true)
                .toList();
            final timeSlotBookings = bookingsToShow
                .where((booking) => booking.isQueueReservation != true)
                .toList();

            return Column(
              children: [
                // Tabs
                BookingTabs(
                  showActiveBookings: _showActiveBookings,
                  onActiveTap: () {
                    setState(() {
                      _showActiveBookings = true;
                    });
                  },
                  onHistoryTap: () {
                    setState(() {
                      _showActiveBookings = false;
                    });
                  },
                ),
                verticalSpace(8),

                // Show both queue and time-slot bookings
                if (bookingsToShow.isEmpty)
                  _buildEmptyView()
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Queue Bookings Section
                      if (queueBookings.isNotEmpty) ...[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'booking.queue_reservations'.tr(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                        if (ResponsiveUtils.isDesktop(context))
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 500,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio: 1.3,
                                ),
                            itemCount: queueBookings.length,
                            itemBuilder: (context, index) {
                              final booking = queueBookings[index];
                              return QueueBookingCard(
                                booking: booking,
                                onCancelBooking: () {
                                  _showCancelDialog(context, booking.id ?? '');
                                },
                              );
                            },
                          )
                        else
                          ...queueBookings.map(
                            (booking) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: QueueBookingCard(
                                booking: booking,
                                onCancelBooking: () {
                                  _showCancelDialog(context, booking.id ?? '');
                                },
                              ),
                            ),
                          ),
                        if (timeSlotBookings.isNotEmpty) verticalSpace(24),
                      ],

                      // Time-Slot Bookings Section
                      if (timeSlotBookings.isNotEmpty) ...[
                        if (queueBookings.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              'booking.timeslot_reservations'.tr(),
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                          ),
                        if (ResponsiveUtils.isDesktop(context))
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 500,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  childAspectRatio:
                                      1.1, // Adjusted for smaller cards
                                ),
                            itemCount: timeSlotBookings.length,
                            itemBuilder: (context, index) {
                              final booking = timeSlotBookings[index];
                              return BookingCard(booking: booking);
                            },
                          )
                        else
                          ...timeSlotBookings.map(
                            (booking) => Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: BookingCard(booking: booking),
                            ),
                          ),
                      ],
                    ],
                  ),
              ],
            );
          },
          bookingError: (errorState) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 60,
                  color: ColorsManager.red.withAlpha(200),
                ),
                verticalSpace(16),
                Text(
                  'booking.error_loading'.tr(),
                  style: const TextStyle(fontSize: 16),
                ),
                verticalSpace(8),
                ElevatedButton(
                  onPressed: () {
                    context.read<BookingCubit>().getBooking();
                  },
                  child: Text('booking.retry'.tr()),
                ),
              ],
            ),
          ),
          orElse: () => const BookingShimmer(),
        );
      },
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.event_busy,
              size: 80,
              color: ColorsManager.thirdfMain,
            ),
            verticalSpace(16),
            Text(
              _showActiveBookings
                  ? 'booking.no_active'.tr()
                  : 'booking.no_history'.tr(),
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showCancelDialog(BuildContext context, String bookingId) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('booking.cancel_title'.tr()),
          content: Text('booking.cancel_message'.tr()),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text('booking.no'.tr()),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                context.read<BookingCubit>().cancelBooking(bookingId);
              },
              child: Text(
                'booking.yes'.tr(),
                style: const TextStyle(color: ColorsManager.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
