import 'package:flutter/material.dart';
import 'package:temy_barber/features/profile/ui/content_screen.dart';

/// ----------------- ABOUT SCREEN -----------------
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentScreen(
      titleKey: 'about',
      sections: ContentData.getAboutSections(),
    );
  }
}
