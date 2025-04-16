import 'package:json_annotation/json_annotation.dart';

part 'banner_response.g.dart';

@JsonSerializable()
class BannerResponseModel {
  final String? status;
  final int? results;

  @JsonKey(name: 'paginationResult')
  final PaginationResult? paginationResult;

  @JsonKey(name: 'data')
  final List<BannerData>? bannerDataList;

  BannerResponseModel({
    this.status,
    this.results,
    this.paginationResult,
    this.bannerDataList,
  });

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseModelFromJson(json);
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
class BannerData {
  @JsonKey(name: 'image')
  final String? image;

  BannerData({
    this.image,
  });

  factory BannerData.fromJson(Map<String, dynamic> json) =>
      _$BannerDataFromJson(json);
}
