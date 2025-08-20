import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/routing/routes.dart';
import 'package:easy_localization/easy_localization.dart';

class BarberSeaAll extends StatelessWidget {
  const BarberSeaAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          // 'All Barbers', // You can add this to translations if needed
          'navigation.barbers'.tr(),

          style: TextStyles.font18DarkBold,
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            // Navigate to all barbers screen or category screen
            Navigator.of(context).pushNamed(Routes.categoryScreen);
          },
          child: Text(
            'See all',
            style: TextStyles.font13BlueRegular,
          ),
        ),
      ],
    );
  }
}
