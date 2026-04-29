import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';

/// Reusable avatar widget with network image support and fallback.
class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final String? name;
  final Widget? fallbackWidget;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.radius = 20,
    this.name,
    this.fallbackWidget,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 2,
    this.onTap,
  });

  bool get _hasValidAvatar =>
      imageUrl != null && imageUrl!.isNotEmpty && imageUrl != 'null';

  @override
  Widget build(BuildContext context) {
    final avatar = CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? Colors.grey.shade100,
      backgroundImage: _hasValidAvatar ? NetworkImage(imageUrl!) : null,
      onBackgroundImageError: _hasValidAvatar
          ? (exception, stackTrace) {
              // Handle network errors gracefully
            }
          : null,
      child: !_hasValidAvatar ? _buildFallback() : null,
    );

    if (borderColor != null) {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor!, width: borderWidth),
        ),
        child: avatar,
      );
    }

    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: avatar);
    }

    return avatar;
  }

  Widget _buildFallback() {
    if (fallbackWidget != null) return fallbackWidget!;

    if (name != null && name!.isNotEmpty) {
      final initials = name!
          .split(' ')
          .where((s) => s.isNotEmpty)
          .map((s) => s[0].toUpperCase())
          .take(2)
          .join();
      return Text(
        initials,
        style: TextStyle(
          color: ColorsManager.mainBlue,
          fontWeight: FontWeight.bold,
          fontSize: radius * 0.8,
        ),
      );
    }

    return Icon(Icons.person, size: radius * 1.2, color: Colors.grey);
  }
}

/// Hero-tagged avatar for navigation animations.
class HeroAvatar extends StatelessWidget {
  final String? imageUrl;
  final double radius;
  final String? name;
  final String? heroTag;
  final Color? borderColor;

  const HeroAvatar({
    super.key,
    this.imageUrl,
    this.radius = 35,
    this.name,
    this.heroTag = 'profile-avatar',
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag!,
      child: AppAvatar(
        imageUrl: imageUrl,
        radius: radius,
        name: name,
        backgroundColor: Colors.white,
        borderColor: borderColor,
      ),
    );
  }
}
