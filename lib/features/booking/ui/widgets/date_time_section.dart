import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:intl/intl.dart'; // Import intl package for date/time formatting
import 'package:temy_barber/core/utils/date_utils.dart' as app_date_utils;

class DateTimeSection extends StatelessWidget {
  final BookingData booking;

  const DateTimeSection({super.key, required this.booking});

  // Helper function to format date
  String _formatDate(String? dateString) {
    if (dateString == null) return 'No date';
    try {
      final date = DateTime.parse(dateString);
      return DateFormat('EEE, MMM d, yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  @override
  Widget build(BuildContext context) {
    final durationText = booking.totalDuration != null
        ? '${booking.totalDuration} min'
        : 'N/A';

    return Row(
      children: [
        Image.asset(
          'assets/icons/calendar.png',
          height: 24,
          color: ColorsManager.mainBlue,
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date & Time",
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              // space between date and time
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(booking.date),
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
                const SizedBox(width: 12),
                Text(
                  'at ${booking.startTime != null ? app_date_utils.formatTimeOfDayString(booking.startTime!, locale: 'en_US') : 'No time'} ($durationText)',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
