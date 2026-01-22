import 'package:flutter/material.dart';

import '../../../../core/theme/styles.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text('Temy Barber', style: TextStyles.font18DarkBlueBold)],
        ),
        const Spacer(),
        const Image(image: AssetImage('assets/images/logo.png'), height: 40),
      ],
    );
  }
}
