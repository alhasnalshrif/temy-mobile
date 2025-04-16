import 'package:flutter_complete_project/features/barber/data/models/barber_detail_response.dart';

class ReservationArguments {
  final List<BarberService> selectedServices;
  final BarberDetailData? barberData;
  final double totalPrice;

  ReservationArguments({
    required this.selectedServices,
    required this.barberData,
    required this.totalPrice,
  });
}
