import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../core/theme/styles.dart';

class TermsAndConditionsText extends StatelessWidget {
  const TermsAndConditionsText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'auth.terms_agreement'.tr(),
            style: TextStyles.font13GrayRegular,
          ),
          TextSpan(
            text: ' ${'auth.terms_and_conditions'.tr()}',
            style: TextStyles.font13DarkBlueMedium,
          ),
          TextSpan(
            text: ' ${'auth.and'.tr()}',
            style: TextStyles.font13GrayRegular.copyWith(height: 1.5),
          ),
          TextSpan(
            text: ' ${'auth.privacy_policy'.tr()}',
            style: TextStyles.font13DarkBlueMedium,
          ),
        ],
      ),
    );
  }
}
