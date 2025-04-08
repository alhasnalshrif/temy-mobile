import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/colors.dart';
import '../../../../core/theme/styles.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Hi, Alhasn',
              style: TextStyles.font18DarkBlueBold,
            ),
          ],
        ),
        const Spacer(),
        CircleAvatar(
            radius: 24,
            backgroundColor: ColorsManager.moreLighterGray,
            child: SvgPicture.asset(
              'assets/svgs/notifications.svg',
            )),
      ],
    );
  }
}
