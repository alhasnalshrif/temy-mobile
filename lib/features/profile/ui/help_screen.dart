import 'package:flutter/material.dart';
import 'package:temy_barber/features/profile/ui/content_screen.dart';

/// ----------------- HELP SCREEN -----------------
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ContentScreen(
      titleKey: 'help',
      sections: ContentData.getHelpSections(),
    );
  }
}
