import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/styles.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('temy_barber'.tr(), style: TextStyles.font24BlackBold),
          ],
        ),
        // const Spacer(),
        // const Image(image: AssetImage('assets/images/logo.png'), height: 40),
      ],
    );
  }
}
