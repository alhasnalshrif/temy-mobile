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
        BarberResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.barberDataList,
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
    };
