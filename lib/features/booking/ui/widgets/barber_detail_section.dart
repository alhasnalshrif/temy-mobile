import 'package:flutter/material.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:easy_localization/easy_localization.dart';

class BarberDetailSection extends StatelessWidget {
  final BookingData booking;

  const BarberDetailSection({
    super.key,
    required this.booking,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.person, size: 24, color: Colors.black54),
            SizedBox(width: 12),
            Text(
              'Master barber',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Image.network(
              booking.barber?.avatar ?? 'https://via.placeholder.com/48',
              width: 48,
              height: 48,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            booking.barber?.name ?? 'Unknown Barber',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Text(booking.barber?.name ?? 'booking.default_specialty'.tr()),
        ),
      ],
    );
  }
}
