import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';

/// A reusable primary action button with consistent styling
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double height;
  final bool isOutlined;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height = 56,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return AnimatedOpacity(
      opacity: isEnabled ? 1.0 : 0.7,
      duration: const Duration(milliseconds: 200),
      child: SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          onPressed: isEnabled ? onPressed : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isOutlined ? Colors.white : ColorsManager.mainBlue,
            foregroundColor: isOutlined ? ColorsManager.mainBlue : Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: isOutlined
                  ? const BorderSide(color: ColorsManager.mainBlue, width: 1.5)
                  : BorderSide.none,
            ),
            padding: EdgeInsets.zero,
            surfaceTintColor: Colors.transparent,
            shadowColor: Colors.transparent,
            disabledBackgroundColor: isOutlined
                ? ColorsManager.lightBlue
                : Colors.grey.shade400,
          ),
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: isOutlined ? ColorsManager.mainBlue : Colors.white,
                    fontSize: isOutlined ? 14 : 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
      ),
    );
  }
}

/// A container widget for info/notice sections
class InfoContainer extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? borderColor;
  final EdgeInsets padding;

  const InfoContainer({
    super.key,
    required this.child,
    this.backgroundColor,
    this.borderColor,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorsManager.mainBlue.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
        border: borderColor != null
            ? Border.all(color: borderColor!)
            : Border.all(color: ColorsManager.mainBlue),
      ),
      child: child,
    );
  }
}

/// A reusable section header widget
class SectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget? badge;

  const SectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (badge != null) ...[const SizedBox(width: 8), badge!],
          ],
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

/// A badge widget for showing counts or labels
class CountBadge extends StatelessWidget {
  final String count;
  final Color? backgroundColor;
  final Color? textColor;

  const CountBadge({
    super.key,
    required this.count,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        count,
        style: TextStyle(
          fontSize: 14,
          color: textColor ?? ColorsManager.mainBlue,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// A generic card container with consistent styling
class CardContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final Color backgroundColor;

  const CardContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}

/// Empty state widget for lists
class EmptyStateWidget extends StatelessWidget {
  final IconData icon;
  final String message;

  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
