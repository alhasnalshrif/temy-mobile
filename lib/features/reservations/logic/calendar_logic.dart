import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';

/// Constants for calendar configuration
class CalendarConfig {
  static const int daysInWeek = 7;
  static const int maxCalendarWeeks = 6;
  static const int totalDayCells = 42; // 6 weeks × 7 days
  static const int weekendStart = 6; // Saturday
  static const Color unavailableColor = Color(0xFFBDBDBD);
  static const Color dayOffTextColor = Color(0xFFE53935);
  static const Color selectedDayColor = ColorsManager.mainBlue;
  static const Color todayBorderColor = ColorsManager.mainBlue;
}

/// Value object representing calendar cell information
class CalendarCellInfo {
  final DateTime date;
  final bool isSelected;
  final bool isCurrentMonth;
  final bool isSelectable;
  final bool isToday;
  final bool isDayOff;

  const CalendarCellInfo({
    required this.date,
    this.isSelected = false,
    this.isCurrentMonth = true,
    this.isSelectable = true,
    this.isToday = false,
    this.isDayOff = false,
  });

  /// Check if cell should be highlighted
  bool get isHighlighted => isSelected || isToday;

  /// Check if cell is interactive
  bool get isInteractive => isSelectable && !isDayOff;
}

/// Result of calendar grid calculation
class CalendarGridResult {
  final List<List<DateTime>> weeks;
  final List<DateTime> allDays;

  const CalendarGridResult({
    required this.weeks,
    required this.allDays,
  });

  /// Get total number of weeks
  int get weekCount => weeks.length;

  /// Get days for a specific week
  List<DateTime> getWeek(int weekIndex) {
    if (weekIndex < 0 || weekIndex >= weeks.length) return [];
    return weeks[weekIndex];
  }
}

/// Styling configuration for calendar cells
class CalendarCellStyle {
  final Color textColor;
  final FontWeight fontWeight;
  final BoxDecoration decoration;

  const CalendarCellStyle({
    required this.textColor,
    this.fontWeight = FontWeight.normal,
    required this.decoration,
  });

  /// Factory constructor for unavailable cells
  factory CalendarCellStyle.unavailable() {
    return const CalendarCellStyle(
      textColor: CalendarConfig.unavailableColor,
      decoration: BoxDecoration(shape: BoxShape.circle),
    );
  }

  /// Factory constructor for day off cells
  factory CalendarCellStyle.dayOff() {
    return CalendarCellStyle(
      textColor: CalendarConfig.dayOffTextColor,
      fontWeight: FontWeight.w500,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CalendarConfig.dayOffTextColor.withValues(alpha: 0.1),
      ),
    );
  }

  /// Factory constructor for selected cells
  factory CalendarCellStyle.selected() {
    return const CalendarCellStyle(
      textColor: Colors.white,
      fontWeight: FontWeight.bold,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: CalendarConfig.selectedDayColor,
      ),
    );
  }

  /// Factory constructor for today cells
  factory CalendarCellStyle.today() {
    return CalendarCellStyle(
      textColor: CalendarConfig.todayBorderColor,
      fontWeight: FontWeight.bold,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.fromBorderSide(
          BorderSide(color: CalendarConfig.todayBorderColor, width: 2),
        ),
      ),
    );
  }

  /// Factory constructor for default cells
  factory CalendarCellStyle.defaultCell({bool isCurrentMonth = true}) {
    return CalendarCellStyle(
      textColor: isCurrentMonth ? Colors.black87 : Colors.grey[600]!,
      decoration: const BoxDecoration(shape: BoxShape.circle),
    );
  }
}

/// Handles calendar business logic with clean separation of concerns
/// Backend is the source of truth for availability.
/// Frontend only performs basic UI validation.
class CalendarLogic {
  const CalendarLogic();

  /// Generate calendar grid for a given month
  CalendarGridResult generateMonthGrid(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
    final firstWeekday = firstDayOfMonth.weekday % CalendarConfig.daysInWeek;
    final startDate = firstDayOfMonth.subtract(Duration(days: firstWeekday));

    final allDays = _generateDayRange(startDate, daysInMonth, firstWeekday);
    final weeks = _splitIntoWeeks(allDays);

    return CalendarGridResult(weeks: weeks, allDays: allDays);
  }

  /// Generate range of days for calendar display
  List<DateTime> _generateDayRange(
    DateTime startDate,
    int daysInMonth,
    int firstWeekday,
  ) {
    final days = <DateTime>[];
    final totalDays = firstWeekday + daysInMonth;

    for (int i = 0; i < CalendarConfig.totalDayCells; i++) {
      days.add(startDate.add(Duration(days: i)));
      // Stop if we've covered all needed days and completed a week
      if (days.length > totalDays && days.length % CalendarConfig.daysInWeek == 0) {
        break;
      }
    }

    return days;
  }

  /// Split days into week rows
  List<List<DateTime>> _splitIntoWeeks(List<DateTime> days) {
    final weeks = <List<DateTime>>[];
    for (int i = 0; i < days.length; i += CalendarConfig.daysInWeek) {
      final end = (i + CalendarConfig.daysInWeek).clamp(0, days.length);
      weeks.add(days.sublist(i, end));
    }
    return weeks;
  }

  /// Check if date is within valid booking range
  bool isWithinBookingRange(DateTime date, int maxBookingDays) {
    final today = _getToday();
    final maxDate = today.add(Duration(days: maxBookingDays));

    return (date.isAtSameMomentAs(today) || date.isAfter(today)) &&
        !date.isAfter(maxDate);
  }

  /// Check if date is barber's day off
  bool isBarberDayOff(DateTime date, List<int>? daysOff) {
    if (daysOff == null || daysOff.isEmpty) return false;
    return daysOff.contains(date.weekday % CalendarConfig.daysInWeek);
  }

  /// Check if barber is off on a specific weekday index
  bool isBarberDayOffByIndex(int dayIndex, List<int>? daysOff) {
    if (daysOff == null || daysOff.isEmpty) return false;
    return daysOff.contains(dayIndex);
  }

  /// Check if backend indicates date has available slots
  bool hasAvailableSlots(TimeSlotsResponse? response) {
    if (response == null) return false;
    return !response.data.isDayOff && response.data.slots.isNotEmpty;
  }

  /// Get cell information for a specific date
  CalendarCellInfo getCellInfo({
    required DateTime date,
    required DateTime selectedDate,
    required DateTime currentMonth,
    required int maxBookingDays,
    List<int>? daysOff,
  }) {
    return CalendarCellInfo(
      date: date,
      isSelected: _isSameDay(date, selectedDate),
      isCurrentMonth: _isSameMonth(date, currentMonth),
      isSelectable: isWithinBookingRange(date, maxBookingDays),
      isToday: _isSameDay(date, _getToday()),
      isDayOff: isBarberDayOff(date, daysOff),
    );
  }

  /// Get styling for a calendar cell based on its state
  CalendarCellStyle getCellStyle(CalendarCellInfo info) {
    if (!info.isCurrentMonth && !info.isSelectable) {
      return CalendarCellStyle.unavailable();
    }

    if (info.isDayOff && info.isCurrentMonth) {
      return CalendarCellStyle.dayOff();
    }

    if (!info.isSelectable) {
      return CalendarCellStyle(
        textColor: Colors.grey[400]!,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey[200]!),
        ),
      );
    }

    if (info.isSelected) {
      return CalendarCellStyle.selected();
    }

    if (info.isToday) {
      return CalendarCellStyle.today();
    }

    return CalendarCellStyle.defaultCell(isCurrentMonth: info.isCurrentMonth);
  }

  /// Format month and year for display
  String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  /// Get abbreviated day name for Arabic calendar
  String getArabicDayShortcut(int weekdayIndex) {
    const arabicDays = ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'];
    return arabicDays[weekdayIndex];
  }

  /// Get localized full day name
  String getLocalizedDayName(int weekdayIndex) {
    const dayKeys = [
      'calendar.sunday',
      'calendar.monday',
      'calendar.tuesday',
      'calendar.wednesday',
      'calendar.thursday',
      'calendar.friday',
      'calendar.saturday',
    ];
    return dayKeys[weekdayIndex].tr();
  }

  // Private helper methods

  DateTime _getToday() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  bool _isSameMonth(DateTime a, DateTime b) {
    return a.month == b.month;
  }
}
