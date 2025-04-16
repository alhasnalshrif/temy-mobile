// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_detail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationRequestModel _$ReservationRequestModelFromJson(
        Map<String, dynamic> json) =>
    ReservationRequestModel(
      user: json['user'] as String,
      serviceIds: (json['serviceIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      barberId: json['barberId'] as String,
      date: DateTime.parse(json['date'] as String),
      startTime: json['startTime'] as String,
    );

Map<String, dynamic> _$ReservationRequestModelToJson(
        ReservationRequestModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'serviceIds': instance.serviceIds,
      'barberId': instance.barberId,
      'date': instance.date.toIso8601String(),
      'startTime': instance.startTime,
    };
