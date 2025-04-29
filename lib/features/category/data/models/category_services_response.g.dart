// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_services_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryServicesResponse _$CategoryServicesResponseFromJson(
        Map<String, dynamic> json) =>
    CategoryServicesResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : CategoryServicesData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryServicesResponseToJson(
        CategoryServicesResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

CategoryServicesData _$CategoryServicesDataFromJson(
        Map<String, dynamic> json) =>
    CategoryServicesData(
      category: json['category'] == null
          ? null
          : CategoryData.fromJson(json['category'] as Map<String, dynamic>),
      barbers: (json['barbers'] as List<dynamic>?)
          ?.map((e) => BarberData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryServicesDataToJson(
        CategoryServicesData instance) =>
    <String, dynamic>{
      'category': instance.category,
      'barbers': instance.barbers,
    };

BarberData _$BarberDataFromJson(Map<String, dynamic> json) => BarberData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => BarberService.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BarberDataToJson(BarberData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'services': instance.services,
    };

BarberService _$BarberServiceFromJson(Map<String, dynamic> json) =>
    BarberService(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      duration: (json['duration'] as num?)?.toInt(),
      imageCover: json['imageCover'] as String?,
      available: json['available'] as bool?,
    );

Map<String, dynamic> _$BarberServiceToJson(BarberService instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'duration': instance.duration,
      'imageCover': instance.imageCover,
      'available': instance.available,
    };
