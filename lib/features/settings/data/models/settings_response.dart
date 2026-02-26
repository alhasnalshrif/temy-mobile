import 'package:json_annotation/json_annotation.dart';

part 'settings_response.g.dart';

@JsonSerializable()
class SettingsResponse {
  String? status;
  SettingsData? data;

  SettingsResponse({this.status, this.data});

  factory SettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$SettingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsResponseToJson(this);
}

@JsonSerializable()
class SettingsData {
  @JsonKey(name: 'is_queue_mode')
  bool? isQueueMode;
  @JsonKey(name: 'maintenance')
  bool? maintenance;
  @JsonKey(name: 'maintenance_message')
  String? maintenanceMessage;
  @JsonKey(name: 'logo')
  String? logo;
  @JsonKey(name: 'about')
  String? about;
  @JsonKey(name: 'phone')
  String? phone;
  @JsonKey(name: 'address')
  String? address;

  // We can include queue_settings here if needed, but for maintenance the above are sufficient.
  // Based on user JSON, queue_settings is present.
  @JsonKey(name: 'queue_settings')
  GlobalQueueSettings? queueSettings;

  @JsonKey(name: 'app_version')
  String? appVersion;
  @JsonKey(name: 'force_update')
  bool? forceUpdate;
  @JsonKey(name: 'android_url')
  String? androidUrl;
  @JsonKey(name: 'iphone_url')
  String? iphoneUrl;

  SettingsData({
    this.isQueueMode,
    this.maintenance,
    this.maintenanceMessage,
    this.logo,
    this.about,
    this.phone,
    this.address,
    this.queueSettings,
    this.appVersion,
    this.forceUpdate,
    this.androidUrl,
    this.iphoneUrl,
  });

  factory SettingsData.fromJson(Map<String, dynamic> json) =>
      _$SettingsDataFromJson(json);

  Map<String, dynamic> toJson() => _$SettingsDataToJson(this);
}

@JsonSerializable()
class GlobalQueueSettings {
  @JsonKey(name: 'max_queue_size')
  int? maxQueueSize;
  @JsonKey(name: 'estimated_service_time')
  int? estimatedServiceTime;
  @JsonKey(name: 'auto_advance_queue')
  bool? autoAdvanceQueue;

  GlobalQueueSettings({
    this.maxQueueSize,
    this.estimatedServiceTime,
    this.autoAdvanceQueue,
  });

  factory GlobalQueueSettings.fromJson(Map<String, dynamic> json) =>
      _$GlobalQueueSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$GlobalQueueSettingsToJson(this);
}
