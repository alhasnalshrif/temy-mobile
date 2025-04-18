import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:temy_barber/features/booking/ui/widgets/barber_detail_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/barber_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/booking_status_stepper.dart';
import 'package:temy_barber/features/booking/ui/widgets/cancel_booking_button.dart';
import 'package:temy_barber/features/booking/ui/widgets/cancelled_indicator.dart';
import 'package:temy_barber/features/booking/ui/widgets/date_time_section.dart';
import 'package:temy_barber/features/booking/ui/widgets/feedback_button.dart';
import 'package:temy_barber/features/booking/ui/widgets/services_list_view.dart';

class BookingCard extends StatelessWidget {
  final BookingData booking;

  const BookingCard({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    bool isCompleted = booking.status == 'completed';
    bool isCancelled = booking.status == 'cancelled';
    bool isActive = !isCompleted && !isCancelled;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isActive)
            BookingStatusStepper(status: booking.status ?? 'pending'),
          if (isActive) verticalSpace(16),
          BarberSection(
            name: booking.barber?.name ?? 'Master piece Barbershop',
            avatarUrl: booking.barber?.avatar,
            // Add location and rating if available in BarberData
            location:
                'Location Placeholder', // Replace with actual data if available
            rating: '5.0', // Replace with actual data if available
            reviewCount: 24, // Replace with actual data if available
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
          if (isActive &&
              booking.status != 'confirmed') // Show cancel only if pending
            CancelBookingButton(
              onPressed: () {
                // TODO: Implement cancel booking functionality
                // Consider showing a confirmation dialog
              },
            ),
          if (isCompleted) const FeedbackButton(),
          if (isCancelled) const CancelledIndicator(),
        ],
      ),
    );
  }
}
