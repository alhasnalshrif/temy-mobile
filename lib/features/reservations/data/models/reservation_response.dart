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

  BarberModel({required this.id, required this.name, required this.avatar});

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
  final String? imageCover;
  final String? category;
  final bool? available;
  final String? createdAt;
  final String? updatedAt;
  @JsonKey(name: '__v')
  final int? version; // Using dynamic type for barbers to handle both String and non-String IDs
  @JsonKey(defaultValue: <dynamic>[])
  final List<dynamic> barbers;
  final String? description;
  ServiceModel({
    required this.id,
    required this.name,
    required this.price,
    required this.duration,
    required this.images,
    this.imageCover,
    this.category,
    this.available,
    this.createdAt,
    this.updatedAt,
    this.version,
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
  final String? user;
  @JsonKey(name: 'userName')
  final String? userName;
  @JsonKey(name: 'userPhone')
  final String? userPhone;
  @JsonKey(name: 'barber')
  final BarberModel barber;
  @JsonKey(name: 'services')
  final List<ServiceModel> services;
  final String date;
  final String startTime;
  final int totalDuration;
  final String status;
  final double totalPrice;
  final String? note;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int version;

  // Queue mode fields
  @JsonKey(name: 'is_queue_reservation')
  final bool? isQueueReservation;
  @JsonKey(name: 'queue_number')
  final int? queueNumber;
  @JsonKey(name: 'queue_position')
  final int? queuePosition;
  @JsonKey(name: 'queue_status')
  final String? queueStatus;
  @JsonKey(name: 'joined_queue_at')
  final String? joinedQueueAt;
  @JsonKey(name: 'started_service_at')
  final String? startedServiceAt;

  ReservationData({
    required this.id,
    this.user,
    this.userName,
    this.userPhone,
    required this.barber,
    required this.services,
    required this.date,
    required this.startTime,
    required this.totalDuration,
    required this.status,
    required this.totalPrice,
    this.note,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    this.isQueueReservation,
    this.queueNumber,
    this.queuePosition,
    this.queueStatus,
    this.joinedQueueAt,
    this.startedServiceAt,
  });

  factory ReservationData.fromJson(Map<String, dynamic> json) =>
      _$ReservationDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReservationDataToJson(this);
}
