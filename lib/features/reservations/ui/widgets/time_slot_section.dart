import 'package:flutter/material.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart'; // Import shimmer
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart'
    as barber;
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart'
    as reservation;
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';

class TimeSlotSection extends StatelessWidget {
  final BarberDetailData? barberData;
  final String? selectedTime;
  final int totalDuration;
  final Function(String) onTimeSelected;
  final bool isLoading;
  final TimeSlotsResponse? timeSlotsData;

  const TimeSlotSection({
    super.key,
    required this.barberData,
    required this.selectedTime,
    required this.onTimeSelected,
    required this.totalDuration,
    this.isLoading = false,
    this.timeSlotsData,
  });

  // Helper method to check if consecutive slots are available for the duration
  bool _areSlotsAvailable(
      List<reservation.TimeSlot> slots, int startIndex, int requiredSlots) {
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
  int _findNextAvailableSlotIndex(
      List<reservation.TimeSlot> slots, int currentIndex) {
    for (int i = currentIndex; i < slots.length; i++) {
      if (slots[i].isAvailable) {
        return i;
      }
    }
    return slots.length; // No more available slots
  }

  // Convert barber.TimeSlot to reservation.TimeSlot
  reservation.TimeSlot _convertBarberTimeSlot(barber.TimeSlot slot) {
    return reservation.TimeSlot(time: slot.time, isAvailable: slot.isAvailable);
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
      List<reservation.TimeSlot> slots, int totalDuration) {
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
        for (int j = i; j < slots.length && j < i + requiredSlots; j++) {
          if (!slots[j].isAvailable) {
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
    // Convert barber slots to reservation slots if needed
    final List<reservation.TimeSlot> timeSlots = timeSlotsData?.data.slots ??
        (barberData?.availability.slots
                .map((slot) => _convertBarberTimeSlot(slot))
                .toList() ??
            []);

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
            child: isLoading
                ? Center(
                    // Replace CircularProgressIndicator with ShimmerLoading
                    child: ShimmerLoading.rectangular(height: 100),
                  )
                : validStartingSlots.isEmpty
                    ? const Center(
                        child: Text(
                          'لا توجد أوقات متاحة في هذا اليوم',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 1.5,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: validStartingSlots.length,
                        itemBuilder: (context, index) {
                          final slotData = validStartingSlots[index];
                          final slot = slotData['slot'] as reservation.TimeSlot;
                          final isAvailable = slotData['available'] as bool;
                          final isSelected = selectedTime == slot.time;

                          // Build each time slot widget
                          return GestureDetector(
                            onTap: isAvailable
                                ? () => onTimeSelected(slot.time)
                                : null,
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? ColorsManager.mainBlue
                                    : isAvailable
                                        ? ColorsManager.lightBlue
                                        : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  slot.time,
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : isAvailable
                                            ? ColorsManager.mainBlue
                                            : Colors.grey,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
          if (selectedTime != null) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: ColorsManager.lightBlue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    color: ColorsManager.mainBlue,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'الحجز: $selectedTime - ${_getEndTime(selectedTime!, totalDuration)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorsManager.mainBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
