import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';

class ReservationArguments {
  final List<BarberService> selectedServices;
  final BarberDetailData? barberData;
  final double totalPrice;
  final DateTime? selectedDate;
  final String? selectedTime;

  ReservationArguments({
    required this.selectedServices,
    required this.barberData,
    required this.totalPrice,
    this.selectedDate,
    this.selectedTime,
  });
}
