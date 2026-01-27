import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:easy_localization/easy_localization.dart';

class ScheduleTab extends StatefulWidget {
  final BarberDetailData? serviceResponseModel;

  const ScheduleTab({super.key, this.serviceResponseModel});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  @override
  Widget build(BuildContext context) {
    final schedule = widget.serviceResponseModel?.availability;
    final businessHours = widget.serviceResponseModel?.workingHours;
    final timeSlots = schedule?.slots ?? [];

    if (schedule == null || businessHours == null || timeSlots.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text('barber.no_schedule'.tr()),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'barber.select_time_slot'.tr(),
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 8,
                children: [
                  _InfoChip(icon: Icons.calendar_today, label: schedule.date),
                  _InfoChip(
                    icon: Icons.access_time,
                    label: '${businessHours.start} - ${businessHours.end}',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: timeSlots.map((slot) {
                      final isDisabled = !slot.isAvailable;
                      return SizedBox(
                        width: 100, // Fixed width for time slots
                        height: 40,
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: isDisabled ? 0.5 : 1,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: ColorsManager.thirdfMain,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              slot.time,
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(
                                    color: isDisabled
                                        ? Colors.grey[400]
                                        : ColorsManager.darkBlue,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.2,
                                  ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: ColorsManager.mainBlue.withAlpha(20),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: ColorsManager.darkBlue),
          const SizedBox(width: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: ColorsManager.darkBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
