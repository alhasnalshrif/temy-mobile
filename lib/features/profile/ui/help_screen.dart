import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/theme/colors.dart';

/// ----------------- HELP SCREEN -----------------
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyles.font14DarkBlueMedium.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final bodyStyle = TextStyles.font14DarkBlueMedium;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('help'.tr()),
        backgroundColor: ColorsManager.mainBlue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _section(
                title: 'How to use the app',
                body: '''
- Browse services and select your preferred option.
- Book appointments easily through the app.
- Manage your profile and preferences.''',
                titleStyle: titleStyle,
                bodyStyle: bodyStyle,
              ),
              _section(
                title: 'Need more help?',
                body: '''
You can reach our support team any time.

📞 Phone: 01064067843
📧 Email: support@temybarber.com
                ''',
                titleStyle: titleStyle,
                bodyStyle: bodyStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/// ----------------- REUSABLE SECTION -----------------
Widget _section({
  required String title,
  required String body,
  required TextStyle titleStyle,
  required TextStyle bodyStyle,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: titleStyle),
        const SizedBox(height: 8),
        Text(body, style: bodyStyle),
      ],
    ),
  );
}
