import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/features/login/logic/cubit/login_cubit.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theme/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import 'widgets/dont_have_account_text.dart';
import 'widgets/email_and_password.dart';
import 'widgets/login_bloc_listener.dart';
import 'widgets/terms_and_conditions_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top gradient section with logo and welcome text
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'مرحباً بعودتك',
                    style: TextStyles.font28WhiteBold,
                  ),
                  verticalSpace(16),
                  Image.asset(
                    'assets/images/logo.png',
                    height: 60,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            verticalSpace(20),
            // White bottom section with rounded corners
            Expanded(
              child: Container(
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                padding: const EdgeInsets.all(30),
                child: _buildLoginForm(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(10),
          Text(
            'ادخل بياناتك هنا لتسجيل الدخول',
            style: TextStyles.font16WhiteSemiBold.copyWith(color: Colors.black),
          ),
          verticalSpace(24),
          // Email and password fields with shadow
          const EmailAndPassword(),
          verticalSpace(24),
          GestureDetector(
            onTap: () {
              // TODO: Navigate to forgot password screen
            },
            child: Text(
              'نسيت كلمة المرور؟',
              style: TextStyles.font13BlueRegular,
            ),
          ),
          verticalSpace(40),
          AppTextButton(
            buttonText: "تسجيل الدخول",
            textStyle: TextStyles.font16WhiteSemiBold,
            onPressed: () => validateThenDoLogin(context),
          ),
          const SizedBox(height: 16),
          const TermsAndConditionsText(),
          const SizedBox(height: 30),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.center,
            child: DontHaveAccountText(),
          ),
          const LoginBlocListener(),
        ],
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().emitLoginStates();
    }
  }
}
