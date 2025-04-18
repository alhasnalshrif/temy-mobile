import 'package:flutter/material.dart';

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
        CircleAvatar(
          radius: 28,
          backgroundImage: (avatarUrl != null && avatarUrl!.isNotEmpty)
              ? NetworkImage(avatarUrl!)
              : null,
          backgroundColor: Colors.grey[200],
          child: (avatarUrl == null || avatarUrl!.isEmpty)
              ? const Icon(Icons.store, color: Colors.grey)
              : null,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      location, // Use the passed location
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    '$rating ($reviewCount)', // Use passed rating and review count
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Optional: Add a trailing element like a favorite button if needed
        // Icon(Icons.favorite_border, color: Colors.grey),
      ],
    );
  }
}
