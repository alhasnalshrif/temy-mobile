import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/logic/booking_state.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_card.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_tabs.dart';
import 'package:temy_barber/features/booking/ui/widgets/empty_booking_view.dart';
import 'package:temy_barber/features/booking/ui/widgets/error_booking_view.dart';

class BookingBlocBuilder extends StatefulWidget {
  const BookingBlocBuilder({super.key});

  @override
  State<BookingBlocBuilder> createState() => _BookingBlocBuilderState();
}

class _BookingBlocBuilderState extends State<BookingBlocBuilder> {
  bool _showActiveBookings = true; // State to manage which tab is selected

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return state.maybeMap(
          bookingSuccess: (successState) {
            final activeBookings = successState.activeBookings;
            final historyBookings = successState.historyBookings;
            final bookingsToShow =
                _showActiveBookings ? activeBookings : historyBookings;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                verticalSpace(16),
                if (bookingsToShow.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: EmptyBookingView(
                      message: _showActiveBookings
                          ? 'You don\'t have any active bookings at the moment'
                          : 'You don\'t have any past bookings yet.',
                      buttonText: _showActiveBookings
                          ? 'Book an Appointment'
                          : 'Explore Services',
                      onPressed: () {
                        if (_showActiveBookings) {
                          // TODO: Navigate to booking screen or refresh
                          context.read<BookingCubit>().getBooking();
                        } else {
                          // TODO: Navigate to services or home screen
                        }
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
          bookingLoading: (_) => const Center(
            child: CircularProgressIndicator(),
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
                child: EmptyBookingView(onPressed: () {
                  // Default action, e.g., refresh bookings
                  context.read<BookingCubit>().getBooking();
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
