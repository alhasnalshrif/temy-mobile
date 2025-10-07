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
  final ValueChanged<String?> onTimeSelected;
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
    List<reservation.TimeSlot> slots,
    int startIndex,
    int requiredSlots,
  ) {
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

  // Convert barber.TimeSlot to reservation.TimeSlot
  reservation.TimeSlot _convertBarberTimeSlot(barber.TimeSlot slot) {
    return reservation.TimeSlot(time: slot.time, isAvailable: slot.isAvailable);
  }

  String _sanitizeTimeString(String time) {
    var normalized = time;

    if (normalized.contains('T')) {
      final dateTimeParts = normalized.split('T');
      if (dateTimeParts.length > 1) {
        normalized = dateTimeParts[1];
      }
    }

    if (normalized.contains(' ')) {
      normalized = normalized.split(' ').first;
    }

    if (normalized.length >= 5 && normalized.contains(':')) {
      normalized = normalized.substring(0, 5);
    }

    return normalized;
  }

  // Get the formatted end time based on start time and duration
  String _getEndTime(String startTime, int durationMinutes) {
    try {
      final normalizedStart = _sanitizeTimeString(startTime);
      final parts = normalizedStart.split(':');
      if (parts.length < 2) {
        return normalizedStart; // Return sanitized if we can't parse
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
      return _sanitizeTimeString(
        startTime,
      ); // Return sanitized time if there's an error
    }
  }

  String _formatTimeForDisplay(String time) {
    try {
      final sanitized = _sanitizeTimeString(time);
      final parts = sanitized.split(':');
      if (parts.length < 2) {
        return sanitized;
      }

      final rawHour = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;

      final isNoon = rawHour == 12 && minutes == 0;
      final isAm = rawHour < 12;
      final period = isNoon ? 'ظ' : (isAm ? 'ص' : 'م');

      int displayHour = rawHour % 12;
      if (displayHour == 0) {
        displayHour = 12;
      }

      final formattedHour = displayHour.toString().padLeft(2, '0');
      final formattedMinutes = minutes.toString().padLeft(2, '0');

      return '$formattedHour:$formattedMinutes $period';
    } catch (e) {
      debugPrint('Error formatting time display: $e');
      return time;
    }
  }

  // Helper method to check if booking fits within working hours
  bool _fitsWithinWorkingHours(String startTime, int durationMinutes) {
    if (barberData?.workingHours == null) {
      return true; // If no working hours data, allow all slots
    }

    try {
      final workingEnd = _sanitizeTimeString(barberData!.workingHours.end);
      final normalizedStart = _sanitizeTimeString(startTime);

      // Parse times
      final startParts = normalizedStart.split(':');
      final endParts = workingEnd.split(':');

      if (startParts.length < 2 || endParts.length < 2) {
        return true; // Can't validate, allow the slot
      }

      int startHours = int.tryParse(startParts[0]) ?? 0;
      int startMinutes = int.tryParse(startParts[1]) ?? 0;
      int workingEndHours = int.tryParse(endParts[0]) ?? 0;
      int workingEndMinutes = int.tryParse(endParts[1]) ?? 0;

      // Calculate booking end time
      int bookingEndMinutes = startMinutes + durationMinutes;
      int bookingEndHours = startHours + (bookingEndMinutes ~/ 60);
      bookingEndMinutes = bookingEndMinutes % 60;

      // Convert to total minutes for comparison
      int bookingEndTotalMinutes = (bookingEndHours * 60) + bookingEndMinutes;
      int workingEndTotalMinutes = (workingEndHours * 60) + workingEndMinutes;

      // Check if booking ends before or at working hours end
      return bookingEndTotalMinutes <= workingEndTotalMinutes;
    } catch (e) {
      debugPrint('Error validating working hours: $e');
      return true; // On error, allow the slot
    }
  }

  // Finds optimized slots based on the required duration
  List<Map<String, dynamic>> _getOptimizedTimeSlots(
    List<reservation.TimeSlot> slots,
    int totalDuration,
  ) {
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

      // Also check if booking fits within working hours
      final fitsInWorkingHours = _fitsWithinWorkingHours(
        slot.time,
        totalDuration,
      );

      if (canStartHere && fitsInWorkingHours) {
        // This is a valid starting point for the service
        final endTime = _getEndTime(slot.time, totalDuration);
        validStartingSlots.add({
          'slot': slot,
          'available': true,
          'endTime': endTime,
          'displayStart': _formatTimeForDisplay(slot.time),
          'displayEnd': _formatTimeForDisplay(endTime),
          'durationBlocks': requiredSlots,
        });

        // Move to the next slot
        i += 1;
      } else if (slot.isAvailable && !fitsInWorkingHours) {
        // Slot is available but booking would extend beyond working hours
        validStartingSlots.add({
          'slot': slot,
          'available': false,
          'endTime': null,
          'displayStart': _formatTimeForDisplay(slot.time),
          'reason': 'يتجاوز ساعات العمل',
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
          'displayStart': _formatTimeForDisplay(slot.time),
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
          'displayStart': _formatTimeForDisplay(slot.time),
          'reason': 'Unavailable time slot',
        });

        // Move to the next slot to ensure all slots appear in the grid
        i += 1;
      }
    }

    return validStartingSlots;
  }

  @override
  Widget build(BuildContext context) {
    // Convert barber slots to reservation slots if needed
    final List<reservation.TimeSlot> timeSlots =
        timeSlotsData?.data.slots ??
        (barberData?.availability.slots
                .map((slot) => _convertBarberTimeSlot(slot))
                .toList() ??
            []);

    // Get optimized time slots based on service duration
    final validStartingSlots = _getOptimizedTimeSlots(timeSlots, totalDuration);

    final hasValidSelectedTime =
        selectedTime != null &&
        validStartingSlots.any((slotData) {
          if (slotData['available'] != true) {
            return false;
          }
          final reservation.TimeSlot slot =
              slotData['slot'] as reservation.TimeSlot;
          return slot.time == selectedTime;
        });

    if (selectedTime != null && !hasValidSelectedTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!context.mounted) {
          return;
        }
        onTimeSelected(null);
      });
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              'الوقت المتاح',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            if (totalDuration > 0)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
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
        isLoading
            ? SizedBox(
                height: 100,
                child: Center(
                  // Replace CircularProgressIndicator with ShimmerLoading
                  child: ShimmerLoading.rectangular(height: 60),
                ),
              )
            : validStartingSlots.isEmpty
            ? const SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'لا توجد أوقات متاحة في هذا اليوم',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  // Calculate responsive dimensions
                  final screenWidth = MediaQuery.of(context).size.width;
                  final availableWidth = constraints.maxWidth > 0
                      ? constraints.maxWidth
                      : screenWidth - 32; // Default padding

                  // Calculate item dimensions
                  const crossAxisCount = 4;
                  const crossAxisSpacing = 8.0;
                  const mainAxisSpacing = 8.0;

                  final totalSpacing = crossAxisSpacing * (crossAxisCount - 1);
                  final itemWidth =
                      (availableWidth - totalSpacing) / crossAxisCount;
                  final itemHeight =
                      itemWidth / 1.5; // Based on childAspectRatio

                  // Calculate total height
                  final rows = (validStartingSlots.length / crossAxisCount)
                      .ceil();
                  final totalHeight =
                      (rows * itemHeight) +
                      ((rows - 1) * mainAxisSpacing) +
                      40; // Extra padding

                  return SizedBox(
                    height: totalHeight,
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 1.5,
                            crossAxisSpacing: crossAxisSpacing,
                            mainAxisSpacing: mainAxisSpacing,
                          ),
                      itemCount: validStartingSlots.length,
                      itemBuilder: (context, index) {
                        final slotData = validStartingSlots[index];
                        final slot = slotData['slot'] as reservation.TimeSlot;
                        final isAvailable = slotData['available'] as bool;
                        final isSelected = selectedTime == slot.time;
                        final displayStart =
                            slotData['displayStart'] as String? ??
                            _formatTimeForDisplay(slot.time);
                        final displayEnd = slotData['displayEnd'] as String?;
                        final unavailableReason = slotData['reason'] as String?;

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
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    displayStart,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : isAvailable
                                          ? ColorsManager.mainBlue
                                          : Colors.grey,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (isAvailable && displayEnd != null)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        displayEnd,
                                        style: TextStyle(
                                          color: isSelected
                                              ? Colors.white70
                                              : ColorsManager.mainBlue,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  if (!isAvailable)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        unavailableReason ?? 'غير متاح',
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 9,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),

        if (selectedTime != null) ...[
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                  () {
                    final selectionStartDisplay = _formatTimeForDisplay(
                      selectedTime!,
                    );
                    final selectionEndDisplay = _formatTimeForDisplay(
                      _getEndTime(selectedTime!, totalDuration),
                    );
                    return 'الحجز: $selectionStartDisplay - $selectionEndDisplay';
                  }(),
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
    );
  }
}
