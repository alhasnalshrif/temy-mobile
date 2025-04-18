import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';

class ServicesListViewItem extends StatelessWidget {
  final ServiceData? service;

  const ServicesListViewItem({
    super.key,
    this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        leading: CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(service?.imageCover ?? ''),
          backgroundColor: Colors.grey[200],
        ),
        title: Text(
          service?.name ?? '',
          style: TextStyles.font18DarkSemiBold,
        ),
        subtitle: Text(
          service?.description ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[600],
              ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'EGP ${service?.price ?? '0'}',
              style: TextStyles.font16DarkBold,
            ),
            const SizedBox(height: 4),
            Text('Min ${service?.duration ?? '0'}',
                style: TextStyles.font14DarkBlueMedium),
          ],
        ),
      ),
    );
  }
}
