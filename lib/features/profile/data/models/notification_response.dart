import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_response.freezed.dart';
part 'notification_response.g.dart';

@freezed
class NotificationResponse with _$NotificationResponse {
  const factory NotificationResponse({
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'message') required String message,
  }) = _NotificationResponse;

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);
}

@freezed
class NotificationSettingsResponse with _$NotificationSettingsResponse {
  const factory NotificationSettingsResponse({
    @JsonKey(name: 'push_notifications') required bool pushNotifications,
    @JsonKey(name: 'booking_reminders') required bool bookingReminders,
    @JsonKey(name: 'promotional_notifications')
    required bool promotionalNotifications,
  }) = _NotificationSettingsResponse;

  factory NotificationSettingsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsResponseFromJson(json);
}

@freezed
class NotificationHistoryItem with _$NotificationHistoryItem {
  const factory NotificationHistoryItem({
    @JsonKey(name: 'id') required int id,
    @JsonKey(name: 'title') required String title,
    @JsonKey(name: 'body') required String body,
    @JsonKey(name: 'type') required String type,
    @JsonKey(name: 'data') Map<String, dynamic>? data,
    @JsonKey(name: 'read_at') String? readAt,
    @JsonKey(name: 'created_at') required String createdAt,
  }) = _NotificationHistoryItem;

  factory NotificationHistoryItem.fromJson(Map<String, dynamic> json) =>
      _$NotificationHistoryItemFromJson(json);
}

@freezed
class NotificationHistoryResponse with _$NotificationHistoryResponse {
  const factory NotificationHistoryResponse({
    @JsonKey(name: 'notifications')
    required List<NotificationHistoryItem> notifications,
  }) = _NotificationHistoryResponse;

  factory NotificationHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationHistoryResponseFromJson(json);
}
