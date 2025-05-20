import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';

class MultiReservationManager {
  static final MultiReservationManager _instance =
      MultiReservationManager._internal();
  factory MultiReservationManager() => _instance;

  MultiReservationManager._internal();

  List<ReservationArguments> _reservations = [];

  List<ReservationArguments> get reservations => _reservations;

  void addReservation(ReservationArguments reservation) {
    _reservations.add(reservation);
  }

  void clearReservations() {
    _reservations.clear();
  }

  void removeReservation(int index) {
    if (index >= 0 && index < _reservations.length) {
      _reservations.removeAt(index);
    }
  }

  double getTotalPrice() {
    return _reservations.fold(
        0, (total, reservation) => total + reservation.totalPrice);
  }

  List<Map<String, dynamic>> getReservationsData(
      {ReservationArguments? currentReservation}) {
    final List<ReservationArguments> allReservations =
        currentReservation != null
            ? [..._reservations, currentReservation]
            : _reservations;

    return allReservations.map((reservation) {
      final serviceIds = reservation.selectedServices.map((s) => s.id).toList();
      final barberId = reservation.barberData?.id ?? '';
      final date =
          '${reservation.selectedDate!.year}-${reservation.selectedDate!.month.toString().padLeft(2, '0')}-${reservation.selectedDate!.day.toString().padLeft(2, '0')}';

      return {
        'serviceIds': serviceIds,
        'barberId': barberId,
        'date': date,
        'startTime': reservation.selectedTime!,
      };
    }).toList();
  }
}
