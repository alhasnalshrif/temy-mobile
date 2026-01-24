import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/theme/colors.dart';

/// ----------------- ABOUT SCREEN -----------------
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;
    final titleStyle = TextStyles.font14DarkBlueMedium.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final bodyStyle = TextStyles.font14DarkBlueMedium;

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text('about'.tr()),
        backgroundColor: ColorsManager.mainBlue,
        centerTitle: isLargeScreen,
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isLargeScreen ? 800 : double.infinity,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(isLargeScreen ? 32 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _section(
                    title: 'About Temy Barber',
                    body:
                        'Temy Barber is your trusted app for booking barber and grooming services quickly and easily.',
                    titleStyle: titleStyle,
                    bodyStyle: bodyStyle,
                  ),
                  _section(
                    title: 'Our Mission',
                    body:
                        'We aim to provide seamless grooming experiences with top-rated professionals at your convenience.',
                    titleStyle: titleStyle,
                    bodyStyle: bodyStyle,
                  ),
                  _section(
                    title: 'Contact Us',
                    body: '''
📞 Phone: 01064067843
🌐 Website: www.temybarber.com
                ''',
                    titleStyle: titleStyle,
                    bodyStyle: bodyStyle,
                  ),
                ],
              ),
            ),
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
