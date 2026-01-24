import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:temy_barber/core/theme/colors.dart';

/// A shimmer loading widget styled as a card with placeholders for image, title, subtitle, and buttons.
/// Supports advanced theming, gradient animations, and accessibility.
class ShimmerCard extends StatelessWidget {
  final double width;
  final double height;
  final double imageWidth;
  final double imageHeight;
  final double titleHeight;
  final double subtitleHeight;
  final bool showImage;
  final bool showButtons;
  final int buttonCount;
  final Duration period;
  final ShimmerDirection direction;
  final Color? baseColor;
  final Color? highlightColor;
  final Curve animationCurve;
  final BorderRadius borderRadius;
  final double elevation;
  final String? semanticLabel;
  final bool enabled;

  const ShimmerCard({
    super.key,
    this.width = double.infinity,
    this.height = 120,
    this.imageWidth = 80,
    this.imageHeight = 80,
    this.titleHeight = 20,
    this.subtitleHeight = 16,
    this.showImage = true,
    this.showButtons = true,
    this.buttonCount = 2,
    this.period = const Duration(milliseconds: 1200),
    this.direction = ShimmerDirection.ltr,
    this.baseColor,
    this.highlightColor,
    this.animationCurve = Curves.easeInOut,
    this.borderRadius = const BorderRadius.all(Radius.circular(12)),
    this.elevation = 4,
    this.semanticLabel,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    // Resolve theme-based colors with fallback defaults
    final Color shimmerBase = baseColor ?? context.shimmerBaseColor;
    final Color shimmerHighlight =
        highlightColor ?? context.shimmerHighlightColor;

    // Responsive width: constrain to screen size if not specified
    final double effectiveWidth = width == double.infinity
        ? MediaQuery.of(context).size.width * 0.9
        : width;

    // Card layout with placeholders
    Widget cardContent = Container(
      width: effectiveWidth,
      height: height,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder for image/thumbnail
          if (showImage)
            ShimmerLoading.rectangular(
              width: imageWidth,
              height: imageHeight,
              baseColor: shimmerBase,
              highlightColor: shimmerHighlight,
              period: period,
              direction: direction,
              animationCurve: animationCurve,
              borderRadius: BorderRadius.circular(8),
              enabled: enabled,
            ),
          if (showImage) const SizedBox(width: 16),

          // Placeholder for text content (title and subtitle)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title placeholder
                ShimmerLoading.rectangular(
                  height: titleHeight,
                  baseColor: shimmerBase,
                  highlightColor: shimmerHighlight,
                  period: period,
                  direction: direction,
                  animationCurve: animationCurve,
                  borderRadius: BorderRadius.circular(4),
                  enabled: enabled,
                ),
                const SizedBox(height: 8),
                // Subtitle placeholder
                ShimmerLoading.rectangular(
                  height: subtitleHeight,
                  width: effectiveWidth * 0.6,
                  baseColor: shimmerBase,
                  highlightColor: shimmerHighlight,
                  period: period,
                  direction: direction,
                  animationCurve: animationCurve,
                  borderRadius: BorderRadius.circular(4),
                  enabled: enabled,
                ),
                if (showButtons) const SizedBox(height: 12),
                // Button placeholders
                if (showButtons)
                  Row(
                    children: List.generate(
                      buttonCount,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ShimmerLoading.circular(
                          size: 36,
                          baseColor: shimmerBase,
                          highlightColor: shimmerHighlight,
                          period: period,
                          direction: direction,
                          animationCurve: animationCurve,
                          enabled: enabled,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );

    // Apply shimmer effect if enabled
    if (enabled) {
      cardContent = Shimmer.fromColors(
        baseColor: shimmerBase,
        highlightColor: shimmerHighlight,
        period: period,
        direction: direction,
        loop: 1,
        enabled: enabled,
        child: cardContent,
      );
    }

    // Wrap in a Card widget for elevation and shadow
    return Semantics(
      label: semanticLabel ?? 'Loading card placeholder',
      child: Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        clipBehavior: Clip.antiAlias,
        child: cardContent,
      ),
    );
  }
}

/// Extension to provide adaptive shimmer colors based on the current theme.
extension ShimmerTheme on BuildContext {
  /// Returns the base shimmer color based on theme brightness.
  Color get shimmerBaseColor {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark
        ? ColorsManager.shimmerBaseDark
        : ColorsManager.shimmerBase;
  }

  /// Returns the highlight shimmer color based on theme brightness.
  Color get shimmerHighlightColor {
    final brightness = Theme.of(this).brightness;
    return brightness == Brightness.dark
        ? ColorsManager.shimmerHighlightDark
        : ColorsManager.shimmerHighlight;
  }
}

/// Reusable shimmer loading widget for individual placeholders (used within ShimmerCard).
class ShimmerLoading extends StatelessWidget {
  final double? width;
  final double? height;
  final ShapeBorder shapeBorder;
  final Duration period;
  final ShimmerDirection direction;
  final BoxDecoration? decoration;
  final Color? baseColor;
  final Color? highlightColor;
  final Curve animationCurve;
  final Border? border;
  final String? semanticLabel;
  final bool enabled;

  const ShimmerLoading._({
    super.key,
    this.width,
    this.height,
    required this.shapeBorder,
    this.period = const Duration(milliseconds: 1200),
    this.direction = ShimmerDirection.ltr,
    this.decoration,
    this.baseColor,
    this.highlightColor,
    this.animationCurve = Curves.easeInOut,
    this.border,
    this.semanticLabel,
    this.enabled = true,
  });

  factory ShimmerLoading.rectangular({
    Key? key,
    double? width,
    required double height,
    Color? baseColor,
    Color? highlightColor,
    Duration period = const Duration(milliseconds: 1200),
    ShimmerDirection direction = ShimmerDirection.ltr,
    BoxDecoration? decoration,
    Curve animationCurve = Curves.easeInOut,
    Border? border,
    String? semanticLabel,
    bool enabled = true,
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(16)),
  }) {
    return ShimmerLoading._(
      key: key,
      width: width,
      height: height,
      shapeBorder: RoundedRectangleBorder(borderRadius: borderRadius),
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: period,
      direction: direction,
      decoration: decoration,
      animationCurve: animationCurve,
      border: border,
      semanticLabel: semanticLabel ?? 'Loading rectangular placeholder',
      enabled: enabled,
    );
  }

  factory ShimmerLoading.circular({
    Key? key,
    required double size,
    Color? baseColor,
    Color? highlightColor,
    Duration period = const Duration(milliseconds: 1200),
    ShimmerDirection direction = ShimmerDirection.ltr,
    BoxDecoration? decoration,
    Curve animationCurve = Curves.easeInOut,
    Border? border,
    String? semanticLabel,
    bool enabled = true,
  }) {
    return ShimmerLoading._(
      key: key,
      width: size,
      height: size,
      shapeBorder: const CircleBorder(),
      baseColor: baseColor,
      highlightColor: highlightColor,
      period: period,
      direction: direction,
      decoration: decoration,
      animationCurve: animationCurve,
      border: border,
      semanticLabel: semanticLabel ?? 'Loading circular placeholder',
      enabled: enabled,
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color shimmerBase = baseColor ?? context.shimmerBaseColor;
    final Color shimmerHighlight =
        highlightColor ?? context.shimmerHighlightColor;

    assert(
      (width == null || width! > 0) && (height == null || height! > 0),
      'Width and height must be positive or null.',
    );

    final double effectiveWidth =
        width ?? MediaQuery.of(context).size.width * 0.9;

    final defaultDecoration = ShapeDecoration(
      color: shimmerBase.withOpacity(0.6),
      shape: shapeBorder,
    );

    Widget shimmerWidget = Container(
      width: effectiveWidth,
      height: height,
      decoration: decoration ?? defaultDecoration,
      clipBehavior: Clip.antiAlias,
    );

    if (enabled) {
      shimmerWidget = Shimmer.fromColors(
        baseColor: shimmerBase,
        highlightColor: shimmerHighlight,
        period: period,
        direction: direction,
        loop: 1,
        enabled: enabled,
        child: shimmerWidget,
      );
    }

    return Semantics(label: semanticLabel, child: shimmerWidget);
  }
}

/// Example usage of ShimmerCard widget in a Flutter app.
