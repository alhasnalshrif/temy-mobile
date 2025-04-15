import 'package:json_annotation/json_annotation.dart';

part 'barber_detail_response.g.dart';

@JsonSerializable()
class BarberDetailResponseModel {
  final String status;
  final BarberDetailData data;

  BarberDetailResponseModel({
    required this.status,
    required this.data,
  });

  factory BarberDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BarberDetailResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BarberDetailResponseModelToJson(this);
}

@JsonSerializable()
class BarberDetailData {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final String phone;
  final String countryCode;
  final String role;
  final bool verified;
  final String verificationCode;
  final String verificationCodeExpires;
  final String? resetPasswordCode;
  final String avatar;
  final String? about;
  final List<String> portfolioImages;
  final double averageRating;
  final int numberOfReviews;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;
  final List<BarberReview> reviews;
  final List<BarberService> services;
  final BarberSchedule schedule;

  BarberDetailData({
    required this.id,
    required this.name,
    required this.phone,
    required this.countryCode,
    required this.role,
    required this.verified,
    required this.verificationCode,
    required this.verificationCodeExpires,
    this.resetPasswordCode,
    required this.avatar,
    this.about,
    required this.portfolioImages,
    required this.averageRating,
    required this.numberOfReviews,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.reviews,
    required this.services,
    required this.schedule,
  });

  factory BarberDetailData.fromJson(Map<String, dynamic> json) =>
      _$BarberDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$BarberDetailDataToJson(this);
}

@JsonSerializable()
class BarberService {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final int price;
  final int duration;
  final List<String> images;
  final String imageCover;
  final String category;
  final bool available;
  final String createdAt;
  final String updatedAt;
  @JsonKey(name: '__v')
  final int v;
  final List<String> barbers;
  final String description;

  BarberService({
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
    required this.v,
    required this.barbers,
    required this.description,
  });

  factory BarberService.fromJson(Map<String, dynamic> json) =>
      _$BarberServiceFromJson(json);

  Map<String, dynamic> toJson() => _$BarberServiceToJson(this);
}

@JsonSerializable()
class BarberSchedule {
  final String date;
  final BusinessHours businessHours;
  final List<TimeSlot> timeSlots;

  BarberSchedule({
    required this.date,
    required this.businessHours,
    required this.timeSlots,
  });

  factory BarberSchedule.fromJson(Map<String, dynamic> json) =>
      _$BarberScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$BarberScheduleToJson(this);
}

@JsonSerializable()
class BusinessHours {
  final String start;
  final String end;

  BusinessHours({
    required this.start,
    required this.end,
  });

  factory BusinessHours.fromJson(Map<String, dynamic> json) =>
      _$BusinessHoursFromJson(json);

  Map<String, dynamic> toJson() => _$BusinessHoursToJson(this);
}

@JsonSerializable()
class TimeSlot {
  final String startTime;
  final String formattedTime;
  final bool available;
  final bool booked;

  TimeSlot({
    required this.startTime,
    required this.formattedTime,
    required this.available,
    required this.booked,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}

@JsonSerializable()
class BarberReview {
  // This is an empty class since the JSON example shows an empty reviews array
  // You can add fields here later when you have the actual review structure

  BarberReview();

  factory BarberReview.fromJson(Map<String, dynamic> json) =>
      _$BarberReviewFromJson(json);

  Map<String, dynamic> toJson() => _$BarberReviewToJson(this);
}
