import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/theme/colors.dart';
import 'package:flutter_complete_project/features/barber/data/models/barber_detail_response.dart';

class ScheduleTab extends StatefulWidget {
  final BarberDetailData? serviceResponseModel;

  const ScheduleTab({super.key, this.serviceResponseModel});

  @override
  State<ScheduleTab> createState() => _ScheduleTabState();
}

class _ScheduleTabState extends State<ScheduleTab> {
  String? _selectedTime;

  @override
  Widget build(BuildContext context) {
    final schedule = widget.serviceResponseModel?.schedule;
    final businessHours = schedule?.businessHours;
    final timeSlots = schedule?.timeSlots ?? [];

    if (schedule == null || businessHours == null || timeSlots.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('No scheduling information available.'),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Select a Time Slot',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 18, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Text(
                schedule.date,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
              ),
              const SizedBox(width: 16),
              Icon(Icons.access_time, size: 18, color: Colors.grey[600]),
              const SizedBox(width: 6),
              Text(
                '${businessHours.start} - ${businessHours.end}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[700],
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: timeSlots.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                childAspectRatio: 2.5,
              ),
              itemBuilder: (context, index) {
                final slot = timeSlots[index];
                final isSelected = _selectedTime == slot.startTime;
                final isDisabled = !slot.available || slot.booked;
                return AnimatedOpacity(
                  duration: const Duration(milliseconds: 200),
                  opacity: isDisabled ? 0.5 : 1,
                  child: GestureDetector(
                    onTap: isDisabled
                        ? null
                        : () {
                            setState(() {
                              _selectedTime = slot.startTime;
                            });
                          },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? ColorsManager.mainBlue : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? ColorsManager.mainBlue
                              : ColorsManager.thirdfMain,
                          width: isSelected ? 2.2 : 1,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color:
                                      ColorsManager.mainBlue.withOpacity(0.10),
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ]
                            : [],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        slot.formattedTime,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : isDisabled
                                      ? Colors.grey[400]
                                      : ColorsManager.darkBlue,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              letterSpacing: 0.2,
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
