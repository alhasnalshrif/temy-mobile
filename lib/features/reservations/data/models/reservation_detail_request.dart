import 'package:json_annotation/json_annotation.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';

part 'reservation_detail_request.g.dart';

@JsonSerializable()
class ReservationRequestModel {
  final String? user;
  @JsonKey(name: 'serviceIds')
  final List<String> serviceIds;
  @JsonKey(name: 'barberId')
  final String barberId;
  @JsonKey(name: 'date')
  final String date;
  @JsonKey(name: 'startTime')
  final String startTime;
  @JsonKey(name: 'guest', includeIfNull: false)
  final GuestInfo? guest;
  @JsonKey(name: 'note', includeIfNull: false)
  final String? note;

  ReservationRequestModel({
    this.user,
    required this.serviceIds,
    required this.barberId,
    required this.date,
    required this.startTime,
    this.guest,
    this.note,
  });

  factory ReservationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationRequestModelToJson(this);
}

@JsonSerializable()
class MultipleReservationsRequestModel {
  @JsonKey(name: 'reservations')
  final List<ReservationRequestModel> reservations;

  MultipleReservationsRequestModel({required this.reservations});

  factory MultipleReservationsRequestModel.fromJson(
    Map<String, dynamic> json,
  ) => _$MultipleReservationsRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MultipleReservationsRequestModelToJson(this);
}
