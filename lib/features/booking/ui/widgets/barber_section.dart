import 'package:flutter/material.dart';
import 'package:temy_barber/core/widgets/app_avatar.dart';

class BarberSection extends StatelessWidget {
  final String name;
  final String? avatarUrl;
  final String location;
  final String rating;
  final int reviewCount;

  const BarberSection({
    super.key,
    required this.name,
    this.avatarUrl,
    required this.location,
    required this.rating,
    required this.reviewCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppAvatar(
          imageUrl: avatarUrl,
          radius: 28,
          fallbackWidget: const Icon(Icons.store, color: Colors.grey, size: 28),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    '$rating ($reviewCount)',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
