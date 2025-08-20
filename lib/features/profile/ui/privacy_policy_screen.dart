import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/theme/colors.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final titleStyle = TextStyles.font14DarkBlueMedium.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    final bodyStyle = TextStyles.font14DarkBlueMedium;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'privacy'.tr(),
          style: const TextStyle(color: Colors.white),
        ),
        // the arrow white
        leading: const Icon(Icons.arrow_back, color: Colors.white),
        backgroundColor: ColorsManager.mainBlue,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _section(
                title: '1. Information We Collect',
                body: '''
- Personal information you provide: name, phone number, email, profile picture.
- Usage information: app usage, device identifiers, crash reports.''',
                titleStyle: titleStyle,
                bodyStyle: bodyStyle,
              ),
              _section(
                title: '2. How We Use Information',
                body: '''
- To operate and improve the app, provide features, and communicate with you.
- To detect, prevent, and address technical issues and abuse.''',
                titleStyle: titleStyle,
                bodyStyle: bodyStyle,
              ),
              _section(
                title: '3. Sharing',
                body:
                    'We do not sell your personal information. We may share with service providers who perform services on our behalf.',
                titleStyle: titleStyle,
                bodyStyle: bodyStyle,
              ),
              _section(
                title: '4. Security',
                body:
                    'We take reasonable measures to protect your information. However, no method of transmission is 100% secure.',
                titleStyle: titleStyle,
                bodyStyle: bodyStyle,
              ),
              _section(
                title: '5. Your Choices',
                body: '''
- You may delete your account by using the in-app delete account option.
- You can control notification settings in the app.''',
                titleStyle: titleStyle,
                bodyStyle: bodyStyle,
              ),
              _section(
                title: '6. Contact',
                body:
                    'For questions about this policy, contact us via the support channels in the app.',
                titleStyle: titleStyle,
                bodyStyle: bodyStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }

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
}
