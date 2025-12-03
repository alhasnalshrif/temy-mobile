import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:temy_barber/core/theme/colors.dart';

class CalendarSection extends StatefulWidget {
  final int maxBookingDays;
  final DateTime initialDate;
  final DateTime initialMonth;
  final Function(DateTime) onDateSelected;
  final Function(DateTime) onMonthChanged;
  final List<int>? daysOff; // Days off indices (0=Sunday, 1=Monday, ..., 6=Saturday)

  const CalendarSection({
    super.key,
    required this.maxBookingDays,
    required this.initialDate,
    required this.initialMonth,
    required this.onDateSelected,
    required this.onMonthChanged,
    this.daysOff,
  });

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection>
    with SingleTickerProviderStateMixin {
  late DateTime selectedDate;
  late DateTime currentMonth;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
    currentMonth = widget.initialMonth;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  // Get the days in the current month
  List<DateTime> _getDaysInMonth(DateTime month) {
    final first = DateTime(month.year, month.month, 1);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    // Determine the first day to display (to fill the grid)
    final firstDayOfWeek = first.weekday % 7; // 0 = Sunday, 1 = Monday, etc.
    final start = first.subtract(Duration(days: firstDayOfWeek));

    // Generate all dates to display
    List<DateTime> days = [];
    for (int i = 0; i < 42; i++) {
      // 6 weeks (rows) * 7 days
      days.add(start.add(Duration(days: i)));
      // Stop after we've included enough days for the current month
      if (days.length > firstDayOfWeek + daysInMonth && days.length % 7 == 0) {
        break;
      }
    }
    return days;
  }

  // Check if date is selectable (not in the past and within booking range)
  bool _isSelectable(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final maxDate = today.add(Duration(days: widget.maxBookingDays));

    return date.isAtSameMomentAs(today) ||
        (date.isAfter(today) && date.isBefore(maxDate) ||
            date.isAtSameMomentAs(maxDate));
  }

  // Format month name
  String _formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  // Check if two dates are the same day
  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  // Check if date is today
  bool _isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  // Check if date is a day off for the barber
  bool _isDayOff(DateTime date) {
    if (widget.daysOff == null || widget.daysOff!.isEmpty) {
      return false;
    }

    // Get day of week (DateTime: 1=Monday to 7=Sunday)
    // Convert to our format (0=Sunday, 1=Monday, ..., 6=Saturday)
    final dayIndex = date.weekday % 7; // 7 (Sunday) becomes 0
    
    return widget.daysOff!.contains(dayIndex);
  }

  // Get readable day shortcut for Arabic
  String _getDayShortcut(int index) {
    // Arabic day shortcuts (single letter, more readable)
    const arabicDays = ['ح', 'ن', 'ث', 'ر', 'خ', 'ج', 'س'];
    return arabicDays[index];
  }

  // Get full day name for tooltip
  String _getFullDayName(int index) {
    const arabicFullDays = [
      'الأحد',
      'الإثنين', 
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت'
    ];
    return arabicFullDays[index];
  }

  // Check if day index is a day off (0=Sunday, 6=Saturday)
  bool _isDayIndexOff(int dayIndex) {
    if (widget.daysOff == null || widget.daysOff!.isEmpty) {
      return false;
    }
    
    return widget.daysOff!.contains(dayIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'اليوم',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 14,
                    color: ColorsManager.mainBlue,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'متاح الحجز خلال ${widget.maxBookingDays} يوم',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorsManager.mainBlue,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorsManager.thirdfMain,
                ),
                child: Center(
                  child: FadeTransition(
                    opacity: _animation,
                    child: Text(
                      _formatMonthYear(currentMonth),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              _buildCalendarDays(),
              const SizedBox(height: 12),
              FadeTransition(
                opacity: _animation,
                child: _buildCalendarDates(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarDays() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        final isDayOff = _isDayIndexOff(index);
        final shortcut = _getDayShortcut(index);
        final fullName = _getFullDayName(index);
        
        return Tooltip(
          message: fullName + (isDayOff ? ' (إجازة)' : ''),
          child: Container(
            width: 36,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: isDayOff ? Colors.red.withOpacity(0.1) : Colors.transparent,
            ),
            child: Center(
              child: Text(
                shortcut,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDayOff ? Colors.red[400] : ColorsManager.gray,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCalendarDates() {
    final days = _getDaysInMonth(currentMonth);
    final List<Widget> rows = [];

    for (var i = 0; i < days.length; i += 7) {
      final rowDays =
          days.sublist(i, i + 7 > days.length ? days.length : i + 7);
      rows.add(_buildCalendarRow(rowDays));
    }

    return Column(children: rows);
  }

  Widget _buildCalendarRow(List<DateTime> dates) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: dates.map((date) {
          final isSelected = _isSameDay(date, selectedDate);
          final isCurrentMonth = date.month == currentMonth.month;
          final isDayOff = _isDayOff(date);
          final isSelectable = _isSelectable(date) && isCurrentMonth && !isDayOff;
          final isToday = _isToday(date);

          return GestureDetector(
            onTap: isSelectable
                ? () {
                    setState(() {
                      selectedDate = date;
                      widget.onDateSelected(date);
                    });
                  }
                : null,
            child: _buildDateCell(
              date.day.toString(),
              isSelected: isSelected,
              isCurrentMonth: isCurrentMonth,
              isSelectable: isSelectable,
              isToday: isToday,
              isDayOff: isDayOff,
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateCell(
    String date, {
    bool isSelected = false,
    bool isCurrentMonth = true,
    bool isSelectable = true,
    bool isToday = false,
    bool isDayOff = false,
  }) {
    // Base style for all date states
    BoxDecoration decoration = const BoxDecoration(
      shape: BoxShape.circle,
    );

    Color textColor;
    FontWeight fontWeight = FontWeight.normal;

    // Apply styling based on date state (priority order matters)
    if (!isCurrentMonth) {
      // Days from other months - very faded
      textColor = Colors.grey[300]!;
    } else if (isDayOff && isCurrentMonth) {
      // Day off - show with red styling
      textColor = Colors.red[300]!;
      fontWeight = FontWeight.w500;
      decoration = decoration.copyWith(
        color: Colors.red.withOpacity(0.08),
      );
    } else if (!isSelectable) {
      // Past dates or out of booking range
      textColor = Colors.grey[400]!;
      decoration = decoration.copyWith(
        border: Border.all(color: Colors.grey[200]!, width: 1),
      );
    } else if (isSelected) {
      // Selected date
      textColor = Colors.white;
      fontWeight = FontWeight.bold;
      decoration = decoration.copyWith(
        color: ColorsManager.mainBlue,
        boxShadow: [
          BoxShadow(
            color: ColorsManager.mainBlue.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      );
    } else if (isToday) {
      // Today's date
      textColor = ColorsManager.mainBlue;
      fontWeight = FontWeight.bold;
      decoration = decoration.copyWith(
        border: Border.all(color: ColorsManager.mainBlue, width: 2),
      );
    } else {
      // Normal selectable date
      textColor = Colors.black87;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 36,
      height: 36,
      decoration: decoration,
      alignment: Alignment.center,
      child: Text(
        date,
        style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: 14,
        ),
      ),
    );
  }
}
