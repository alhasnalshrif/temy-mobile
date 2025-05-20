import 'package:json_annotation/json_annotation.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';

part 'multiple_reservation_response.g.dart';

@JsonSerializable()
class MultipleReservationResponseModel {
  final String status;
  final String message;
  final MultipleReservationData data;

  MultipleReservationResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory MultipleReservationResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MultipleReservationResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MultipleReservationResponseModelToJson(this);

  // Convert to standard ReservationResponseModel for backwards compatibility
  ReservationResponseModel toReservationResponseModel() {
    // Use the first reservation as the main reservation for compatibility
    if (data.reservations.isNotEmpty) {
      return ReservationResponseModel(
        status: status,
        message: message,
        // Create a "synthetic" single reservation response using the first reservation
        data: data.reservations.first,
      );
    } else {
      // Fallback if no reservations are present (shouldn't happen)
      throw Exception('No reservations found in multiple reservation response');
    }
  }
}

@JsonSerializable()
class MultipleReservationData {
  @JsonKey(name: 'reservations')
  final List<ReservationData> reservations;
  final int successCount;
  final int errorCount;

  MultipleReservationData({
    required this.reservations,
    required this.successCount,
    required this.errorCount,
  });

  factory MultipleReservationData.fromJson(Map<String, dynamic> json) =>
      _$MultipleReservationDataFromJson(json);

  Map<String, dynamic> toJson() => _$MultipleReservationDataToJson(this);
}
