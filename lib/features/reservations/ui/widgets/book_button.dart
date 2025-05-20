import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';

class BookButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isEnabled;

  const BookButton({
    super.key,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isEnabled ? 1.0 : 0.7,
      duration: const Duration(milliseconds: 200),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isEnabled
                ? [ColorsManager.mainBlue, const Color(0xFF4A4785)]
                : [Colors.grey.shade400, Colors.grey.shade500],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: ColorsManager.mainBlue.withOpacity(0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  )
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: isEnabled ? onPressed : null,
            borderRadius: BorderRadius.circular(12),
            splashColor: Colors.white.withOpacity(0.1),
            highlightColor: Colors.white.withOpacity(0.05),
            child: const Center(
              child: AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(width: 12),
                    Text(
                      'التالي',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
