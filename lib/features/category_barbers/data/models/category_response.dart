import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryServicesResponseModel {
  final String? status;

  @JsonKey(name: 'data')
  final CategoryDetailData? data;

  CategoryServicesResponseModel({
    this.status,
    this.data,
  });

  factory CategoryServicesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryServicesResponseModelFromJson(json);
}

@JsonSerializable()
class CategoryDetailData {
  @JsonKey(name: 'category')
  final CategoryData? category;

  @JsonKey(name: 'barbers')
  final List<BarberData>? barbers;

  CategoryDetailData({
    this.category,
    this.barbers,
  });

  factory CategoryDetailData.fromJson(Map<String, dynamic> json) =>
      _$CategoryDetailDataFromJson(json);
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

@JsonSerializable()
class BarberData {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? avatar;
  final String? phone;

  @JsonKey(name: 'services')
  final List<ServiceData>? services;

  BarberData({
    this.id,
    this.name,
    this.avatar,
    this.phone,
    this.services,
  });

  factory BarberData.fromJson(Map<String, dynamic> json) =>
      _$BarberDataFromJson(json);
}

@JsonSerializable()
class ServiceData {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? description;
  final int? price;
  final int? duration;
  final String? imageCover;
  final bool? available;

  ServiceData({
    this.id,
    this.name,
    this.description,
    this.price,
    this.duration,
    this.imageCover,
    this.available,
  });

  factory ServiceData.fromJson(Map<String, dynamic> json) =>
      _$ServiceDataFromJson(json);
}
