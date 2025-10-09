// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_detail_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReservationRequestModel _$ReservationRequestModelFromJson(
        Map<String, dynamic> json) =>
    ReservationRequestModel(
      user: json['user'] as String?,
      serviceIds: (json['serviceIds'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      barberId: json['barberId'] as String,
      date: json['date'] as String,
      startTime: json['startTime'] as String,
      guest: json['guest'] == null
          ? null
          : GuestInfo.fromJson(json['guest'] as Map<String, dynamic>),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$ReservationRequestModelToJson(
        ReservationRequestModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'serviceIds': instance.serviceIds,
      'barberId': instance.barberId,
      'date': instance.date,
      'startTime': instance.startTime,
      if (instance.guest case final value?) 'guest': value,
      if (instance.note case final value?) 'note': value,
    };

MultipleReservationsRequestModel _$MultipleReservationsRequestModelFromJson(
        Map<String, dynamic> json) =>
    MultipleReservationsRequestModel(
      reservations: (json['reservations'] as List<dynamic>)
          .map((e) =>
              ReservationRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MultipleReservationsRequestModelToJson(
        MultipleReservationsRequestModel instance) =>
    <String, dynamic>{
      'reservations': instance.reservations,
    };
