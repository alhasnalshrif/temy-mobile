import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/widgets/app_avatar.dart';
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
      margin: const EdgeInsets.symmetric(vertical: 12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.blackAlpha10,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Red accent element
          Positioned(
            top: 0,
            left: context.locale.languageCode == 'ar' ? 0 : null,
            right: context.locale.languageCode == 'ar' ? null : 0,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: ColorsManager.redAlpha90,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                    context.locale.languageCode == 'ar' ? 16 : 0,
                  ),
                  topRight: Radius.circular(
                    context.locale.languageCode == 'ar' ? 0 : 16,
                  ),
                  bottomRight: Radius.circular(
                    context.locale.languageCode == 'ar' ? 45 : 0,
                  ),
                  bottomLeft: Radius.circular(
                    context.locale.languageCode == 'ar' ? 0 : 45,
                  ),
                ),
              ),
            ),
          ),

          // Main content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row: Title
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: ColorsManager.whiteAlpha10,
                        shape: BoxShape.circle,
                      ),
                      child: Image(
                        image: const AssetImage('assets/icons/calendar.png'),
                        color: ColorsManager.red,
                        width: 16,
                        height: 16,
                      ),
                      // child: const Icon(
                      //   Icons.calendar_month_outlined,
                      //   color: Colors.white,
                      //   size: 16,
                      // ),
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

                verticalSpace(10),

                // Highlighted Time & Date Container
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: ColorsManager.whiteAlpha10,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.access_time_filled_rounded,
                        color: ColorsManager.red,
                        size: 18,
                      ),
                      horizontalSpace(8),
                      Text(
                        '$formattedDate • $formattedTime',
                        style: TextStyles.font13BlueRegular.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                verticalSpace(12),
                Divider(color: ColorsManager.whiteAlpha10, height: 1),
                verticalSpace(12),

                // Bottom Row: Barber Profile
                Row(
                  children: [
                    AppAvatar(
                      imageUrl: booking.barber?.avatar,
                      backgroundColor: Colors.grey[800],
                      borderColor: ColorsManager.red,
                      borderWidth: 1.5,
                      fallbackWidget: const Icon(Icons.person, color: Colors.white, size: 20),
                    ),
                    horizontalSpace(12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            barberName,
                            style: TextStyles.font16WhiteSemiBold,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            serviceName,
                            style: TextStyles.font13GrayRegular.copyWith(
                              color: Colors.white60,
                              fontSize: 12,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
