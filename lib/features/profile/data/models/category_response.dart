// import 'package:json_annotation/json_annotation.dart';

// part 'category_response.g.dart';

// @JsonSerializable()
// class CategoryResponseModel {
//   final String? status;
//   final int? results;

//   @JsonKey(name: 'paginationResult')
//   final PaginationResult? paginationResult;

//   @JsonKey(name: 'data')
//   final List<CategoryData>? categoryDataList;

//   CategoryResponseModel({
//     this.status,
//     this.results,
//     this.paginationResult,
//     this.categoryDataList,
//   });

//   factory CategoryResponseModel.fromJson(Map<String, dynamic> json) =>
//       _$CategoryResponseModelFromJson(json);
// }

// @JsonSerializable()
// class PaginationResult {
//   @JsonKey(name: 'currentPage')
//   final int? currentPage;

//   final int? limit;

//   @JsonKey(name: 'numberOfPages')
//   final int? numberOfPages;

//   PaginationResult({
//     this.currentPage,
//     this.limit,
//     this.numberOfPages,
//   });

//   factory PaginationResult.fromJson(Map<String, dynamic> json) =>
//       _$PaginationResultFromJson(json);
// }

// @JsonSerializable()
// class CategoryData {
//   @JsonKey(name: '_id')
//   final String? id;

//   final String? name;
//   final String? description;
//   final String? imageCover;

//   @JsonKey(name: '__v')
//   final int? version;

//   CategoryData({
//     this.id,
//     this.name,
//     this.description,
//     this.imageCover,
//     this.version,
//   });

//   factory CategoryData.fromJson(Map<String, dynamic> json) =>
//       _$CategoryDataFromJson(json);
// }
