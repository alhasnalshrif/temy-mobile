import 'package:json_annotation/json_annotation.dart';

part 'time_slots_response.g.dart';

// New top-level class to match the overall JSON structure
@JsonSerializable()
class TimeSlotsResponse {
  final String status;
  final TimeSlotsData data;

  TimeSlotsResponse({
    required this.status,
    required this.data,
  });

  factory TimeSlotsResponse.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotsResponseToJson(this);
}

// Renamed original TimeSlotsResponse to TimeSlotsData
@JsonSerializable()
class TimeSlotsData {
  final List<TimeSlot> slots;
  final bool isDayOff;
  final WorkingHours workingHours;

  TimeSlotsData({
    required this.slots,
    required this.isDayOff,
    required this.workingHours,
  });

  // The generated factory name will change due to class rename
  factory TimeSlotsData.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotsDataFromJson(json);

  // The generated method name will change due to class rename
  Map<String, dynamic> toJson() => _$TimeSlotsDataToJson(this);
}

@JsonSerializable()
class TimeSlot {
  final String time;
  final bool isAvailable;

  TimeSlot({
    required this.time,
    required this.isAvailable,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) =>
      _$TimeSlotFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotToJson(this);
}

@JsonSerializable()
class WorkingHours {
  final String start;
  final String end;

  WorkingHours({
    required this.start,
    required this.end,
  });

  factory WorkingHours.fromJson(Map<String, dynamic> json) =>
      _$WorkingHoursFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingHoursToJson(this);
}
