import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_request.freezed.dart';
part 'notification_request.g.dart';

@freezed
class NotificationTokenRequest with _$NotificationTokenRequest {
  const factory NotificationTokenRequest({
    @JsonKey(name: 'device_token') required String deviceToken,
    @JsonKey(name: 'player_id') String? playerId,
    @JsonKey(name: 'platform') required String platform, // 'android' or 'ios'
  }) = _NotificationTokenRequest;

  factory NotificationTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationTokenRequestFromJson(json);
}

@freezed
class NotificationSettingsRequest with _$NotificationSettingsRequest {
  const factory NotificationSettingsRequest({
    @JsonKey(name: 'push_notifications') required bool pushNotifications,
    @JsonKey(name: 'booking_reminders') bool? bookingReminders,
    @JsonKey(name: 'promotional_notifications') bool? promotionalNotifications,
  }) = _NotificationSettingsRequest;

  factory NotificationSettingsRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsRequestFromJson(json);
}
