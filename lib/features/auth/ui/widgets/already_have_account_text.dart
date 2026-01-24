import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import '../../../../core/theme/styles.dart';

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.goNamed(AppRoutes.loginName),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyles.font13DarkBlueRegular,
          children: [
            TextSpan(text: '${'auth.signup.already_have_account'.tr()} '),
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
