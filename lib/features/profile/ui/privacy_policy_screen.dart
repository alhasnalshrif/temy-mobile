import 'package:flutter/material.dart';
import 'package:temy_barber/features/profile/ui/content_screen.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentScreen(
      titleKey: 'privacy',
      sections: ContentData.getPrivacyPolicySections(),
    );
  }
}
