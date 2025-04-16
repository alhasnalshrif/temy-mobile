import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/theme/colors.dart';
import 'package:flutter_complete_project/features/barber/data/models/barber_detail_response.dart';

class TimeSlotSection extends StatelessWidget {
  final BarberDetailData? barberData;
  final String? selectedTime;
  final int totalDuration;
  final Function(String) onTimeSelected;

  const TimeSlotSection({
    super.key,
    required this.barberData,
    required this.selectedTime,
    required this.onTimeSelected,
    required this.totalDuration,
  });

  // Helper method to check if consecutive slots are available for the duration
  bool _areSlotsAvailable(
      List<TimeSlot> slots, int startIndex, int requiredSlots) {
    if (startIndex + requiredSlots > slots.length) {
      return false;
    }

    for (int i = startIndex; i < startIndex + requiredSlots; i++) {
      if (!slots[i].isAvailable) {
        return false;
      }
    }
    return true;
  }

  // Find the next available slot after encountering an unavailable one
  int _findNextAvailableSlotIndex(List<TimeSlot> slots, int currentIndex) {
    for (int i = currentIndex; i < slots.length; i++) {
      if (slots[i].isAvailable) {
        return i;
      }
    }
    return slots.length; // No more available slots
  }

  // Get the formatted end time based on start time and duration
  String _getEndTime(String startTime, int durationMinutes) {
    try {
      // Handle ISO format (if time is in format like 2025-04-15T07:00:00)
      if (startTime.contains('T')) {
        final dateTimeParts = startTime.split('T');
        if (dateTimeParts.length > 1) {
          startTime = dateTimeParts[1].substring(0, 5); // Extract HH:MM
        }
      }

      // Now handle HH:MM format
      final parts = startTime.split(':');
      if (parts.length < 2) {
        return startTime; // Return original if we can't parse
      }

      int hours = int.tryParse(parts[0]) ?? 0;
      int minutes = int.tryParse(parts[1]) ?? 0;

      minutes += durationMinutes;
      hours += minutes ~/ 60;
      minutes = minutes % 60;
      hours = hours % 24;

      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
    } catch (e) {
      debugPrint('Error calculating end time: $e');
      return startTime; // Return original time if there's an error
    }
  }

  // Finds optimized slots based on the required duration
  List<Map<String, dynamic>> _getOptimizedTimeSlots(
      List<TimeSlot> slots, int totalDuration) {
    // Each slot is assumed to be 15 minutes
    const slotDurationMinutes = 15;

    // Calculate how many 15-minute slots we need
    final requiredSlots = (totalDuration / slotDurationMinutes).ceil();

    // Create a list of valid starting slots based on duration
    final List<Map<String, dynamic>> validStartingSlots = [];

    int i = 0;
    while (i < slots.length) {
      // Check if there are enough consecutive available slots from this position
      final canStartHere = _areSlotsAvailable(slots, i, requiredSlots);
      final slot = slots[i];

      if (canStartHere) {
        // This is a valid starting point for the service
        validStartingSlots.add({
          'slot': slot,
          'available': true,
          'endTime': _getEndTime(slot.time, totalDuration),
          'durationBlocks': requiredSlots,
        });

        // Move to the next slot
        i += 1;
      } else if (slot.isAvailable) {
        // Current slot is available but can't fit the full service
        // Find the next unavailable slot
        int nextUnavailableIndex = i;
        for (int j = i; j < slots.length && j < i + requiredSlots; j++) {
          if (!slots[j].isAvailable) {
            nextUnavailableIndex = j;
            break;
          }
        }

        // Add this slot as unavailable with reason
        validStartingSlots.add({
          'slot': slot,
          'available': false,
          'endTime': null,
          'reason': 'Insufficient consecutive availability',
        });

        // Skip to the next slot
        i += 1;
      } else {
        // Current slot is unavailable, add it as unavailable
        validStartingSlots.add({
          'slot': slot,
          'available': false,
          'endTime': null,
          'reason': 'Unavailable time slot',
        });

        // Skip to the next available slot
        i = _findNextAvailableSlotIndex(slots, i + 1);
      }
    }

    return validStartingSlots;
  }

  @override
  Widget build(BuildContext context) {
    final availability = barberData?.availability;
    final timeSlots = availability?.slots ?? [];

    // Get optimized time slots based on service duration
    final validStartingSlots = _getOptimizedTimeSlots(timeSlots, totalDuration);

    return Container(
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'الوقت المتاح',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              if (totalDuration > 0)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: ColorsManager.lightBlue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'مدة الخدمة: $totalDuration دقيقة',
                    style: const TextStyle(
                      fontSize: 12,
                      color: ColorsManager.mainBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: validStartingSlots.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 48,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'لا توجد مواعيد متاحة',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : GridView.builder(
                    itemCount: validStartingSlots.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 18,
                      childAspectRatio: 2.2,
                    ),
                    itemBuilder: (context, index) {
                      final slotData = validStartingSlots[index];
                      final slot = slotData['slot'] as TimeSlot;
                      final isAvailable = slotData['available'] as bool;
                      final endTime = slotData['endTime'];

                      final isSelected = selectedTime == slot.time;
                      final isDisabled = !isAvailable;

                      return AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: isDisabled ? 0.5 : 1,
                        child: GestureDetector(
                          onTap: isDisabled
                              ? null
                              : () {
                                  onTimeSelected(slot.time);
                                },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? ColorsManager.mainBlue
                                  : Colors.white,
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
                                        color: ColorsManager.mainBlue
                                            .withOpacity(0.20),
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ]
                                  : [],
                            ),
                            alignment: Alignment.center,
                            child: isDisabled
                                ? Tooltip(
                                    message: slotData['reason'] ?? 'غير متاح',
                                    child: Text(
                                      _formatTimeDisplay(slot.time),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: Colors.grey[400],
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.2,
                                          ),
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        _formatTimeDisplay(slot.time),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color: isSelected
                                                  ? Colors.white
                                                  : ColorsManager.darkBlue,
                                              fontWeight: isSelected
                                                  ? FontWeight.bold
                                                  : FontWeight.w500,
                                              letterSpacing: 0.2,
                                            ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'إلى ${endTime?.substring(0, 5)}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: isSelected
                                                  ? Colors.white
                                                      .withOpacity(0.8)
                                                  : Colors.grey[600],
                                              fontSize: 10,
                                              fontWeight: isSelected
                                                  ? FontWeight.w500
                                                  : FontWeight.normal,
                                            ),
                                      ),
                                    ],
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

  // Helper method to format time display
  String _formatTimeDisplay(String time) {
    // Extract HH:MM from time string
    if (time.contains('T')) {
      final parts = time.split('T');
      if (parts.length > 1) {
        return parts[1].substring(0, 5);
      }
    }
    // Return the time as is if it's already in HH:MM format
    return time.length > 5 ? time.substring(0, 5) : time;
  }
}
