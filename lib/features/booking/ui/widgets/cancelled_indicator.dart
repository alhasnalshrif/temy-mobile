import 'package:flutter/material.dart';

class CancelledIndicator extends StatelessWidget {
  const CancelledIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Chip(
        label: const Text('Cancelled'),
        backgroundColor: Colors.red[100],
        labelStyle:
            TextStyle(color: Colors.red[700], fontWeight: FontWeight.bold),
        avatar: Icon(Icons.cancel_outlined, color: Colors.red[700], size: 18),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}
