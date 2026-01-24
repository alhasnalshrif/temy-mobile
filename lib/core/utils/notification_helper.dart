import 'dart:developer';
import '../config/notification_config.dart';

/// Helper class for notification setup and testing
class NotificationHelper {
  /// Check if OneSignal is properly configured
  static bool checkConfiguration() {
    if (!NotificationConfig.isConfigured) {
      log('🔧 OneSignal Configuration Required:');
      log('1. Go to https://onesignal.com/ and create an app');
      log('2. Copy your App ID');
      log('3. Update NotificationConfig.oneSignalAppId in:');
      log('   lib/core/config/notification_config.dart');
      log('4. Also update onesignalAppId in:');
      log('   android/app/build.gradle');
      return false;
    }
    log('✅ OneSignal configuration looks good!');
    return true;
  }

  /// Get current configuration status
  static Map<String, dynamic> getConfigurationStatus() {
    return {
      'isConfigured': NotificationConfig.isConfigured,
      'appId': NotificationConfig.isConfigured
          ? '${NotificationConfig.oneSignalAppId.substring(0, 8)}...'
          : 'Not configured',
      'debugLogging': NotificationConfig.enableDebugLogging,
      'defaultSettings': NotificationConfig.defaultNotificationSettings,
    };
  }
}
