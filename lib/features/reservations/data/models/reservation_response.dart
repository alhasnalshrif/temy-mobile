import 'package:json_annotation/json_annotation.dart';

part 'reservation_response.g.dart';

@JsonSerializable()
class ReservationResponseModel {
  final String status;
  final String message;
  final ReservationData data;

  ReservationResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ReservationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReservationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationResponseModelToJson(this);
}

@JsonSerializable()
class BarberModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String avatar;

  BarberModel({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory BarberModel.fromJson(Map<String, dynamic> json) =>
      _$BarberModelFromJson(json);

  Map<String, dynamic> toJson() => _$BarberModelToJson(this);
}

@JsonSerializable()
class ServiceModel {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final double price;
  final int duration;
  @JsonKey(defaultValue: <String>[])
  final List<String> images;
  final String imageCover;
  final String category;
  final bool available;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int
      version; // Using dynamic type for barbers to handle both String and non-String IDs
  @JsonKey(defaultValue: <dynamic>[])
  final List<dynamic> barbers;
  final String? description;
  ServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.images,
    required this.imageCover,
    required this.category,
    required this.available,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.barbers,
    this.description,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceModelToJson(this);
}

@JsonSerializable()
class ReservationData {
  @JsonKey(name: '_id')
  final String id;
  final String user;
  @JsonKey(name: 'barber')
  final BarberModel barber;
  @JsonKey(name: 'services')
  final List<ServiceModel> services;
  final String date;
  final String startTime;
  final int totalDuration;
  final String status;
  final double totalPrice;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int version;

  ReservationData({
    required this.id,
    required this.user,
    required this.barber,
    required this.services,
    required this.date,
    required this.startTime,
    required this.totalDuration,
    required this.status,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory ReservationData.fromJson(Map<String, dynamic> json) =>
      _$ReservationDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationDataToJson(this);
}
