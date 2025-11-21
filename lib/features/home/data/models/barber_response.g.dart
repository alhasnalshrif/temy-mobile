// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barber_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarberResponseModel _$BarberResponseModelFromJson(Map<String, dynamic> json) =>
    BarberResponseModel(
      status: json['status'] as String?,
      barberDataList: (json['data'] as List<dynamic>?)
          ?.map((e) => BarberData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BarberResponseModelToJson(
  BarberResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'data': instance.barberDataList,
};

WorkingHours _$WorkingHoursFromJson(Map<String, dynamic> json) => WorkingHours(
  restTime: json['restTime'] == null
      ? null
      : RestTime.fromJson(json['restTime'] as Map<String, dynamic>),
  start: json['start'] as String?,
  end: json['end'] as String?,
  daysOff: (json['daysOff'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$WorkingHoursToJson(WorkingHours instance) =>
    <String, dynamic>{
      'restTime': instance.restTime,
      'start': instance.start,
      'end': instance.end,
      'daysOff': instance.daysOff,
    };

RestTime _$RestTimeFromJson(Map<String, dynamic> json) =>
    RestTime(start: json['start'] as String?, end: json['end'] as String?);

Map<String, dynamic> _$RestTimeToJson(RestTime instance) => <String, dynamic>{
  'start': instance.start,
  'end': instance.end,
};

BarberData _$BarberDataFromJson(Map<String, dynamic> json) => BarberData(
  id: json['_id'] as String?,
  name: json['name'] as String?,
  phone: json['phone'] as String?,
  countryCode: json['countryCode'] as String?,
  role: json['role'] as String?,
  avatar: json['avatar'] as String?,
  about: json['about'] as String?,
  portfolioImages: (json['portfolioImages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  averageRating: (json['averageRating'] as num?)?.toDouble(),
  numberOfReviews: (json['numberOfReviews'] as num?)?.toInt(),
  version: (json['__v'] as num?)?.toInt(),
  workingHours: json['workingHours'] == null
      ? null
      : WorkingHours.fromJson(json['workingHours'] as Map<String, dynamic>),
  featured: json['featured'] as bool?,
);

Map<String, dynamic> _$BarberDataToJson(BarberData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'countryCode': instance.countryCode,
      'role': instance.role,
      'avatar': instance.avatar,
      'about': instance.about,
      'portfolioImages': instance.portfolioImages,
      'averageRating': instance.averageRating,
      'numberOfReviews': instance.numberOfReviews,
      '__v': instance.version,
      'workingHours': instance.workingHours,
      'featured': instance.featured,
    };
