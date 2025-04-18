import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';

class NoInternetPage extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetPage({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: 80,
              color: ColorsManager.mainBlue,
            ),
            const SizedBox(height: 24),
            Text(
              'لا يوجد اتصال بالإنترنت',
              style: TextStyles.font18DarkBlueBold,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              'تحقق من اتصالك بالإنترنت وحاول مرة أخرى',
              style: TextStyles.font16GrayRegular,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainBlue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'إعادة المحاولة',
                style: TextStyles.font16WhiteSemiBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
