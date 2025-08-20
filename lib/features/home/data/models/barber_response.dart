import 'package:json_annotation/json_annotation.dart';

part 'barber_response.g.dart';

@JsonSerializable()
class BarberResponseModel {
  final String? status;

  @JsonKey(name: 'data')
  final List<BarberData>? barberDataList;

  BarberResponseModel({
    this.status,
    this.barberDataList,
  });

  factory BarberResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BarberResponseModelFromJson(json);
}

@JsonSerializable()
class WorkingHours {
  @JsonKey(name: 'restTime')
  final RestTime? restTime;

  final String? start;
  final String? end;

  @JsonKey(name: 'daysOff')
  final List<String>? daysOff;

  WorkingHours({
    this.restTime,
    this.start,
    this.end,
    this.daysOff,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursFromJson(json);
}

@JsonSerializable()
class RestTime {
  final String? start;
  final String? end;

  RestTime({
    this.start,
    this.end,
  });

  factory RestTime.fromJson(Map<String, dynamic> json) =>
      _$RestTimeFromJson(json);
}

@JsonSerializable()
class BarberData {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? phone;
  final String? countryCode;
  final String? role;
  final String? avatar;
  final String? about;

  @JsonKey(name: 'portfolioImages')
  final List<String>? portfolioImages;

  @JsonKey(name: 'averageRating')
  final double? averageRating;

  @JsonKey(name: 'numberOfReviews')
  final int? numberOfReviews;

  @JsonKey(name: '__v')
  final int? version;

  @JsonKey(name: 'workingHours')
  final WorkingHours? workingHours;

  final bool? featured;

  BarberData({
    this.id,
    this.name,
    this.phone,
    this.countryCode,
    this.role,
    this.avatar,
    this.about,
    this.portfolioImages,
    this.averageRating,
    this.numberOfReviews,
    this.version,
    this.workingHours,
    this.featured,
  });

  factory BarberData.fromJson(Map<String, dynamic> json) =>
      _$BarberDataFromJson(json);
}
