// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResponseModel _$BannerResponseModelFromJson(Map<String, dynamic> json) =>
    BannerResponseModel(
      status: json['status'] as String?,
      results: (json['results'] as num?)?.toInt(),
      paginationResult: json['paginationResult'] == null
          ? null
          : PaginationResult.fromJson(
              json['paginationResult'] as Map<String, dynamic>,
            ),
      bannerDataList: (json['data'] as List<dynamic>?)
          ?.map((e) => BannerData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BannerResponseModelToJson(
  BannerResponseModel instance,
) => <String, dynamic>{
  'status': instance.status,
  'results': instance.results,
  'paginationResult': instance.paginationResult,
  'data': instance.bannerDataList,
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

BannerData _$BannerDataFromJson(Map<String, dynamic> json) =>
    BannerData(image: json['image'] as String?);

Map<String, dynamic> _$BannerDataToJson(BannerData instance) =>
    <String, dynamic>{'image': instance.image};
