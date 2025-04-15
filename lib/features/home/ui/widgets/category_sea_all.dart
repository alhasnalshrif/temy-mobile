import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/theme/styles.dart';

class DoctorSpecialitySeaAll extends StatelessWidget {
  const DoctorSpecialitySeaAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text(
        'اختر الحلاق',
        style: TextStyles.font18DarkBold,
      ),
      const Spacer(),
      Text(
        'See all',
        style: TextStyles.font13BlueRegular,
      ),
    ]);
  }
}
