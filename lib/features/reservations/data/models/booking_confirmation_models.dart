import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';

/// Result of booking validation
class BookingValidationResult {
  final bool isValid;
  final String? errorMessage;

  BookingValidationResult({required this.isValid, this.errorMessage});
}

/// Data class for booking confirmation
class BookingConfirmationData {
  final String date;
  final String startTime;
  final List<String> serviceIds;
  final String barberId;
  final String? userId;
  final GuestInfo? guestInfo;
  final ReservationArguments arguments;

  BookingConfirmationData({
    required this.date,
    required this.startTime,
    required this.serviceIds,
    required this.barberId,
    this.userId,
    this.guestInfo,
    required this.arguments,
  });
}
