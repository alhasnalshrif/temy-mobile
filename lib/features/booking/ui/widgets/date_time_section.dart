import 'package:flutter/material.dart';
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
      return DateFormat('EEE, MMM d, yyyy')
          .format(date); // e.g., Tue, Jul 2, 2024
    } catch (e) {
      return dateString; // Return original string if parsing fails
    }
  }

  // Helper function to format time (assuming HH:mm format)
  String _formatTime(String? timeString) {
    if (timeString == null) return 'No time';
    try {
      // Assuming the time string is like '14:30'
      final parts = timeString.split(':');
      if (parts.length == 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        final timeOfDay = TimeOfDay(hour: hour, minute: minute);
        // Format using context if available, otherwise default format
        // This requires passing BuildContext or using a static context helper
        // For simplicity, using a basic format here.
        final now = DateTime.now();
        final dt = DateTime(
            now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
        return DateFormat('h:mm a').format(dt); // e.g., 2:30 PM
      }
    } catch (e) {
      // Fallback if parsing fails
    }
    return timeString; // Return original string if formatting fails
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDate(booking.date);
    final formattedTime = _formatTime(booking.startTime);
    final durationText =
        booking.totalDuration != null ? '${booking.totalDuration} min' : 'N/A';

    return Row(
      children: [
        Image.asset(
          'assets/icons/calendar.png', // Consider using Icons.calendar_today_outlined
          height: 24,
          color: Colors.black54, // Match icon color scheme
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date & Time",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              '$formattedDate at $formattedTime ($durationText)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
