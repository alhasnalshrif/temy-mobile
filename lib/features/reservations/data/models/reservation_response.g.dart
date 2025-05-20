// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationResponseModel _$ReservationResponseModelFromJson(
        Map<String, dynamic> json) =>
    ReservationResponseModel(
      status: json['status'] as String,
      message: json['message'] as String,
      data: ReservationData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReservationResponseModelToJson(
        ReservationResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

BarberModel _$BarberModelFromJson(Map<String, dynamic> json) => BarberModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String,
    );

Map<String, dynamic> _$BarberModelToJson(BarberModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
    };

ServiceModel _$ServiceModelFromJson(Map<String, dynamic> json) => ServiceModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      duration: (json['duration'] as num).toInt(),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      imageCover: json['imageCover'] as String,
      category: json['category'] as String,
      available: json['available'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: (json['__v'] as num).toInt(),
      barbers: json['barbers'] as List<dynamic>? ?? [],
      description: json['description'] as String?,
    );

Map<String, dynamic> _$ServiceModelToJson(ServiceModel instance) =>
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

ReservationData _$ReservationDataFromJson(Map<String, dynamic> json) =>
    ReservationData(
      id: json['_id'] as String,
      user: json['user'] as String,
      barber: BarberModel.fromJson(json['barber'] as Map<String, dynamic>),
      services: (json['services'] as List<dynamic>)
          .map((e) => ServiceModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      totalDuration: (json['totalDuration'] as num).toInt(),
      status: json['status'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      version: (json['__v'] as num).toInt(),
    );

Map<String, dynamic> _$ReservationDataToJson(ReservationData instance) =>
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
