import 'package:json_annotation/json_annotation.dart';

part 'reservation_detail_request.g.dart';

@JsonSerializable()
class ReservationRequestModel {
  final String user;
  @JsonKey(name: 'serviceIds')
  final List<String> serviceIds;
  @JsonKey(name: 'barberId')
  final String barberId;
  @JsonKey(name: 'date')
  final String date;
  @JsonKey(name: 'startTime')
  final String startTime;

  ReservationRequestModel({
    required this.user,
    required this.serviceIds,
    required this.barberId,
    required this.date,
    required this.startTime,
  });

  factory ReservationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationRequestModelToJson(this);
}
