// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slots_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotsResponse _$TimeSlotsResponseFromJson(Map<String, dynamic> json) =>
    TimeSlotsResponse(
      status: json['status'] as String,
      data: TimeSlotsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TimeSlotsResponseToJson(TimeSlotsResponse instance) =>
    <String, dynamic>{'status': instance.status, 'data': instance.data};

TimeSlotsData _$TimeSlotsDataFromJson(Map<String, dynamic> json) =>
    TimeSlotsData(
      slots: (json['slots'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
      isDayOff: json['isDayOff'] as bool,
      // workingHours: WorkingHours.fromJson(
      //   json['workingHours'] as Map<String, dynamic>,
      // ),
    );

Map<String, dynamic> _$TimeSlotsDataToJson(TimeSlotsData instance) =>
    <String, dynamic>{
      'slots': instance.slots,
      'isDayOff': instance.isDayOff,
      // 'workingHours': instance.workingHours,
    };

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
  time: json['time'] as String,
  isAvailable: json['isAvailable'] as bool,
);

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
  'time': instance.time,
  'isAvailable': instance.isAvailable,
};

WorkingHours _$WorkingHoursFromJson(Map<String, dynamic> json) =>
    WorkingHours(start: json['start'] as String, end: json['end'] as String);

Map<String, dynamic> _$WorkingHoursToJson(WorkingHours instance) =>
    <String, dynamic>{'start': instance.start, 'end': instance.end};
