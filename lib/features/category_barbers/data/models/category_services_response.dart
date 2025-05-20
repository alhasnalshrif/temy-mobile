import 'package:json_annotation/json_annotation.dart';
import 'package:temy_barber/features/category_barbers/data/models/category_response.dart';

part 'category_services_response.g.dart';

@JsonSerializable()
class CategoryServicesResponse {
  final String? status;

  @JsonKey(name: 'data')
  final CategoryServicesData? data;

  CategoryServicesResponse({
    this.status,
    this.data,
  });

  factory CategoryServicesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryServicesResponseFromJson(json);
}

@JsonSerializable()
class CategoryServicesData {
  final CategoryData? category;
  final List<BarberData>? barbers;

  CategoryServicesData({
    this.category,
    this.barbers,
  });

  factory CategoryServicesData.fromJson(Map<String, dynamic> json) =>
      _$CategoryServicesDataFromJson(json);
}

@JsonSerializable()
class BarberData {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? phone;
  final List<BarberService>? services;

  BarberData({
    this.id,
    this.name,
    this.phone,
    this.services,
  });

  factory BarberData.fromJson(Map<String, dynamic> json) =>
      _$BarberDataFromJson(json);
}

@JsonSerializable()
class BarberService {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? description;
  final double? price;
  final int? duration;
  final String? imageCover;
  final bool? available;

  BarberService({
    this.id,
    this.name,
    this.description,
    this.price,
    this.duration,
    this.imageCover,
    this.available,
  });

  factory BarberService.fromJson(Map<String, dynamic> json) =>
      _$BarberServiceFromJson(json);
}
