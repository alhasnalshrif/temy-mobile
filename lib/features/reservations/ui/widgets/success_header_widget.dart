import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/reservations/logic/reservation_success_feedback.dart';

/// Animated success header with checkmark animation
class SuccessHeaderWidget extends StatefulWidget {
  final String title;
  final bool isDesktop;
  final Color? backgroundColor;
  final Color? iconColor;

  const SuccessHeaderWidget({
    super.key,
    required this.title,
    this.isDesktop = false,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  State<SuccessHeaderWidget> createState() => _SuccessHeaderWidgetState();
}

class _SuccessHeaderWidgetState extends State<SuccessHeaderWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _iconScaleAnimation;
  late final Animation<double> _ringScaleAnimation;
  late final Animation<double> _ringOpacityAnimation;
  late final Animation<Offset> _titleOffsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _iconScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.5, end: 1.12), weight: 65),
      TweenSequenceItem(tween: Tween(begin: 1.12, end: 1), weight: 35),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _ringScaleAnimation = Tween<double>(begin: 0.8, end: 1.55).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _ringOpacityAnimation = Tween<double>(begin: 0.45, end: 0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _titleOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.25),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    ReservationSuccessFeedback.play();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final circleColor = widget.backgroundColor ??
        (widget.isDesktop ? ColorsManager.mainBlue : Colors.white);
    final checkColor = widget.iconColor ??
        (widget.isDesktop ? Colors.white : ColorsManager.black);
    final titleStyle = widget.isDesktop
        ? TextStyles.font18DarkBlueBold.copyWith(fontSize: 20)
        : TextStyles.font18WhiteSemiBold.copyWith(fontSize: 20);

    return Container(
      color: widget.backgroundColor ??
          (widget.isDesktop ? Colors.white : ColorsManager.black),
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        children: [
          SizedBox(
            width: 96,
            height: 96,
            child: AnimatedBuilder(
              animation: _controller,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: circleColor,
                  shape: BoxShape.circle,
                  border: Border.all(color: circleColor, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: circleColor.withAlpha(widget.isDesktop ? 80 : 55),
                      blurRadius: 22,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Icon(Icons.check_rounded, color: checkColor, size: 42),
              ),
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Opacity(
                      opacity: _ringOpacityAnimation.value,
                      child: Transform.scale(
                        scale: _ringScaleAnimation.value,
                        child: Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: circleColor, width: 3),
                          ),
                        ),
                      ),
                    ),
                    Transform.scale(scale: _iconScaleAnimation.value, child: child),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 4),
          FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _titleOffsetAnimation,
              child: Text(widget.title, style: titleStyle),
            ),
          ),
        ],
      ),
    );
  }
}
