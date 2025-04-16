import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_complete_project/core/theme/colors.dart';

class CalendarSection extends StatefulWidget {
  final int maxBookingDays;
  final DateTime initialDate;
  final DateTime initialMonth;
  final Function(DateTime) onDateSelected;
  final Function(DateTime) onMonthChanged;

  const CalendarSection({
    super.key,
    required this.maxBookingDays,
    required this.initialDate,
    required this.initialMonth,
    required this.onDateSelected,
    required this.onMonthChanged,
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

  void _previousMonth() {
    setState(() {
      _animationController.reset();
      currentMonth = DateTime(currentMonth.year, currentMonth.month - 1, 1);
      widget.onMonthChanged(currentMonth);
      _animationController.forward();
    });
  }

  void _nextMonth() {
    setState(() {
      // Limit how far into the future users can navigate
      final now = DateTime.now();
      final maxFutureMonth = DateTime(
          now.year, now.month + (widget.maxBookingDays / 30).ceil(), 1);

      final nextMonth = DateTime(currentMonth.year, currentMonth.month + 1, 1);
      if (nextMonth.isBefore(maxFutureMonth) ||
          nextMonth.isAtSameMomentAs(maxFutureMonth)) {
        _animationController.reset();
        currentMonth = nextMonth;
        widget.onMonthChanged(currentMonth);
        _animationController.forward();
      }
    });
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
              decoration: BoxDecoration(
                color: ColorsManager.lightBlue,
                borderRadius: BorderRadius.circular(20),
                border:
                    Border.all(color: ColorsManager.mainBlue.withOpacity(0.1)),
              ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _previousMonth,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorsManager.thirdfMain,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.chevron_left,
                          color: ColorsManager.mainBlue,
                        ),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _animation,
                    child: Text(
                      _formatMonthYear(currentMonth),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _nextMonth,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorsManager.thirdfMain,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.chevron_right,
                          color: ColorsManager.mainBlue,
                        ),
                      ),
                    ),
                  ),
                ],
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
    final List<String> days = [
      'الأحد',
      'الإثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت'
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: days
          .map((day) => SizedBox(
                width: 30,
                child: Text(
                  day.substring(0, 2), // Just show first two letters
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: ColorsManager.gray,
                  ),
                ),
              ))
          .toList(),
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
          final isSelectable = _isSelectable(date) && isCurrentMonth;
          final isToday = _isToday(date);

          return GestureDetector(
            onTap: (isSelectable && isCurrentMonth)
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
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildDateCell(String date,
      {bool isSelected = false,
      bool isCurrentMonth = true,
      bool isSelectable = true,
      bool isToday = false}) {
    // Base style for all date states
    BoxDecoration decoration = const BoxDecoration(
      shape: BoxShape.circle,
    );

    Color textColor;
    FontWeight fontWeight = FontWeight.normal;

    // Apply styling based on date state
    if (!isCurrentMonth) {
      textColor = Colors.grey[350]!;
    } else if (!isSelectable) {
      textColor = Colors.grey[400]!;
      decoration = decoration.copyWith(
        border: Border.all(color: Colors.grey[300]!, width: 1),
      );
    } else if (isSelected) {
      textColor = Colors.white;
      fontWeight = FontWeight.bold;
      decoration = decoration.copyWith(
        color: ColorsManager.mainBlue,
      );
    } else if (isToday) {
      textColor = ColorsManager.mainBlue;
      fontWeight = FontWeight.bold;
      decoration = decoration.copyWith(
        border: Border.all(color: ColorsManager.mainBlue, width: 1.5),
      );
    } else {
      textColor = Colors.black87;
    }

    return Container(
      width: 35,
      height: 35,
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
