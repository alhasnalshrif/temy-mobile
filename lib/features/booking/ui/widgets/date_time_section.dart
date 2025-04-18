import 'package:flutter/material.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';

class DateTimeSection extends StatelessWidget {
  final BookingData booking;

  const DateTimeSection({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 24, color: Colors.black54),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Date & time",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  booking.date ?? 'No date available',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  booking.startTime?.toString() ?? 'No time available',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  booking.totalDuration?.toString() ?? 'No duration available',
                  style: TextStyle(
                    fontSize: 14,
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
