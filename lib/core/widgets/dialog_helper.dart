import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';

class DialogHelper {
  static bool _isShowing = false;

  static Future<T?> showLoading<T>(BuildContext context) {
    if (_isShowing) return Future.value();
    _isShowing = true;
    return showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (_) => Center(child: ShimmerLoading.circular(size: 50)),
    ).whenComplete(() => _isShowing = false);
  }

  static void dismissLoading(BuildContext context) {
    if (_isShowing && Navigator.canPop(context)) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  static void showError(BuildContext context, String error) {
    _isShowing = false;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.error, color: ColorsManager.red, size: 32),
        content: Text(error, style: TextStyles.font15DarkBlueMedium),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              'common.got_it'.tr(),
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }

  static void reset() => _isShowing = false;
}
