// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_detail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationRequestModel _$ReservationRequestModelFromJson(
        Map<String, dynamic> json) =>
    ReservationRequestModel(
      user: json['user'] as String,
      service:
          (json['service'] as List<dynamic>).map((e) => e as String).toList(),
      barber: json['barber'] as String,
      date: json['date'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$ReservationRequestModelToJson(
        ReservationRequestModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'service': instance.service,
      'barber': instance.barber,
      'date': instance.date,
      'status': instance.status,
    };
