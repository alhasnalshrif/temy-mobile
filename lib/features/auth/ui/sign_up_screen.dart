import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/features/auth/ui/widgets/sign_up_bloc_listener.dart';
import 'package:temy_barber/features/auth/ui/widgets/sign_up_form.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theme/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import 'widgets/terms_and_conditions_text.dart';
import '../logic/sign_up_cubit.dart';
import 'widgets/already_have_account_text.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // Prevent back navigation
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Exit the app when back button is pressed
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'auth.signup.title'.tr(),
                    style: TextStyles.font26BlueBold,
                  ),
                  verticalSpace(12),
                  Text(
                    'auth.signup.subtitle'.tr(),
                    style: TextStyles.font16GrayRegular,
                  ),
                  verticalSpace(36),
                  Column(
                    children: [
                      const SignupForm(),
                      verticalSpace(40),
                      AppTextButton(
                        buttonText: 'auth.signup.button'.tr(),
                        textStyle: TextStyles.font16WhiteSemiBold,
                        onPressed: () {
                          validateThenDoSignup(context);
                        },
                      ),
                      verticalSpace(16),
                      const TermsAndConditionsText(),
                      verticalSpace(30),
                      const AlreadyHaveAccountText(),
                      const SignupBlocListener(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateThenDoSignup(BuildContext context) {
    if (context.read<SignupCubit>().formKey.currentState!.validate()) {
      context.read<SignupCubit>().emitSignupStates();
    }
  }
}
