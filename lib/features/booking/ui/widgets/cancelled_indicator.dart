import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CancelledIndicator extends StatelessWidget {
  const CancelledIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'booking.cancelled_status'.tr(),
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 0, 0),
          fontSize: 16,
        ),
      ),
    ); // Replace Color(0xFF000000) with the desired color
  }
}
