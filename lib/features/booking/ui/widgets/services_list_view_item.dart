import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';

class ServicesListViewItem extends StatelessWidget {
  final ServiceData? service;

  const ServicesListViewItem({super.key, this.service});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      title: Text(service?.name ?? '', style: TextStyles.font14BlueBold),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'EGP ${service?.price ?? '0'}',
            style: TextStyles.font14BlueBold,
          ),
          const SizedBox(height: 4),
          Text(
            'Min ${service?.duration ?? '0'}',
            style: TextStyles.font14DarkBlueMedium,
          ),
        ],
      ),
    );
  }
}
