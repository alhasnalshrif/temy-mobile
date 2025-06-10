/// Configuration class for notification settings
/// This makes it easier to manage OneSignal configuration across the app
class NotificationConfig {
  /// OneSignal App ID - Replace this with your actual OneSignal App ID
  /// You can get this from your OneSignal dashboard at https://onesignal.com/
  static const String oneSignalAppId = "cf73d402-32e3-452e-8d58-bfe6e2129923";

  /// Whether to enable debug logging for notifications
  static const bool enableDebugLogging = true;

  /// Default notification settings
  static const Map<String, bool> defaultNotificationSettings = {
    'booking_confirmations': true,
    'booking_reminders': true,
    'booking_updates': true,
    'promotions': true,
    'new_services': false,
    'app_updates': false,
  };

  /// Notification categories for grouping
  static const Map<String, String> notificationCategories = {
    'booking': 'Booking Notifications',
    'promotion': 'Promotions & Offers',
    'service': 'Service Updates',
    'system': 'System Notifications',
  };

  /// Deep link routes mapping
  static const Map<String, String> deepLinkRoutes = {
    'booking_details': '/booking-details',
    'upcoming_bookings': '/bookings',
    'promotions': '/promotions',
    'services': '/services',
    'profile': '/profile',
  };
  /// Validate if OneSignal App ID is configured
  static bool get isConfigured =>
      oneSignalAppId.isNotEmpty && oneSignalAppId != "YOUR_ONESIGNAL_APP_ID";

  /// Get notification icon for different types
  static String getNotificationIcon(String type) {
    switch (type.toLowerCase()) {
      case 'booking':
        return 'assets/icons/booking.png';
      case 'promotion':
        return 'assets/icons/promotion.png';
      case 'service':
        return 'assets/icons/service.png';
      default:
        return 'assets/icons/notification.png';
    }
  }

  /// Get notification color for different types
  static String getNotificationColor(String type) {
    switch (type.toLowerCase()) {
      case 'booking':
        return '#4CAF50'; // Green
      case 'promotion':
        return '#FF9800'; // Orange
      case 'service':
        return '#2196F3'; // Blue
      default:
        return '#9E9E9E'; // Gray
    }
  }
}
