// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barber_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarberDetailResponseModel _$BarberDetailResponseModelFromJson(
  Map<String, dynamic> json,
) => BarberDetailResponseModel(
  status: json['status'] as String,
  data: BarberDetailData.fromJson(json['data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$BarberDetailResponseModelToJson(
  BarberDetailResponseModel instance,
) => <String, dynamic>{'status': instance.status, 'data': instance.data};

BarberDetailData _$BarberDetailDataFromJson(Map<String, dynamic> json) =>
    BarberDetailData(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
      about: json['about'] as String?,
      portfolioImages: (json['portfolioImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      maxReservationDays: (json['max_reservation_days'] as num).toInt(),
      workingHours: WorkingHours.fromJson(
        json['workingHours'] as Map<String, dynamic>,
      ),
      rating: Rating.fromJson(json['rating'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>)
          .map((e) => BarberService.fromJson(e as Map<String, dynamic>))
          .toList(),
      availability: Availability.fromJson(
        json['availability'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$BarberDetailDataToJson(BarberDetailData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'about': instance.about,
      'portfolioImages': instance.portfolioImages,
      'max_reservation_days': instance.maxReservationDays,
      'workingHours': instance.workingHours,
      'rating': instance.rating,
      'services': instance.services,
      'availability': instance.availability,
    };

WorkingHours _$WorkingHoursFromJson(Map<String, dynamic> json) => WorkingHours(
  start: json['start'] as String,
  end: json['end'] as String,
  daysOff: (json['daysOff'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$WorkingHoursToJson(WorkingHours instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
      'daysOff': instance.daysOff,
    };

Rating _$RatingFromJson(Map<String, dynamic> json) => Rating(
  average: (json['average'] as num).toDouble(),
  total: (json['total'] as num).toInt(),
);

Map<String, dynamic> _$RatingToJson(Rating instance) => <String, dynamic>{
  'average': instance.average,
  'total': instance.total,
};

BarberService _$BarberServiceFromJson(Map<String, dynamic> json) =>
    BarberService(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      category: json['category'] as String,
      imageCover: json['imageCover'] as String?,
    );

Map<String, dynamic> _$BarberServiceToJson(BarberService instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'duration': instance.duration,
      'category': instance.category,
      'imageCover': instance.imageCover,
    };

Availability _$AvailabilityFromJson(Map<String, dynamic> json) => Availability(
  date: json['date'] as String,
  slots: (json['slots'] as List<dynamic>)
      .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
      .toList(),
  isDayOff: json['isDayOff'] as bool? ?? false,
);

Map<String, dynamic> _$AvailabilityToJson(Availability instance) =>
    <String, dynamic>{
      'date': instance.date,
      'slots': instance.slots,
      'isDayOff': instance.isDayOff,
    };

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
  time: json['time'] as String,
  isAvailable: json['isAvailable'] as bool,
);

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
  'time': instance.time,
  'isAvailable': instance.isAvailable,
};

BarberReview _$BarberReviewFromJson(Map<String, dynamic> json) =>
    BarberReview();

Map<String, dynamic> _$BarberReviewToJson(BarberReview instance) =>
    <String, dynamic>{};
