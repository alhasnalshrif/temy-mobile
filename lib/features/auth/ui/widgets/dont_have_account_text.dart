import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import '../../../../core/theme/styles.dart';

class DontHaveAccountText extends StatelessWidget {
  const DontHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.goNamed(AppRoutes.signupName);
      },
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyles.font13DarkBlueRegular,
          children: [
            TextSpan(text: 'auth.signup.dont_have_account'.tr()),
            const TextSpan(text: ' '),
            TextSpan(
              text: 'auth.signup.button'.tr(),
              style: TextStyles.font13BlueSemiBold,
            ),
          ],
        ),
      ),
    );
  }
}
