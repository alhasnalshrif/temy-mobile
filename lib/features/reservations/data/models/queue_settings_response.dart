import 'package:json_annotation/json_annotation.dart';

part 'queue_settings_response.g.dart';

@JsonSerializable()
class QueueSettingsResponse {
  String? status;
  QueueSettingsData? data;

  QueueSettingsResponse({this.status, this.data});

  factory QueueSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$QueueSettingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QueueSettingsResponseToJson(this);
}

@JsonSerializable()
class QueueSettingsData {
  @JsonKey(name: 'is_queue_mode')
  bool? isQueueMode;
  @JsonKey(name: 'queue_settings')
  QueueSettings? queueSettings;

  QueueSettingsData({this.isQueueMode, this.queueSettings});

  factory QueueSettingsData.fromJson(Map<String, dynamic> json) =>
      _$QueueSettingsDataFromJson(json);

  Map<String, dynamic> toJson() => _$QueueSettingsDataToJson(this);
}

@JsonSerializable()
class QueueSettings {
  @JsonKey(name: 'max_queue_size')
  int? maxQueueSize;
  @JsonKey(name: 'estimated_service_time')
  int? estimatedServiceTime;
  @JsonKey(name: 'auto_advance_queue')
  bool? autoAdvanceQueue;

  QueueSettings({
    this.maxQueueSize,
    this.estimatedServiceTime,
    this.autoAdvanceQueue,
  });

  factory QueueSettings.fromJson(Map<String, dynamic> json) =>
      _$QueueSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$QueueSettingsToJson(this);
}
