import 'package:flutter/material.dart';

import '../../core/theme/styles.dart';
import 'widgets/doc_logo_and_name.dart';
import 'widgets/doctor_image_and_text.dart';
import 'widgets/get_started_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: Column(
            children: [
              const DocLogoAndName(),
              const SizedBox(height: 30),
              const DoctorImageAndText(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    Text(
                      'Manage and schedule all of your medical appointments easily with Docdoc to get a new experience.',
                      style: TextStyles.font13GrayRegular,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    const GetStartedButton(),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
