import 'package:json_annotation/json_annotation.dart';

part 'booking_response.g.dart';

@JsonSerializable()
class BookingResponseModel {
  final String? status;
  final int? results;

  @JsonKey(name: 'data')
  final List<BookingData>? bookingDataList;

  BookingResponseModel({
    this.status,
    this.results,
    this.bookingDataList,
  });

  factory BookingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BookingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingResponseModelToJson(this);
}

@JsonSerializable()
class BookingData {
  @JsonKey(name: '_id')
  final String? id;

  final String? user;
  final BarberData? barber;

  @JsonKey(name: 'services')
  final List<ServiceData>? services;

  final String? date;
  final String? startTime;
  final int? totalDuration;
  final String? status;
  final int? totalPrice;
  final String? createdAt;
  final String? updatedAt;

  @JsonKey(name: '__v')
  final int? version;

  BookingData({
    this.id,
    this.user,
    this.barber,
    this.services,
    this.date,
    this.startTime,
    this.totalDuration,
    this.status,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory BookingData.fromJson(Map<String, dynamic> json) =>
      _$BookingDataFromJson(json);

  Map<String, dynamic> toJson() => _$BookingDataToJson(this);
}

@JsonSerializable()
class BarberData {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? avatar;

  BarberData({
    this.id,
    this.name,
    this.avatar,
  });

  factory BarberData.fromJson(Map<String, dynamic> json) =>
      _$BarberDataFromJson(json);

  Map<String, dynamic> toJson() => _$BarberDataToJson(this);
}

@JsonSerializable()
class ServiceData {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final int? price;
  final int? duration;
  final List<String>? images;
  final String? imageCover;
  final String? category;
  final bool? available;
  final String? createdAt;
  final String? updatedAt;

  @JsonKey(name: '__v')
  final int? version;

  final List<String>? barbers;
  final String? description;

  ServiceData({
    this.id,
    this.name,
    this.price,
    this.duration,
    this.images,
    this.imageCover,
    this.category,
    this.available,
    this.createdAt,
    this.updatedAt,
    this.version,
    this.barbers,
    this.description,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) =>
      _$ServiceDataFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceDataToJson(this);
}
