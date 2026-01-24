import 'package:flutter/material.dart';


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
    ), 
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
       
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

        return child;
      },
    );
  }
}
