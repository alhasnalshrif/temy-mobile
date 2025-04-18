import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';

class FeedbackButton extends StatelessWidget {
  const FeedbackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton.icon(
        icon: const Icon(Icons.rate_review_outlined, size: 18),
        label: const Text('Leave Feedback'),
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorsManager.mainBlue,
          side: const BorderSide(color: ColorsManager.mainBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        ),
        onPressed: () {
          // TODO: Implement leave feedback action
        },
      ),
    );
  }
}
