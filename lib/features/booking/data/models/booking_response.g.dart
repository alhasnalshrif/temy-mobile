// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingResponseModel _$BookingResponseModelFromJson(
        Map<String, dynamic> json) =>
    BookingResponseModel(
      status: json['status'] as String?,
      results: (json['results'] as num?)?.toInt(),
      bookingDataList: (json['data'] as List<dynamic>?)
          ?.map((e) => BookingData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookingResponseModelToJson(
        BookingResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'results': instance.results,
      'data': instance.bookingDataList,
    };

BookingData _$BookingDataFromJson(Map<String, dynamic> json) => BookingData(
      id: json['_id'] as String?,
      user: json['user'] as String?,
      barber: json['barber'] == null
          ? null
          : BarberData.fromJson(json['barber'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: json['date'] as String?,
      startTime: json['startTime'] as String?,
      totalDuration: (json['totalDuration'] as num?)?.toInt(),
      status: json['status'] as String?,
      totalPrice: (json['totalPrice'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BookingDataToJson(BookingData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'user': instance.user,
      'barber': instance.barber,
      'services': instance.services,
      'date': instance.date,
      'startTime': instance.startTime,
      'totalDuration': instance.totalDuration,
      'status': instance.status,
      'totalPrice': instance.totalPrice,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
    };

BarberData _$BarberDataFromJson(Map<String, dynamic> json) => BarberData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$BarberDataToJson(BarberData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
    };

ServiceData _$ServiceDataFromJson(Map<String, dynamic> json) => ServiceData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      imageCover: json['imageCover'] as String?,
      category: json['category'] as String?,
      available: json['available'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      version: (json['__v'] as num?)?.toInt(),
      barbers:
          (json['barbers'] as List<dynamic>?)?.map((e) => e as String).toList(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ServiceDataToJson(ServiceData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'duration': instance.duration,
      'images': instance.images,
      'imageCover': instance.imageCover,
      'category': instance.category,
      'available': instance.available,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
      'barbers': instance.barbers,
      'description': instance.description,
    };
