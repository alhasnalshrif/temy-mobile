import 'package:flutter/foundation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart'
    as barber;
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart'
    as reservation;

class TimeSlotLogic {
  const TimeSlotLogic();

  // Convert barber.TimeSlot to reservation.TimeSlot
  reservation.TimeSlot convertBarberTimeSlot(barber.TimeSlot slot) {
    return reservation.TimeSlot(time: slot.time, isAvailable: slot.isAvailable);
  }

  // Calculate the slot duration in minutes based on the time difference between consecutive slots
  int calculateSlotDuration(List<reservation.TimeSlot> slots) {
    if (slots.length < 2) return 5; // Default to 5 minutes if not enough slots

    try {
      final firstTime = timeStringToMinutes(sanitizeTimeString(slots[0].time));
      final secondTime = timeStringToMinutes(sanitizeTimeString(slots[1].time));

      // Handle case where second time is on the next day (e.g., 23:55 -> 00:00)
      int diff = secondTime - firstTime;
      if (diff < 0) {
        diff += 24 * 60; // Add a full day in minutes
      }

      return diff > 0 ? diff : 5; // Fallback to 5 minutes if calculation fails
    } catch (e) {
      debugPrint('Error calculating slot duration: $e');
      return 5; // Default to 5 minutes on error
    }
  }

  // Convert time string to total minutes for easier calculations
  int timeStringToMinutes(String timeString) {
    final parts = timeString.split(':');
    if (parts.length < 2) return 0;

    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;

    return (hours * 60) + minutes;
  }

  String sanitizeTimeString(String time) {
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

  // Helper method to check if consecutive slots are available for the duration
  bool areSlotsAvailable(
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

  // Get the formatted end time based on start time and duration
  String getEndTime(String startTime, int durationMinutes) {
    try {
      final normalizedStart = sanitizeTimeString(startTime);
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
      return sanitizeTimeString(
        startTime,
      ); // Return sanitized time if there's an error
    }
  }

  String formatTimeForDisplay(String time) {
    try {
      final sanitized = sanitizeTimeString(time);
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

  // Finds optimized slots based on the required duration
  List<Map<String, dynamic>> getOptimizedTimeSlots(
    List<reservation.TimeSlot> slots,
    int totalDuration,
  ) {
    if (slots.isEmpty) return [];

    // Calculate the actual slot duration based on the time difference
    final slotDurationMinutes = calculateSlotDuration(slots);

    // Calculate how many slots we need based on the actual slot duration
    final requiredSlots = (totalDuration / slotDurationMinutes).ceil();

    // Create a list of valid starting slots based on duration
    final List<Map<String, dynamic>> validStartingSlots = [];

    // Skip slots that are too close to each other to reduce visual clutter
    // For 5-minute intervals, we'll show every 3rd slot by default unless duration is small
    int skipFactor = 1;
    if (totalDuration < 15) skipFactor = 1; // Show all slots for short services

    int i = 0;
    while (i < slots.length) {
      final slot = slots[i];

      // Check if there are enough consecutive available slots from this position
      final canStartHere = areSlotsAvailable(slots, i, requiredSlots);

      if (canStartHere) {
        // This is a valid starting point for the service
        final endTime = getEndTime(slot.time, totalDuration);
        validStartingSlots.add({
          'slot': slot,
          'available': true,
          'endTime': endTime,
          'displayStart': formatTimeForDisplay(slot.time),
          'displayEnd': formatTimeForDisplay(endTime),
          'durationBlocks': requiredSlots,
        });

        // Skip to reduce visual clutter (for 5-minute intervals)
        i += skipFactor;
      } else if (!slot.isAvailable) {
        // Skip unavailable slots entirely to reduce clutter
        i += 1;
      } else {
        // Current slot is available but can't fit the full service
        if (i % skipFactor == 0) {
          validStartingSlots.add({
            'slot': slot,
            'available': false,
            'endTime': null,
            'displayStart': formatTimeForDisplay(slot.time),
            'reason': 'time_slots.insufficient_time'.tr(),
          });
        }
        i += 1;
      }
    }

    return validStartingSlots;
  }
}
