import 'package:flutter/material.dart';

class RatingDisplay extends StatelessWidget {
  final double? rating;
  final int? reviewCount;

  const RatingDisplay({super.key, this.rating, this.reviewCount});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final displayRating = rating?.toStringAsFixed(1) ?? "N/A";
    final displayReviewCount = reviewCount ?? 0;

    return Row(
      children: [
        const Icon(Icons.star, color: Colors.amber, size: 18),
        const SizedBox(width: 4),
        Text(
          displayRating,
          style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(width: 4),
        Text(
          '($displayReviewCount Reviews)',
          style: textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
