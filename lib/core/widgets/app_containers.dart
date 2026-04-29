import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';

/// Reusable card container with consistent styling.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color backgroundColor;
  final Color? borderColor;
  final double borderRadius;
  final double? elevation;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.backgroundColor = Colors.white,
    this.borderColor,
    this.borderRadius = 12,
    this.elevation,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: borderColor != null
            ? Border.all(color: borderColor!)
            : null,
        boxShadow: elevation != null && elevation! > 0
            ? [
                BoxShadow(
                  color: Colors.black.withAlpha(13),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: child,
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: card,
        ),
      );
    }

    return card;
  }
}

/// Info container with icon and colored background.
class AppInfoContainer extends StatelessWidget {
  final String message;
  final IconData? icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final Color? textColor;
  final EdgeInsets padding;
  final double borderRadius;

  const AppInfoContainer({
    super.key,
    required this.message,
    this.icon,
    this.backgroundColor,
    this.iconColor,
    this.textColor,
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorsManager.lightBlue,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 24, color: iconColor ?? ColorsManager.mainBlue),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor ?? ColorsManager.darkBlue,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Rounded container with icon (for section headers, etc.).
class AppIconContainer extends StatelessWidget {
  final IconData icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;
  final VoidCallback? onTap;

  const AppIconContainer({
    super.key,
    required this.icon,
    this.backgroundColor,
    this.iconColor,
    this.size = 40,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor ?? ColorsManager.lightBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          size: size / 2,
          color: iconColor ?? ColorsManager.mainBlue,
        ),
      ),
    );
  }
}

/// Section header with title and optional trailing widget.
class AppSectionHeader extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final Widget? badge;
  final EdgeInsets padding;

  const AppSectionHeader({
    super.key,
    required this.title,
    this.trailing,
    this.badge,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              if (badge != null) ...[const SizedBox(width: 8), badge!],
            ],
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

/// Divider with optional text label.
class AppLabeledDivider extends StatelessWidget {
  final String? label;
  final double height;
  final Color? color;
  final double thickness;

  const AppLabeledDivider({
    super.key,
    this.label,
    this.height = 24,
    this.color,
    this.thickness = 1,
  });

  @override
  Widget build(BuildContext context) {
    if (label == null) {
      return Divider(height: height, color: color ?? ColorsManager.lightBlue, thickness: thickness);
    }

    return Row(
      children: [
        Expanded(child: Divider(color: color ?? ColorsManager.lightBlue)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label!,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(child: Divider(color: color ?? ColorsManager.lightBlue)),
      ],
    );
  }
}
