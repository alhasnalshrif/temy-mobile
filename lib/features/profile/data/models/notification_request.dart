import 'package:json_annotation/json_annotation.dart';

part 'notification_request.g.dart';

@JsonSerializable()
class NotificationTokenRequest {
  @JsonKey(name: 'device_token')
  String? deviceToken;
  @JsonKey(name: 'player_id')
  String? playerId;
  @JsonKey(name: 'platform')
  String? platform; // 'android' or 'ios'

  NotificationTokenRequest({this.deviceToken, this.playerId, this.platform});

  factory NotificationTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationTokenRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationTokenRequestToJson(this);
}

@JsonSerializable()
class NotificationSettingsRequest {
  @JsonKey(name: 'push_notifications')
  bool? pushNotifications;
  @JsonKey(name: 'booking_reminders')
  bool? bookingReminders;
  @JsonKey(name: 'promotional_notifications')
  bool? promotionalNotifications;

  NotificationSettingsRequest({
    this.pushNotifications,
    this.bookingReminders,
    this.promotionalNotifications,
  });

  factory NotificationSettingsRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationSettingsRequestToJson(this);
}
