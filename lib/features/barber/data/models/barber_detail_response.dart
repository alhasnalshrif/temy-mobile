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
  @JsonKey(name: 'id')
  final String id;
  final String name;
  final String avatar;
  final String? about;
  final List<String> portfolioImages;
  final WorkingHours workingHours;
  final Rating rating;
  final List<BarberReview> reviews;
  final List<BarberService> services;
  final Availability availability;

  BarberDetailData({
    required this.id,
    required this.name,
    required this.avatar,
    this.about,
    required this.portfolioImages,
    required this.workingHours,
    required this.rating,
    required this.reviews,
    required this.services,
    required this.availability,
  });

  factory BarberDetailData.fromJson(Map<String, dynamic> json) =>
      _$BarberDetailDataFromJson(json);

  Map<String, dynamic> toJson() => _$BarberDetailDataToJson(this);
}

@JsonSerializable()
class WorkingHours {
  final String start;
  final String end;
  final List<String> daysOff;

  WorkingHours({
    required this.start,
    required this.end,
    required this.daysOff,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingHoursToJson(this);
}

@JsonSerializable()
class Rating {
  final double average;
  final int total;

  Rating({
    required this.average,
    required this.total,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => _$RatingFromJson(json);

  Map<String, dynamic> toJson() => _$RatingToJson(this);
}

@JsonSerializable()
class BarberService {
  @JsonKey(name: 'id')
  final String id;
  final String name;
  final String description;
  final int price;
  final int duration;
  final String category;
  final String imageCover;

  BarberService({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.duration,
    required this.category,
    required this.imageCover,
  });

  factory BarberService.fromJson(Map<String, dynamic> json) =>
      _$BarberServiceFromJson(json);

  Map<String, dynamic> toJson() => _$BarberServiceToJson(this);
}

@JsonSerializable()
class Availability {
  final String date;
  @JsonKey(name: 'slots')
  final List<TimeSlot> slots;
  final bool isDayOff;

  Availability({
    required this.date,
    required this.slots,
    this.isDayOff = false,
  });

  factory Availability.fromJson(Map<String, dynamic> json) =>
      _$AvailabilityFromJson(json);

  Map<String, dynamic> toJson() => _$AvailabilityToJson(this);
}

@JsonSerializable()
class TimeSlot {
  final String time;
  final bool isAvailable;

  TimeSlot({
    required this.time,
    required this.isAvailable,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}

@JsonSerializable()
class BarberReview {
  // Empty class for now as the JSON example shows an empty reviews array

  BarberReview();

  factory BarberReview.fromJson(Map<String, dynamic> json) =>
      _$BarberReviewFromJson(json);

  Map<String, dynamic> toJson() => _$BarberReviewToJson(this);
}
