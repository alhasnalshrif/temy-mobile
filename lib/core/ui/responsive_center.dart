import 'package:flutter/material.dart';

/// A widget that centers its child and constrains its width on larger screens (web/desktop).
/// On mobile devices, it just passes the child through.
class ResponsiveCenter extends StatelessWidget {
  final Widget child;
  final double maxWidth;
  final Color backgroundColor;

  const ResponsiveCenter({
    super.key,
    required this.child,
    this.maxWidth = 500, // Typical mobile width + padding
    this.backgroundColor = const Color(
      0xFFF5F5F5,
    ), // Light grey background for the "desktop" area
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // If the screen width is greater than 600 (Tablet/Desktop/Web),
        // constrain the app width and center it.
        if (constraints.maxWidth > 600) {
          return Container(
            color: backgroundColor,
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: ClipRect(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  child: child,
                ),
              ),
            ),
          );
        }

        // On mobile (< 600), just return child (full width)
        return child;
      },
    );
  }
}
