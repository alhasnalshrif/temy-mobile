import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:intl/intl.dart'; // Import intl package for date/time formatting

class DateTimeSection extends StatelessWidget {
  final BookingData booking;

  const DateTimeSection({
    super.key,
    required this.booking,
  });

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

  String _formatTime(String? timeString) {
    if (timeString == null) return 'No time';
    try {
      final parts = timeString.split(':');
      if (parts.length == 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final timeOfDay = TimeOfDay(hour: hour, minute: minute);

        final now = DateTime.now();
        final dt = DateTime(
            now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
        return DateFormat('h:mm a').format(dt); // e.g., 2:30 PM
      }
    } catch (e) {}
    return timeString;
  }

  @override
  Widget build(BuildContext context) {
    final durationText =
        booking.totalDuration != null ? '${booking.totalDuration} min' : 'N/A';

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
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'at ${booking.startTime} ($durationText)',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
