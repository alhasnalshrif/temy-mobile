import 'package:flutter/material.dart';

class CancelledIndicator extends StatelessWidget {
  const CancelledIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text('Cancelled',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 0, 0),
                fontSize:
                    16))); // Replace Color(0xFF000000) with the desired color
  }
}
