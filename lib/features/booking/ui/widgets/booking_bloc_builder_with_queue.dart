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
import 'package:temy_barber/core/utils/responsive_utils.dart';
import 'package:temy_barber/core/widgets/snackbar_helper.dart';
import 'package:temy_barber/core/widgets/cancel_confirmation_dialog.dart';
import 'package:temy_barber/core/widgets/error_retry_view.dart'; // Import ResponsiveUtils

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
            SnackbarHelper.showSuccess(context, 'booking.cancel_success_message'.tr());
          },
          cancelBookingError: (errorState) {
            SnackbarHelper.showError(
              context,
              errorState.errorHandler.apiErrorModel.message ?? 'booking.cancel_error_message'.tr(),
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
          bookingError: (errorState) => ErrorRetryView(
            message: 'booking.error_loading'.tr(),
            onRetry: () => context.read<BookingCubit>().getBooking(),
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
    CancelConfirmationDialog.show(context, onConfirm: () {
      context.read<BookingCubit>().cancelBooking(bookingId);
    });
  }
}
