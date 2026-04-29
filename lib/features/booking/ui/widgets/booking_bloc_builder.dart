import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/logic/booking_state.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_card.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_shimmer.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_tabs.dart';
import 'package:temy_barber/features/booking/ui/widgets/empty_booking_view.dart';
import 'package:temy_barber/features/booking/ui/widgets/error_booking_view.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';

class BookingBlocBuilder extends StatelessWidget {
  const BookingBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return state.maybeMap(
          bookingSuccess: (successState) {
            final bookingsToShow = context.read<BookingCubit>().getFilteredBookings();
            final showActiveBookings = successState.showActiveBookings;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BookingTabs(
                  showActiveBookings: showActiveBookings,
                  onActiveTap: () {
                    if (!showActiveBookings) {
                      context.read<BookingCubit>().toggleBookingTab(true);
                    }
                  },
                  onHistoryTap: () {
                    if (showActiveBookings) {
                      context.read<BookingCubit>().toggleBookingTab(false);
                    }
                  },
                ),
                verticalSpace(16),
                if (bookingsToShow.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: EmptyBookingView(
                      message: showActiveBookings
                          ? 'booking.empty_active'.tr()
                          : 'booking.empty_history'.tr(),
                      buttonText: showActiveBookings
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
                BookingTabs(
                  showActiveBookings: true,
                  onActiveTap: () {},
                  onHistoryTap: () {},
                ),
                verticalSpace(16),
                const BookingShimmer(
                  
                ),
              ],
            ),
          ),
          bookingError: (_) => const ErrorBookingView(),
          orElse: () => Column(
            children: [
              BookingTabs(
                showActiveBookings: true,
                onActiveTap: () {},
                onHistoryTap: () {},
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
