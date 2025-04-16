import 'package:json_annotation/json_annotation.dart';


part 'reservation_detail_request.g.dart';

@JsonSerializable()
class ReservationRequestModel {
  final String user;
  final List<String> service;
  final String barber;
  final String date;
  final String status;

  ReservationRequestModel({
    required this.user,
    required this.service,
    required this.barber,
    required this.date,
    required this.status,
  });

  factory ReservationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationRequestModelToJson(this);
}
