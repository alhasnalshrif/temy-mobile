import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:flutter/foundation.dart';
import '../routing/app_routes.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import '../config/notification_config.dart';
import '../utils/temy_sentry_utils.dart';

class NotificationService {
  static String get _oneSignalAppId => NotificationConfig.oneSignalAppId;

  static NotificationService? _instance;
  static NotificationService get instance =>
      _instance ??= NotificationService._();

  NotificationService._();

  /// Initialize OneSignal
  Future<void> initialize() async {
    try {
      // Check if OneSignal is configured
      if (!NotificationConfig.isConfigured) {
        log(
          '⚠️ OneSignal App ID not configured. Please update NotificationConfig.oneSignalAppId',
        );
        await TemySentryUtils.trackOneSignalInit(
          success: false,
          error: 'OneSignal App ID not configured',
        );
        return;
      }

      log(
        '🚀 Initializing OneSignal with App ID: ${_oneSignalAppId.substring(0, 8)}...',
      );

      // Initialize OneSignal with proper error handling
      try {
        OneSignal.initialize(_oneSignalAppId);
        log('✅ OneSignal.initialize() completed');
      } catch (e) {
        log('❌ OneSignal.initialize() failed: $e');
        throw Exception('OneSignal initialization failed: $e');
      }

      // Set the log level for debugging (remove in production)
      if (kDebugMode && NotificationConfig.enableDebugLogging) {
        try {
          OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
          log('🔧 OneSignal debug logging enabled');
        } catch (e) {
          log('⚠️ Failed to set OneSignal debug level: $e');
        }
      }

      // Setup notification handlers first
      _setupNotificationHandlers();
      log('📱 Notification handlers setup completed');

      // Add a delay to ensure OneSignal is fully initialized
      await Future.delayed(const Duration(milliseconds: 500));

      // Request notification permission with better error handling
      await requestNotificationPermission();

      log(
        '✅ OneSignal initialized successfully with App ID: ${_oneSignalAppId.substring(0, 8)}...',
      );

      // Track successful initialization
      await TemySentryUtils.trackOneSignalInit(
        success: true,
        appId: _oneSignalAppId,
        version: 'onesignal_flutter ^5.3.3',
      );
    } catch (e) {
      log('❌ Failed to initialize OneSignal: $e');

      // Track initialization failure
      await TemySentryUtils.trackOneSignalInit(
        success: false,
        error: e.toString(),
        appId: _oneSignalAppId,
      );

      // Don't rethrow - allow app to continue without notifications
      log('📱 App will continue without push notifications');
    }
  }

  /// Request notification permission with enhanced error handling
  Future<bool> requestNotificationPermission() async {
    try {
      log('📱 Requesting notification permission...');

      // Check if OneSignal is properly initialized before requesting permission
      await Future.delayed(const Duration(milliseconds: 100));

      final permission = await OneSignal.Notifications.requestPermission(true);
      log(
        'Notification permission granted: $permission',
      ); // Track permission result
      await TemySentryUtils.trackNotificationEvent(
        'permission_request_result',
        permissionStatus: permission ? 'granted' : 'denied',
      );

      if (!permission) {
        log('Notification permission denied by user');
        // Handle permission denied scenario
        await _handlePermissionDenied();
      } else {
        log('✅ Notification permission granted successfully');
      }

      return permission;
    } catch (e) {
      log('Failed to request notification permission: $e');

      // Track permission error
      await TemySentryUtils.trackNotificationEvent(
        'permission_request_error',
        error: e.toString(),
      );

      await _handlePermissionError(e.toString());
      return false;
    }
  }

  /// Handle permission denied scenario
  Future<void> _handlePermissionDenied() async {
    try {
      // You can show a dialog or navigate to app settings
      log(
        'User denied notification permission - consider showing explanation dialog',
      );
      // Optionally store this state to show explanation later
      // await SharedPreferences.getInstance().then((prefs) =>
      //   prefs.setBool('notification_permission_denied', true));
    } catch (e) {
      log('Error handling permission denied: $e');
    }
  }

  /// Handle permission request error
  Future<void> _handlePermissionError(String error) async {
    try {
      log('Notification permission error: $error');
      // Handle specific error scenarios
      if (error.contains('already requested')) {
        log('Permission already requested - checking current status');
        await areNotificationsEnabled();
      }
    } catch (e) {
      log('Error handling permission error: $e');
    }
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    try {
      final permission = OneSignal.Notifications.permission;
      return permission;
    } catch (e) {
      log('Failed to check notification permission: $e');
      return false;
    }
  }

  /// Set up notification handlers
  void _setupNotificationHandlers() {
    // Handle notification opened (when user taps on notification)
    OneSignal.Notifications.addClickListener((event) {
      log('Notification clicked: ${event.notification.notificationId}');
      _handleNotificationOpened(event);
    });

    // Handle notification received while app is in foreground
    OneSignal.Notifications.addForegroundWillDisplayListener((event) {
      log(
        'Notification received in foreground: ${event.notification.notificationId}',
      );
      // You can choose to display the notification or handle it silently
      event.preventDefault();
      event.notification.display();
    });
  }

  /// Handle notification opened
  void _handleNotificationOpened(OSNotificationClickEvent event) {
    final notification = event.notification;
    final additionalData = notification.additionalData;

    log('Notification opened with data: $additionalData');

    // Handle different notification types based on additional data
    if (additionalData != null) {
      final type = additionalData['type'];
      final bookingId = additionalData['booking_id'];

      switch (type) {
        case 'booking_confirmed':
          // Navigate to booking details
          _navigateToBookingDetails(bookingId);
          break;
        case 'booking_reminder':
          // Navigate to upcoming bookings
          _navigateToUpcomingBookings();
          break;
        case 'promotion':
          // Navigate to promotions or specific service
          _navigateToPromotions();
          break;
        default:
          // Default navigation (e.g., home screen)
          _navigateToHome();
      }
    }
  }

  /// Set user ID for OneSignal (call this after user login)
  Future<void> setUserId(String userId) async {
    try {
      await OneSignal.login(userId);
      log('OneSignal user ID set: $userId');
    } catch (e) {
      log('Failed to set OneSignal user ID: $e');
    }
  }

  /// Logout user from OneSignal (call this after user logout)
  Future<void> logoutUser() async {
    try {
      // Clear user-specific OneSignal data
      await OneSignal.logout();

      // Clear any user-specific tags
      await removeTags(['user_id', 'user_type', 'language']);

      // Disable notifications temporarily during logout
      await setNotificationEnabled(false);

      log('✅ OneSignal user logged out successfully');
    } catch (e) {
      log('❌ Failed to logout OneSignal user: $e');
      // Continue with logout even if OneSignal fails
    }
  }

  /// Get OneSignal player ID
  Future<String?> getPlayerId() async {
    try {
      final user = OneSignal.User.pushSubscription;
      return user.id;
    } catch (e) {
      log('Failed to get OneSignal player ID: $e');
      return null;
    }
  }

  /// Get OneSignal push token
  Future<String?> getPushToken() async {
    try {
      final user = OneSignal.User.pushSubscription;
      return user.token;
    } catch (e) {
      log('Failed to get OneSignal push token: $e');
      return null;
    }
  }

  /// Set notification enabled/disabled
  Future<void> setNotificationEnabled(bool enabled) async {
    try {
      await OneSignal.User.pushSubscription.optIn();
      if (!enabled) {
        await OneSignal.User.pushSubscription.optOut();
      }
      log('Notification enabled: $enabled');
    } catch (e) {
      log('Failed to set notification enabled: $e');
    }
  }

  /// Add tags to user (useful for targeting)
  Future<void> addTags(Map<String, String> tags) async {
    try {
      await OneSignal.User.addTags(tags);
      log('Tags added: $tags');
    } catch (e) {
      log('Failed to add tags: $e');
    }
  }

  /// Remove tags from user
  Future<void> removeTags(List<String> tagKeys) async {
    try {
      await OneSignal.User.removeTags(tagKeys);
      log('Tags removed: $tagKeys');
    } catch (e) {
      log('Failed to remove tags: $e');
    }
  }

  /// Send test notification (for development/testing)
  Future<void> sendTestNotification() async {
    if (kDebugMode) {
      try {
        // This would typically be done from your backend
        // This is just for testing purposes
        log('Test notification feature - implement backend call');
      } catch (e) {
        log('Failed to send test notification: $e');
      }
    }
  }

  /// Clear all notification data (useful for logout)
  Future<void> clearAllNotificationData() async {
    try {
      await logoutUser();
      log('All notification data cleared');
    } catch (e) {
      log('Failed to clear notification data: $e');
    }
  }

  /// Check if this is the first time requesting permission
  Future<bool> isFirstTimePermissionRequest() async {
    try {
      // You can implement this with SharedPreferences
      // For now, return true
      return true;
    } catch (e) {
      log('Error checking first time permission: $e');
      return true;
    }
  }

  /// Test OneSignal functionality (for debugging)
  Future<Map<String, dynamic>> testOneSignalStatus() async {
    final status = <String, dynamic>{
      'isConfigured': NotificationConfig.isConfigured,
      'appId': '${NotificationConfig.oneSignalAppId.substring(0, 8)}...',
      'timestamp': DateTime.now().toIso8601String(),
    };

    try {
      // Test basic OneSignal functionality
      final hasPermission = await areNotificationsEnabled();
      status['hasPermission'] = hasPermission;

      // Try to get device info
      try {
        final playerId = await getPlayerId();
        final pushToken = await getPushToken();

        status['playerId'] = playerId != null ? 'Available' : 'Not available';
        status['pushToken'] = pushToken != null ? 'Available' : 'Not available';
      } catch (e) {
        status['deviceInfoError'] = e.toString();
      }

      status['status'] = 'working';
    } catch (e) {
      status['status'] = 'error';
      status['error'] = e.toString();

      // Report to Sentry
      await TemySentryUtils.trackNotificationEvent(
        'onesignal_status_test_failed',
        error: e.toString(),
        additionalData: status,
      );
    }

    return status;
  }

  // Navigation methods - Deep linking for notification actions
  void _navigateToBookingDetails(String? bookingId) {
    log('Navigate to booking details: $bookingId');
    try {
      if (_navigatorKey?.currentContext != null) {
        // Navigate to booking tab in dashboard with specific booking
        _navigatorKey!.currentContext!.goNamed(
          AppRoutes.dashboardName,
          extra: 1, // Index 1 is the booking tab
        );
      }
    } catch (e) {
      log('Error navigating to booking details: $e');
      _navigateToHome(); // Fallback to home
    }
  }

  void _navigateToUpcomingBookings() {
    log('Navigate to upcoming bookings');
    try {
      if (_navigatorKey?.currentContext != null) {
        // Navigate to booking tab in dashboard
        _navigatorKey!.currentContext!.goNamed(
          AppRoutes.dashboardName,
          extra: 1, // Index 1 is the booking tab
        );
      }
    } catch (e) {
      log('Error navigating to upcoming bookings: $e');
      _navigateToHome(); // Fallback to home
    }
  }

  void _navigateToPromotions() {
    log('Navigate to promotions');
    try {
      if (_navigatorKey?.currentContext != null) {
        // Navigate to categories screen (promotions/services)
        _navigatorKey!.currentContext!.go(AppRoutes.Categories);
      }
    } catch (e) {
      log('Error navigating to promotions: $e');
      _navigateToHome(); // Fallback to home
    }
  }

  void _navigateToHome() {
    log('Navigate to home screen');
    try {
      if (_navigatorKey?.currentContext != null) {
        // Navigate to dashboard (home tab)
        _navigatorKey!.currentContext!.go(AppRoutes.Dashboard);
      }
    } catch (e) {
      log('Error navigating to home: $e');
    }
  }

  // Set navigator key for global navigation access
  static GlobalKey<NavigatorState>? _navigatorKey;

  /// Set the navigator key for global navigation access
  static void setNavigatorKey(GlobalKey<NavigatorState> key) {
    _navigatorKey = key;
  }
}
