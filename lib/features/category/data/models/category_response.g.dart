// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryServicesResponseModel _$CategoryServicesResponseModelFromJson(
        Map<String, dynamic> json) =>
    CategoryServicesResponseModel(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : CategoryDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CategoryServicesResponseModelToJson(
        CategoryServicesResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

CategoryDetailData _$CategoryDetailDataFromJson(Map<String, dynamic> json) =>
    CategoryDetailData(
      category: json['category'] == null
          ? null
          : CategoryData.fromJson(json['category'] as Map<String, dynamic>),
      barbers: (json['barbers'] as List<dynamic>?)
          ?.map((e) => BarberData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CategoryDetailDataToJson(CategoryDetailData instance) =>
    <String, dynamic>{
      'category': instance.category,
      'barbers': instance.barbers,
    };

CategoryData _$CategoryDataFromJson(Map<String, dynamic> json) => CategoryData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      imageCover: json['imageCover'] as String?,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CategoryDataToJson(CategoryData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'imageCover': instance.imageCover,
      '__v': instance.version,
    };

BarberData _$BarberDataFromJson(Map<String, dynamic> json) => BarberData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      services: (json['services'] as List<dynamic>?)
          ?.map((e) => ServiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BarberDataToJson(BarberData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'services': instance.services,
    };

ServiceData _$ServiceDataFromJson(Map<String, dynamic> json) => ServiceData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: (json['price'] as num?)?.toInt(),
      duration: (json['duration'] as num?)?.toInt(),
      imageCover: json['imageCover'] as String?,
      available: json['available'] as bool?,
    );

Map<String, dynamic> _$ServiceDataToJson(ServiceData instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'duration': instance.duration,
      'imageCover': instance.imageCover,
      'available': instance.available,
    };
