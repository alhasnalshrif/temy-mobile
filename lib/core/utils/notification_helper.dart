import 'dart:developer';
import '../config/notification_config.dart';
import '../services/notification_service.dart';

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

  /// Test notification functionality (for development only)
  static Future<void> testNotifications() async {
    try {
      final service = NotificationService.instance;

      // Check permissions
      final hasPermission = await service.areNotificationsEnabled();
      log('📱 Notification permission: ${hasPermission ? "✅ Granted" : "❌ Denied"}');

      // Get device info
      final playerId = await service.getPlayerId();
      final pushToken = await service.getPushToken();

      log('🔍 Device Info:');
      log('   Player ID: ${playerId ?? "Not available"}');
      log('   Push Token: ${pushToken != null ? "${pushToken.substring(0, 20)}..." : "Not available"}');

      // Send test notification (if configured)
      if (NotificationConfig.isConfigured) {
        await service.sendTestNotification();
        log('📨 Test notification sent!');
      }
    } catch (e) {
      log('❌ Test failed: $e');
    }
  }

  /// Print setup instructions
  static void printSetupInstructions() {
    log('\n📋 OneSignal Setup Instructions:');
    log('================================');
    log('1. Create OneSignal Account:');
    log('   - Go to https://onesignal.com/');
    log('   - Sign up/Sign in');
    log('   - Create new app');
    log('');
    log('2. Get Your App ID:');
    log('   - Copy the App ID from OneSignal dashboard');
    log('   - It looks like: 12345678-1234-1234-1234-123456789012');
    log('');
    log('3. Update Configuration:');
    log('   - File 1: lib/core/config/notification_config.dart');
    log('     Replace: "YOUR_ONESIGNAL_APP_ID"');
    log('     With: "your-actual-app-id"');
    log('');
    log('   - File 2: android/app/build.gradle');
    log('     Replace: "YOUR_ONESIGNAL_APP_ID"');
    log('     With: "your-actual-app-id"');
    log('');
    log('4. Test Configuration:');
    log('   - Call NotificationHelper.testNotifications()');
    log('   - Check logs for success messages');
    log('================================\n');
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
