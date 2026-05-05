import 'package:flutter_test/flutter_test.dart';
import 'package:temy_barber/features/reservations/logic/calendar_logic.dart';

void main() {
  group('CalendarLogic.isWithinBookingRange', () {
    const logic = CalendarLogic();

    test('counts max booking days inclusively from today', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      expect(logic.isWithinBookingRange(today, 2), isTrue);
      expect(
        logic.isWithinBookingRange(today.add(const Duration(days: 1)), 2),
        isTrue,
      );
      expect(
        logic.isWithinBookingRange(today.add(const Duration(days: 2)), 2),
        isFalse,
      );
    });

    test('does not allow dates when max booking days is zero or negative', () {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      expect(logic.isWithinBookingRange(today, 0), isFalse);
      expect(logic.isWithinBookingRange(today, -1), isFalse);
    });
  });
}
