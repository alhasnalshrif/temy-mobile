import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';

/// Info card for confirmation sections
class _ConfirmationCard extends StatelessWidget {
  final Widget child;

  const _ConfirmationCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.lightBlue),
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: child,
    );
  }
}

/// Appointment info section widget
class AppointmentInfoSection extends StatelessWidget {
  final DateTime? selectedDate;
  final String? selectedTime;

  const AppointmentInfoSection({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedDate == null || selectedTime == null) {
      return const SizedBox.shrink();
    }

    final formattedDate = DateFormat(
      'EEEE, d MMMM',
      'ar',
    ).format(selectedDate!);

    return _ConfirmationCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorsManager.lightBlue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/icons/calendar.png',
              color: ColorsManager.mainBlue,
              width: 18,
              height: 18,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'booking_confirmation.date_label'.tr(),
                  style: TextStyles.font14DarkBlueMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "$formattedDate - $selectedTime",
                  style: TextStyles.font14GrayRegular,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
