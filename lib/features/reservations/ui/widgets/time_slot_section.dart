import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart' as barber;
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart' as reservation;
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';
import 'package:temy_barber/features/reservations/logic/time_slot_calculator.dart';

class TimeSlotSection extends StatelessWidget {
  final BarberDetailData? barberData;
  final String? selectedTime;
  final int totalDuration;
  final ValueChanged<String?> onTimeSelected;
  final bool isLoading;
  final TimeSlotsResponse? timeSlotsData;
  final TimeSlotCalculator? calculator;

  const TimeSlotSection({
    super.key,
    required this.barberData,
    required this.selectedTime,
    required this.onTimeSelected,
    required this.totalDuration,
    this.isLoading = false,
    this.timeSlotsData,
    this.calculator,
  });

  static const _defaultCalculator = TimeSlotCalculator();

  TimeSlotCalculator get _calculator => calculator ?? _defaultCalculator;

  @override
  Widget build(BuildContext context) {
    final timeSlots = _getTimeSlots();
    final optimizedSlots = _calculator.getOptimizedTimeSlots(timeSlots, totalDuration);
    final hasValidSelectedTime = _validateSelectedTime(optimizedSlots);

    _clearInvalidSelection(hasValidSelectedTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        const SizedBox(height: 16),
        _buildSlotsGrid(optimizedSlots),
        if (selectedTime != null) _buildSelectedTimeSummary(),
      ],
    );
  }

  List<reservation.TimeSlot> _getTimeSlots() {
    return timeSlotsData?.data.slots ??
        (barberData?.availability.slots
                .map((slot) => _convertBarberTimeSlot(slot))
                .toList() ??
            []);
  }

  bool _validateSelectedTime(List<OptimizedTimeSlot> optimizedSlots) {
    return selectedTime != null &&
        optimizedSlots.any((slot) => slot.isAvailable && slot.slot.time == selectedTime);
  }

  void _clearInvalidSelection(bool hasValidSelectedTime) {
    if (selectedTime != null && !hasValidSelectedTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onTimeSelected(null);
      });
    }
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          'time_slots.available_time'.tr(),
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
              'time_slots.service_duration'.tr(args: [totalDuration.toString()]),
              style: const TextStyle(
                fontSize: 12,
                color: ColorsManager.mainBlue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSlotsGrid(List<OptimizedTimeSlot> optimizedSlots) {
    if (isLoading) {
      return SizedBox(height: 100, child: Center(child: ShimmerLoading.rectangular(height: 60)));
    }

    if (optimizedSlots.isEmpty) {
      return SizedBox(
        height: 100,
        child: Center(
          child: Text('time_slots.no_slots'.tr(), style: const TextStyle(fontSize: 16, color: Colors.grey)),
        ),
      );
    }

    return _TimeSlotGrid(
      slots: optimizedSlots,
      selectedTime: selectedTime,
      onTimeSelected: onTimeSelected,
      calculator: _calculator,
    );
  }

  Widget _buildSelectedTimeSummary() {
    final selectionStartDisplay = _calculator.formatTimeForDisplay(selectedTime!);
    final selectionEndDisplay = _calculator.formatTimeForDisplay(
      _calculator.getEndTime(selectedTime!, totalDuration),
    );

    return Column(
      children: [
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: ColorsManager.lightBlue,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.access_time, color: ColorsManager.mainBlue, size: 16),
              const SizedBox(width: 8),
              Text(
                'time_slots.booking_summary'.tr(args: [selectionStartDisplay, selectionEndDisplay]),
                style: const TextStyle(fontSize: 14, color: ColorsManager.mainBlue, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ],
    );
  }

  reservation.TimeSlot _convertBarberTimeSlot(barber.TimeSlot slot) {
    return reservation.TimeSlot(time: slot.time, isAvailable: slot.isAvailable);
  }
}

class _TimeSlotGrid extends StatelessWidget {
  final List<OptimizedTimeSlot> slots;
  final String? selectedTime;
  final ValueChanged<String?> onTimeSelected;
  final TimeSlotCalculator calculator;

  const _TimeSlotGrid({
    required this.slots,
    required this.selectedTime,
    required this.onTimeSelected,
    required this.calculator,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = slots.length > 20 ? 5 : 4;
    const crossAxisSpacing = 8.0;
    const mainAxisSpacing = 8.0;

    final itemWidth = (screenWidth - 32 - (crossAxisSpacing * (crossAxisCount - 1))) / crossAxisCount;
    final itemHeight = itemWidth / 1.5;
    final rows = (slots.length / crossAxisCount).ceil();
    final totalHeight = (rows * itemHeight) + ((rows - 1) * mainAxisSpacing) + 40;

    return SizedBox(
      height: totalHeight,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: 1.5,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
        ),
        itemCount: slots.length,
        itemBuilder: (context, index) => _TimeSlotTile(
          slot: slots[index],
          isSelected: selectedTime == slots[index].slot.time,
          onTap: () => onTimeSelected(slots[index].slot.time),
        ),
      ),
    );
  }
}

class _TimeSlotTile extends StatelessWidget {
  final OptimizedTimeSlot slot;
  final bool isSelected;
  final VoidCallback onTap;

  const _TimeSlotTile({
    required this.slot,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: slot.isAvailable ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: _getBackgroundColor(),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                slot.displayStart,
                style: TextStyle(
                  color: _getTextColor(),
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              if (slot.isAvailable && slot.displayEnd != null)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    slot.displayEnd!,
                    style: TextStyle(
                      color: isSelected ? Colors.white70 : ColorsManager.mainBlue,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              if (!slot.isAvailable)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    slot.unavailableReason == null
                        ? 'time_slots.unavailable'.tr()
                        : slot.unavailableReason!.tr(),
                    style: const TextStyle(color: Colors.grey, fontSize: 9),
                    textAlign: TextAlign.center,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getBackgroundColor() {
    if (isSelected) return ColorsManager.mainBlue;
    if (slot.isAvailable) return ColorsManager.lightBlue;
    return Colors.grey[200]!;
  }

  Color _getTextColor() {
    if (isSelected) return Colors.white;
    if (slot.isAvailable) return ColorsManager.mainBlue;
    return Colors.grey;
  }
}
