import 'package:json_annotation/json_annotation.dart';

part 'service_response.g.dart';

@JsonSerializable()
class ServiceResponseModel {
  final String? status;
  final int? results;

  @JsonKey(name: 'paginationResult')
  final PaginationResult? paginationResult;

  @JsonKey(name: 'data')
  final List<ServiceData>? serviceDataList;

  ServiceResponseModel({
    this.status,
    this.results,
    this.paginationResult,
    this.serviceDataList,
  });

  factory ServiceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceResponseModelFromJson(json);
}

@JsonSerializable()
class PaginationResult {
  @JsonKey(name: 'currentPage')
  final int? currentPage;

  final int? limit;

  @JsonKey(name: 'numberOfPages')
  final int? numberOfPages;

  PaginationResult({
    this.currentPage,
    this.limit,
    this.numberOfPages,
  });

  factory PaginationResult.fromJson(Map<String, dynamic> json) =>
      _$PaginationResultFromJson(json);
}

@JsonSerializable()
class ServiceData {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final double? price;
  final int? duration;
  final List<String>? images;
  final String? imageCover;
  final CategoryData? category;
  final bool? available;
  final String? createdAt;
  final String? updatedAt;

  @JsonKey(name: '__v')
  final int? version;

  ServiceData({
    this.id,
    this.name,
    this.price,
    this.duration,
    this.images,
    this.imageCover,
    this.category,
    this.available,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) =>
      _$ServiceDataFromJson(json);
}

@JsonSerializable()
class CategoryData {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? description;
  final String? imageCover;

  @JsonKey(name: '__v')
  final int? version;

  CategoryData({
    this.id,
    this.name,
    this.description,
    this.imageCover,
    this.version,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDataFromJson(json);
}
