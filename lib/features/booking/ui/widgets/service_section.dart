import 'package:flutter/material.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';

class ServiceSection extends StatelessWidget {
  final BookingData booking;

  const ServiceSection({
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
            Icon(Icons.content_cut, size: 24, color: Colors.black54),
            SizedBox(width: 12),
            Text(
              'Service selected',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Basic Haircut
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
            width: 48,
            height: 48,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://via.placeholder.com/48',
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: const Text(
            'Basic haircut',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: const Text('Basic haircut & vitaminx'),
        ),
        // Massage
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: SizedBox(
            width: 48,
            height: 48,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://via.placeholder.com/48',
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: const Text(
            'Massage',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: const Text('Extra massage'),
        ),
      ],
    );
  }
}
