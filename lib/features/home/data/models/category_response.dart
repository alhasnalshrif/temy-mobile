import 'package:json_annotation/json_annotation.dart';
import 'package:temy_barber/features/category/data/models/service_response.dart'
    show CategoryData;

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponseModel {
  final String? status;
  final int? results;

  @JsonKey(name: 'paginationResult')
  final PaginationResult? paginationResult;

  @JsonKey(name: 'data')
  final List<CategoryData> categoryDataList;

  CategoryResponseModel({
    this.status,
    this.results,
    this.paginationResult,
    required this.categoryDataList,
  });

  factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryResponseModelToJson(this);
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

  Map<String, dynamic> toJson() => _$PaginationResultToJson(this);
}
