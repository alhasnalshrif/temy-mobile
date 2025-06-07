class HomeApiConstants {
  static const String profile = 'users/profile';
  static const String profileUpdate = 'users/profile/update';

  // Notification endpoints
  static const String updateDeviceToken = 'users/device-token';
  static const String notificationSettings = 'users/notification-settings';
  static const String notificationHistory = 'users/notifications';
  static const String markNotificationRead = 'users/notifications/{id}/read';
}
