import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/reservations/logic/calendar_logic.dart';

class CalendarSection extends StatefulWidget {
  final int maxBookingDays;
  final DateTime initialDate;
  final DateTime initialMonth;
  final Function(DateTime) onDateSelected;
  final Function(DateTime) onMonthChanged;
  final List<int>? daysOff;
  final CalendarLogic? logic;

  const CalendarSection({
    super.key,
    required this.maxBookingDays,
    required this.initialDate,
    required this.initialMonth,
    required this.onDateSelected,
    required this.onMonthChanged,
    this.daysOff,
    this.logic,
  });

  static const _defaultLogic = CalendarLogic();

  @override
  State<CalendarSection> createState() => _CalendarSectionState();
}

class _CalendarSectionState extends State<CalendarSection>
    with SingleTickerProviderStateMixin {
  late DateTime selectedDate;
  late DateTime currentMonth;
  late AnimationController _animationController;
  late Animation<double> _animation;

  CalendarLogic get _logic => widget.logic ?? CalendarSection._defaultLogic;

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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        _buildHeader(),
        const SizedBox(height: 15),
        _buildCalendarCard(),
      ],
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('calendar.today'.tr(), style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        _buildBookingDaysBadge(),
      ],
    );
  }

  Widget _buildBookingDaysBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Row(
        children: [
          Image.asset('assets/icons/calendar.png', width: 18, height: 18),
          const SizedBox(width: 6),
          Text(
            'calendar.booking_available_days'.tr(args: ['${widget.maxBookingDays}']),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: ColorsManager.mainBlue),
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCard() {
    final daysResult = _logic.generateMonthGrid(currentMonth);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.mainBlue.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildMonthHeader(),
          const SizedBox(height: 16),
          _buildWeekdayHeaders(),
          const SizedBox(height: 12),
          FadeTransition(
            opacity: _animation,
            child: _buildCalendarGrid(daysResult),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: ColorsManager.mainBlue.withOpacity(0.04),
      ),
      child: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Text(
            _logic.formatMonthYear(currentMonth),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: ColorsManager.mainBlue),
          ),
        ),
      ),
    );
  }

  Widget _buildWeekdayHeaders() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(7, (index) {
        final isDayOff = _logic.isBarberDayOffByIndex(index, widget.daysOff);
        final shortcut = _logic.getArabicDayShortcut(index);
        final fullName = _logic.getLocalizedDayName(index);

        return Tooltip(
          message: fullName + (isDayOff ? ' ${'calendar.day_off'.tr()}' : ''),
          child: Container(
            width: 36,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: isDayOff ? ColorsManager.red.withAlpha(25) : Colors.transparent,
            ),
            child: Center(
              child: Text(
                shortcut,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDayOff ? ColorsManager.red.withAlpha(200) : Colors.grey.shade400,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildCalendarGrid(CalendarGridResult daysResult) {
    return Column(
      children: daysResult.weeks.map((rowDays) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 14.0),
          child: _buildCalendarRow(rowDays),
        );
      }).toList(),
    );
  }

  Widget _buildCalendarRow(List<DateTime> dates) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: dates.map((date) {
        final dateInfo = _logic.getCellInfo(
          date: date,
          selectedDate: selectedDate,
          currentMonth: currentMonth,
          maxBookingDays: widget.maxBookingDays,
          daysOff: widget.daysOff,
        );

        return GestureDetector(
          onTap: dateInfo.isSelectable
              ? () {
                  setState(() {
                    selectedDate = date;
                    widget.onDateSelected(date);
                  });
                }
              : null,
          child: CalendarDateCell(info: dateInfo, style: _logic.getCellStyle(dateInfo)),
        );
      }).toList(),
    );
  }
}

/// Individual calendar date cell widget
class CalendarDateCell extends StatelessWidget {
  final CalendarCellInfo info;
  final CalendarCellStyle style;

  const CalendarDateCell({
    super.key,
    required this.info,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 36,
      height: 36,
      decoration: style.decoration,
      alignment: Alignment.center,
      child: Text(
        info.date.day.toString(),
        style: TextStyle(
          color: style.textColor,
          fontWeight: style.fontWeight,
          fontSize: 14,
        ),
      ),
    );
  }
}
