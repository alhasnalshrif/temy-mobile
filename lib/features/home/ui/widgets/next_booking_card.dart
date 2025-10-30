import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:temy_barber/features/booking/logic/booking_cubit.dart';
import 'package:temy_barber/features/booking/logic/booking_state.dart';

class NextBookingCard extends StatelessWidget {
  const NextBookingCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingCubit, BookingState>(
      builder: (context, state) {
        return state.maybeMap(
          bookingSuccess: (successState) {
            final activeBookings = successState.activeBookings;

            if (activeBookings.isEmpty) {
              return Container();
            }

            final nextBooking = activeBookings.first;
            return _buildBookingCard(context, nextBooking);
          },
          orElse: () {
            return Container();
          },
        );
      },
    );
  }

  Widget _buildBookingCard(BuildContext context, BookingData booking) {
    String formattedDate = '';
    String formattedTime = '';

    try {
      if (booking.date != null) {
        final date = DateFormat('yyyy-MM-dd').parse(booking.date!);
        formattedDate = DateFormat('EEE, MMM d').format(date);
      }

      if (booking.startTime != null) {
        final timeParts = booking.startTime!.split(':');
        if (timeParts.length >= 2) {
          final hour = int.tryParse(timeParts[0]) ?? 0;
          final minute = int.tryParse(timeParts[1]) ?? 0;
          final time = DateTime(2025, 1, 1, hour, minute);
          formattedTime = DateFormat('h:mm a').format(time);
        }
      }
    } catch (e) {
      formattedDate = booking.date ?? '';
      formattedTime = booking.startTime ?? '';
    }

    final barberName =
        booking.barber?.name ?? 'booking.default_barber_name'.tr();

    final serviceName = booking.services?.isNotEmpty == true
        ? booking.services!.first.name ?? 'booking.default_service'.tr()
        : 'booking.default_service'.tr();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16), // Increased border radius
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        // Added ClipRRect to ensure content respects the rounded corners
        borderRadius: BorderRadius.circular(16), // Same radius as container
        child: Stack(
          children: [
            // Red circle design element
            Positioned(
              top: -16,
              left: -16,
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // Main content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(
                            12,
                          ), // Rounded container for icon
                        ),
                        child: const Icon(
                          Icons.calendar_today_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      horizontalSpace(8),
                      Text(
                        'next_appointment'.tr(),
                        style: TextStyles.font14BlueSemiBold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        16,
                      ), // Increased border radius
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.access_time_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                        horizontalSpace(6),
                        Text(
                          '$formattedDate • $formattedTime',
                          style: TextStyles.font13BlueRegular.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(8),
                  Row(
                    children: [
                      // Barber Avatar with enhanced styling
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 2,
                          ), // Added border
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 8,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              booking.barber?.avatar != null &&
                                  booking.barber!.avatar!.isNotEmpty
                              ? NetworkImage(booking.barber!.avatar!)
                              : null,
                          backgroundColor: Colors.grey[300],
                          child:
                              booking.barber?.avatar == null ||
                                  booking.barber!.avatar!.isEmpty
                              ? const Icon(Icons.person, color: Colors.white)
                              : null,
                        ),
                      ),
                      horizontalSpace(12),
                      // Barber details
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            barberName,
                            style: TextStyles.font16WhiteSemiBold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          verticalSpace(4),
                          Text(
                            serviceName,
                            style: TextStyles.font13GrayRegular.copyWith(
                              color: Colors.white70,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
