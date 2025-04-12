// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ServiceResponseModel _$ServiceResponseModelFromJson(
        Map<String, dynamic> json) =>
    ServiceResponseModel(
      status: json['status'] as String?,
      results: (json['results'] as num?)?.toInt(),
      paginationResult: json['paginationResult'] == null
          ? null
          : PaginationResult.fromJson(
              json['paginationResult'] as Map<String, dynamic>),
      serviceDataList: (json['data'] as List<dynamic>?)
          ?.map((e) => ServiceData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ServiceResponseModelToJson(
        ServiceResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'results': instance.results,
      'paginationResult': instance.paginationResult,
      'data': instance.serviceDataList,
    };

PaginationResult _$PaginationResultFromJson(Map<String, dynamic> json) =>
    PaginationResult(
      currentPage: (json['currentPage'] as num?)?.toInt(),
      limit: (json['limit'] as num?)?.toInt(),
      numberOfPages: (json['numberOfPages'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PaginationResultToJson(PaginationResult instance) =>
    <String, dynamic>{
      'currentPage': instance.currentPage,
      'limit': instance.limit,
      'numberOfPages': instance.numberOfPages,
    };

ServiceData _$ServiceDataFromJson(Map<String, dynamic> json) => ServiceData(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      duration: (json['duration'] as num?)?.toInt(),
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      imageCover: json['imageCover'] as String?,
      category: json['category'] == null
          ? null
          : CategoryData.fromJson(json['category'] as Map<String, dynamic>),
      available: json['available'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      version: (json['__v'] as num?)?.toInt(),
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
