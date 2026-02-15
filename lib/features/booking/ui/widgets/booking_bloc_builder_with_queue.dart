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
    return BlocConsumer<BookingCubit, BookingState>(
      listener: (context, state) {
        state.maybeMap(
          cancelBookingSuccess: (_) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('booking.cancel_success_message'.tr()),
                backgroundColor: Colors.green,
              ),
            );
          },
          cancelBookingError: (errorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  errorState.errorHandler.apiErrorModel.message ??
                      'booking.cancel_error_message'.tr(),
                ),
                backgroundColor: ColorsManager.red,
              ),
            );
            // Retry loading bookings to restore the list
            context.read<BookingCubit>().getBooking();
          },
          orElse: () {},
        );
      },
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
                        _buildResponsiveGrid(
                          context,
                          queueBookings,
                          (booking) => QueueBookingCard(
                            booking: booking,
                            onCancelBooking: () {
                              _showCancelDialog(context, booking.id ?? '');
                            },
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
                        _buildResponsiveGrid(
                          context,
                          timeSlotBookings,
                          (booking) => BookingCard(booking: booking),
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

  /// Builds a responsive grid that allows items to have variable heights
  Widget _buildResponsiveGrid(
    BuildContext context,
    List<dynamic> items,
    Widget Function(dynamic) itemBuilder,
  ) {
    if (!ResponsiveUtils.isDesktop(context)) {
      return Column(
        children: items
            .map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: itemBuilder(item),
              ),
            )
            .toList(),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // Use 500 as desired max width for a card
        int crossAxisCount = (width / 500).ceil();
        crossAxisCount = crossAxisCount < 2 ? 1 : crossAxisCount;

        const double spacing = 16.0;
        // Calculate item width accounting for spacing
        // Total spacing = (n - 1) * spacing
        final double totalSpacing = (crossAxisCount - 1) * spacing;
        final double itemWidth = (width - totalSpacing) / crossAxisCount;

        return Wrap(
          spacing: spacing,
          runSpacing: spacing,
          children: items.map((item) {
            return SizedBox(width: itemWidth, child: itemBuilder(item));
          }).toList(),
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
