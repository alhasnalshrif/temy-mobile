import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';

/// Floating action pill button for booking
class FloatingActionPill extends StatelessWidget {
  final bool isLoading;
  final bool isEnabled;
  final String? text;
  final VoidCallback? onTap;

  const FloatingActionPill({
    super.key,
    this.isLoading = false,
    this.isEnabled = true,
    this.text,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final canProceed = isEnabled && !isLoading;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: 170,
      height: 48,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: canProceed ? ColorsManager.mainBlue : ColorsManager.mainBlue.withAlpha(120),
        borderRadius: BorderRadius.circular(16),
        boxShadow: canProceed
            ? [
                BoxShadow(
                  color: ColorsManager.mainBlue.withAlpha(64),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: canProceed ? onTap : null,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    text ?? 'common.next'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
