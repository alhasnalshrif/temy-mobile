import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/helpers/spacing.dart';
import 'package:flutter_complete_project/core/theme/styles.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 165,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          image: const DecorationImage(
              image: AssetImage('assets/images/home_blue_pattern.png'),
              fit: BoxFit.fitWidth),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Book and\nschedule with\nnearest doctor',
              style: TextStyles.font18WhiteMeduim,
              textAlign: TextAlign.start,
            ),
            verticalSpace(16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(48),
                  ),
                ),
                child: Text(
                  'Find Nearby',
                  style: TextStyles.font12BlueRegular,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
