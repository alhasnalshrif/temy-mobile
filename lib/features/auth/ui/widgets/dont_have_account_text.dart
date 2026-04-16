import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/widgets/app_text_button.dart';
import '../../../../core/theme/styles.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'auth.signup.dont_have_account'.tr(),
          textAlign: TextAlign.center,
          style: TextStyles.font16DarkBold.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 10),
        AppTextButton(
          buttonText: 'auth.signup.button'.tr(),
          textStyle: TextStyles.font16WhiteSemiBold,
          onPressed: () {
            context.goNamed(AppRoutes.signupName);
          },
        ),
      ],
    );
  }
}
