import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/logic/booking_state.dart';
import 'package:temy_barber/features/booking/ui/widgets/barber_detail_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/barber_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/cancel_booking_button.dart';
import 'package:temy_barber/features/booking/ui/widgets/services_list_view.dart';
import 'package:temy_barber/features/booking/ui/widgets/date_time_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/empty_booking_view.dart';
import 'package:temy_barber/features/booking/ui/widgets/error_booking_view.dart';

class BookingBlocBuilder extends StatelessWidget {
  const BookingBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return state.maybeMap(
          bookingSuccess: (successState) {
            final bookingData =
                successState.bookingResponseModel.bookingDataList;
            if (bookingData != null && bookingData.isNotEmpty) {
              final booking = bookingData.first;
              print('booking.services: ${booking.services}');
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Barber Section
                    BarberSection(
                      name: booking.barber?.name ?? 'Master piece Barbershop',
                      avatarUrl: booking.barber?.avatar,
                    ),

                    // Cancel button
                    CancelBookingButton(
                      onPressed: () {
                        // TODO: Implement cancel booking functionality
                      },
                    ),

                    // Date & time
                    DateTimeSection(booking: booking),

                    verticalSpace(20),

                    // Service selected
                    // ServiceSection(booking: booking),
                    ServicesListView(booking: booking.services ?? []),
                    verticalSpace(20),

                    // Master barber
                    BarberDetailSection(booking: booking),
                  ],
                ),
              );
            } else {
              return const EmptyBookingView();
            }
          },
          bookingLoading: (_) => const Center(
            child: CircularProgressIndicator(),
          ),
          bookingError: (_) => const ErrorBookingView(),
          orElse: () => const EmptyBookingView(),
        );
      },
    );
  }
}
