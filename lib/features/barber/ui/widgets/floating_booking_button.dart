import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';

/// Floating booking pill button with animation
class FloatingBookingButton extends StatelessWidget {
  final bool hasSelection;
  final VoidCallback onTap;
  final String? priceText;

  const FloatingBookingButton({
    super.key,
    required this.hasSelection,
    required this.onTap,
    this.priceText,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 32,
      left: 0,
      right: 0,
      child: SafeArea(
        child: IgnorePointer(
          ignoring: !hasSelection,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: hasSelection ? 1.0 : 0.0,
            curve: Curves.easeOut,
            child: AnimatedSlide(
              duration: const Duration(milliseconds: 400),
              offset: hasSelection ? Offset.zero : const Offset(0, 0.5),
              curve: Curves.easeOutBack,
              child: Center(
                child: _buildButton(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: ColorsManager.mainBlue,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.mainBlue.withAlpha(89),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: hasSelection ? onTap : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            child: Text(
              'barber.book_now'.tr(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
