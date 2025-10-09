import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';

class BookingTabs extends StatelessWidget {
  final bool showActiveBookings;
  final VoidCallback onActiveTap;
  final VoidCallback onHistoryTap;

  const BookingTabs({
    super.key,
    required this.showActiveBookings,
    required this.onActiveTap,
    required this.onHistoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorsManager.thirdfMain,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            _buildTabItem(
              context,
              'booking.active'.tr(),
              showActiveBookings,
              onActiveTap,
            ),
            _buildTabItem(
              context,
              'booking.history'.tr(),
              !showActiveBookings,
              onHistoryTap,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabItem(
    BuildContext context,
    String title,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.all(2),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? ColorsManager.mainBlue : Colors.black54,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
