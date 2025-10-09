import 'package:freezed_annotation/freezed_annotation.dart';

part 'queue_settings_response.freezed.dart';
part 'queue_settings_response.g.dart';

@freezed
class QueueSettingsResponse with _$QueueSettingsResponse {
  const factory QueueSettingsResponse({
    required String status,
    required QueueSettingsData data,
  }) = _QueueSettingsResponse;

  factory QueueSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$QueueSettingsResponseFromJson(json);
}

@freezed
class QueueSettingsData with _$QueueSettingsData {
  const factory QueueSettingsData({
    @JsonKey(name: 'is_queue_mode') required bool isQueueMode,
    @JsonKey(name: 'queue_settings') required QueueSettings queueSettings,
  }) = _QueueSettingsData;

  factory QueueSettingsData.fromJson(Map<String, dynamic> json) =>
      _$QueueSettingsDataFromJson(json);
}

@freezed
class QueueSettings with _$QueueSettings {
  const factory QueueSettings({
    @JsonKey(name: 'max_queue_size') required int maxQueueSize,
    @JsonKey(name: 'estimated_service_time') required int estimatedServiceTime,
    @JsonKey(name: 'auto_advance_queue') required bool autoAdvanceQueue,
  }) = _QueueSettings;

  factory QueueSettings.fromJson(Map<String, dynamic> json) =>
      _$QueueSettingsFromJson(json);
}
