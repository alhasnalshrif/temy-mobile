import 'package:flutter/foundation.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';

/// Result of time slot optimization
class OptimizedTimeSlot {
  final TimeSlot slot;
  final bool isAvailable;
  final String? endTime;
  final String displayStart;
  final String? displayEnd;
  final String? unavailableReason;
  final int durationBlocks;

  OptimizedTimeSlot({
    required this.slot,
    required this.isAvailable,
    this.endTime,
    required this.displayStart,
    this.displayEnd,
    this.unavailableReason,
    required this.durationBlocks,
  });

  Map<String, dynamic> toMap() {
    return {
      'slot': slot,
      'available': isAvailable,
      'endTime': endTime,
      'displayStart': displayStart,
      'displayEnd': displayEnd,
      'reason': unavailableReason,
      'durationBlocks': durationBlocks,
    };
  }
}

/// Handles time slot calculations and formatting
class TimeSlotCalculator {
  const TimeSlotCalculator();

  /// Calculate slot duration based on consecutive time slots
  int calculateSlotDuration(List<TimeSlot> slots) {
    if (slots.length < 2) return 5;

    try {
      final firstTime = _timeStringToMinutes(_sanitizeTimeString(slots[0].time));
      final secondTime = _timeStringToMinutes(_sanitizeTimeString(slots[1].time));

      int diff = secondTime - firstTime;
      if (diff < 0) {
        diff += 24 * 60;
      }

      return diff > 0 ? diff : 5;
    } catch (e) {
      debugPrint('Error calculating slot duration: $e');
      return 5;
    }
  }

  /// Get optimized time slots for display based on service duration
  List<OptimizedTimeSlot> getOptimizedTimeSlots(
    List<TimeSlot> slots,
    int totalDuration,
  ) {
    if (slots.isEmpty) return [];

    final slotDurationMinutes = calculateSlotDuration(slots);
    final requiredSlots = (totalDuration / slotDurationMinutes).ceil();

    final List<OptimizedTimeSlot> validStartingSlots = [];

    int skipFactor = 1;
    if (totalDuration < 15) skipFactor = 1;

    int i = 0;
    while (i < slots.length) {
      final slot = slots[i];

      final canStartHere = _areSlotsAvailable(slots, i, requiredSlots);

      if (canStartHere) {
        final endTime = getEndTime(slot.time, totalDuration);
        validStartingSlots.add(OptimizedTimeSlot(
          slot: slot,
          isAvailable: true,
          endTime: endTime,
          displayStart: formatTimeForDisplay(slot.time),
          displayEnd: formatTimeForDisplay(endTime),
          durationBlocks: requiredSlots,
        ));

        i += skipFactor;
      } else if (!slot.isAvailable) {
        i += 1;
      } else {
        if (i % skipFactor == 0) {
          validStartingSlots.add(OptimizedTimeSlot(
            slot: slot,
            isAvailable: false,
            endTime: null,
            displayStart: formatTimeForDisplay(slot.time),
            unavailableReason: 'time_slots.insufficient_time',
            durationBlocks: requiredSlots,
          ));
        }
        i += 1;
      }
    }

    return validStartingSlots;
  }

  /// Format time for display with AM/PM (public for reuse)
  String formatTimeForDisplay(String time) {
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

  /// Calculate end time based on start time and duration (public for reuse)
  String getEndTime(String startTime, int durationMinutes) {
    try {
      final normalizedStart = _sanitizeTimeString(startTime);
      final parts = normalizedStart.split(':');
      if (parts.length < 2) {
        return normalizedStart;
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
      return _sanitizeTimeString(startTime);
    }
  }

  /// Check if consecutive slots are available
  bool _areSlotsAvailable(List<TimeSlot> slots, int startIndex, int requiredSlots) {
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

  /// Convert time string to total minutes
  int _timeStringToMinutes(String timeString) {
    final parts = timeString.split(':');
    if (parts.length < 2) return 0;

    final hours = int.tryParse(parts[0]) ?? 0;
    final minutes = int.tryParse(parts[1]) ?? 0;

    return (hours * 60) + minutes;
  }

  /// Sanitize time string for consistent parsing
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
}
