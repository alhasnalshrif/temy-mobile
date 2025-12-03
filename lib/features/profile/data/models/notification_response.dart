import 'package:json_annotation/json_annotation.dart';

part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  String? status;
  String? message;

  NotificationResponse({this.status, this.message});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}

@JsonSerializable()
class NotificationSettingsResponse {
  @JsonKey(name: 'push_notifications')
  bool? pushNotifications;
  @JsonKey(name: 'booking_reminders')
  bool? bookingReminders;
  @JsonKey(name: 'promotional_notifications')
  bool? promotionalNotifications;

  NotificationSettingsResponse({
    this.pushNotifications,
    this.bookingReminders,
    this.promotionalNotifications,
  });

  factory NotificationSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSettingsResponseToJson(this);
}

@JsonSerializable()
class NotificationHistoryItem {
  int? id;
  String? title;
  String? body;
  String? type;
  Map<String, dynamic>? data;
  @JsonKey(name: 'read_at')
  String? readAt;
  @JsonKey(name: 'created_at')
  String? createdAt;

  NotificationHistoryItem({
    this.id,
    this.title,
    this.body,
    this.type,
    this.data,
    this.readAt,
    this.createdAt,
  });

  factory NotificationHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationHistoryItemFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationHistoryItemToJson(this);
}

@JsonSerializable()
class NotificationHistoryResponse {
  List<NotificationHistoryItem>? notifications;

  NotificationHistoryResponse({this.notifications});

  factory NotificationHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationHistoryResponseToJson(this);
}
