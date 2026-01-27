import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart'; // Add BookingData model
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/logic/booking_state.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_card.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_shimmer.dart'; // Import optimized shimmer
import 'package:temy_barber/features/booking/ui/widgets/booking_tabs.dart';
import 'package:temy_barber/features/booking/ui/widgets/empty_booking_view.dart';
import 'package:temy_barber/features/booking/ui/widgets/error_booking_view.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';

class BookingBlocBuilder extends StatefulWidget {
  const BookingBlocBuilder({super.key});

  @override
  State<BookingBlocBuilder> createState() => _BookingBlocBuilderState();
}

class _BookingBlocBuilderState extends State<BookingBlocBuilder> {
  bool _showActiveBookings = true;
  String _selectedStatus = "all"; // Default to show all statuses

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return state.maybeMap(
          bookingSuccess: (successState) {
            final activeBookings = successState.activeBookings;
            final historyBookings = successState.historyBookings;

            // Filter by status if a specific status is selected
            List<BookingData> bookingsToShow;

            if (_showActiveBookings) {
              bookingsToShow = activeBookings;
              if (_selectedStatus != "all") {
                bookingsToShow = bookingsToShow
                    .where((booking) => booking.status == _selectedStatus)
                    .toList();
              }
            } else {
              bookingsToShow = historyBookings;
              if (_selectedStatus != "all") {
                bookingsToShow = bookingsToShow
                    .where((booking) => booking.status == _selectedStatus)
                    .toList();
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingTabs(
                  showActiveBookings: _showActiveBookings,
                  onActiveTap: () {
                    if (!_showActiveBookings) {
                      setState(() {
                        _showActiveBookings = true;
                        _selectedStatus =
                            "all"; // Reset filter when switching tabs
                      });
                    }
                  },
                  onHistoryTap: () {
                    if (_showActiveBookings) {
                      setState(() {
                        _showActiveBookings = false;
                        _selectedStatus =
                            "all"; // Reset filter when switching tabs
                      });
                    }
                  },
                ),
                verticalSpace(16),

                // Single booking status stepper for filtering
                verticalSpace(16),
                if (bookingsToShow.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: EmptyBookingView(
                      message: _showActiveBookings
                          ? 'booking.empty_active'.tr()
                          : 'booking.empty_history'.tr(),
                      buttonText: _showActiveBookings
                          ? 'booking.book_appointment'.tr()
                          : 'booking.explore_services'.tr(),
                      onPressed: () {
                        context.goNamed(AppRoutes.homeName);
                      },
                    ),
                  )
                else
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bookingsToShow.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    separatorBuilder: (context, index) => verticalSpace(24),
                    itemBuilder: (context, index) {
                      final booking = bookingsToShow[index];
                      return BookingCard(booking: booking);
                    },
                  ),
              ],
            );
          },
          bookingLoading: (_) => SingleChildScrollView(
            child: Column(
              children: [
                // Show the same tabs UI as the success state for consistency
                BookingTabs(
                  showActiveBookings: _showActiveBookings,
                  onActiveTap: () {
                    if (!_showActiveBookings) {
                      setState(() => _showActiveBookings = true);
                    }
                  },
                  onHistoryTap: () {
                    if (_showActiveBookings) {
                      setState(() => _showActiveBookings = false);
                    }
                  },
                ),
                verticalSpace(16),
                // Use the shimmer with properties matching current state
                BookingShimmer(
                  showActiveBookings: _showActiveBookings,
                  showStatusStepper: _showActiveBookings,
                ),
              ],
            ),
          ),
          bookingError: (_) => const ErrorBookingView(),
          orElse: () => Column(
            children: [
              BookingTabs(
                showActiveBookings: _showActiveBookings,
                onActiveTap: () {
                  if (!_showActiveBookings) {
                    setState(() => _showActiveBookings = true);
                  }
                },
                onHistoryTap: () {
                  if (_showActiveBookings) {
                    setState(() => _showActiveBookings = false);
                  }
                },
              ),
              verticalSpace(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: EmptyBookingView(
                  onPressed: () {
                    context.read<BookingCubit>().getBooking();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
