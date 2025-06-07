part of 'notification_cubit.dart';

@freezed
class NotificationState with _$NotificationState {
  const factory NotificationState.initial() = _Initial;

  const factory NotificationState.loading() = _Loading;

  const factory NotificationState.settingsLoaded(
      NotificationSettingsResponse settings) = _SettingsLoaded;

  const factory NotificationState.settingsUpdated(
      NotificationResponse response) = _SettingsUpdated;

  const factory NotificationState.historyLoaded(
      NotificationHistoryResponse history) = _HistoryLoaded;

  const factory NotificationState.permissionGranted() = _PermissionGranted;

  const factory NotificationState.permissionDenied() = _PermissionDenied;

  const factory NotificationState.error(String message) = _Error;
}
