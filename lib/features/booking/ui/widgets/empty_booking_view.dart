import 'package:flutter/material.dart';

class EmptyBookingView extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback onPressed;

  const EmptyBookingView({
    super.key,
    this.message = 'You don\'t have any active bookings at the moment',
    this.buttonText = 'Book an Appointment',
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/calendar.png',
              height: 120,
              width: 120,
            ),
            const SizedBox(height: 16),
            Text(
              'No Bookings Found',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
