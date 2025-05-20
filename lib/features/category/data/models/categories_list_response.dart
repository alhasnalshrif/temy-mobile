import 'package:json_annotation/json_annotation.dart';

part 'categories_list_response.g.dart';

@JsonSerializable()
class CategoriesListResponseModel {
  final String? status;
  final int? results;

  @JsonKey(name: 'paginationResult')
  final PaginationResult? paginationResult;

  @JsonKey(name: 'data')
  final List<CategoryItem>? data;

  CategoriesListResponseModel({
    this.status,
    this.results,
    this.paginationResult,
    this.data,
  });

  factory CategoriesListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoriesListResponseModelFromJson(json);
}

@JsonSerializable()
class PaginationResult {
  @JsonKey(name: 'currentPage')
  final int? currentPage;

  @JsonKey(name: 'limit')
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
class CategoryItem {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? description;
  final String? imageCover;

  @JsonKey(name: '__v')
  final int? version;

  CategoryItem({
    this.id,
    this.name,
    this.description,
    this.imageCover,
    this.version,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) =>
      _$CategoryItemFromJson(json);
}
