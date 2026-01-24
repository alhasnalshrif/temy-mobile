import 'dart:developer';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/services/notification_service.dart';

class PermissionManager {
  PermissionManager._();
  static final PermissionManager _instance = PermissionManager._();
  static PermissionManager get instance => _instance;

  final NotificationService _notificationService = NotificationService.instance;

  // Permission status cache
  bool? _notificationPermissionCache;
  DateTime? _lastPermissionCheck;
  static const Duration _cacheValidDuration = Duration(minutes: 5);

  /// Initialize permission manager
  Future<void> initialize() async {
    try {
      await _loadCachedPermissions();
      log('✅ Permission Manager initialized');
    } catch (e) {
      log('❌ Permission Manager initialization failed: $e');
    }
  }

  /// Request notification permission with enhanced flow
  Future<bool> requestNotificationPermission() async {
    try {
      log('🔔 Requesting notification permission...');

      // Check if we've already requested this permission
      final hasRequestedBefore = await _hasRequestedPermissionBefore();

      if (hasRequestedBefore) {
        // If requested before and denied, guide user to settings
        final currentStatus = await getNotificationPermissionStatus();
        if (!currentStatus) {
          log('⚠️ Notification permission was previously denied');
          await _handlePermissionGuidance();
          return currentStatus;
        }
      }

      // Request the permission
      final granted = await _notificationService
          .requestNotificationPermission();

      // Cache the result
      _notificationPermissionCache = granted;
      _lastPermissionCheck = DateTime.now();
      await _cachePermissionRequest();

      log('📱 Notification permission result: $granted');

      if (!granted) {
        await _handlePermissionGuidance();
      }

      return granted;
    } catch (e) {
      log('❌ Error requesting notification permission: $e');
      return false;
    }
  }

  /// Check current notification permission status
  Future<bool> getNotificationPermissionStatus() async {
    try {
      // Check cache first if it's still valid
      if (_notificationPermissionCache != null &&
          _lastPermissionCheck != null &&
          DateTime.now().difference(_lastPermissionCheck!) <
              _cacheValidDuration) {
        return _notificationPermissionCache!;
      }

      final status = await _notificationService.areNotificationsEnabled();

      // Update cache
      _notificationPermissionCache = status;
      _lastPermissionCheck = DateTime.now();

      return status;
    } catch (e) {
      log('❌ Error getting notification permission status: $e');
      return false;
    }
  }

  /// Check if permission was requested before
  Future<bool> _hasRequestedPermissionBefore() async {
    try {
      const key = 'notification_permission_requested';
      return await SharedPrefHelper.getBool(key);
    } catch (e) {
      log('Error checking permission request history: $e');
      return false;
    }
  }

  /// Cache that we've requested notification permission
  Future<void> _cachePermissionRequest() async {
    try {
      const key = 'notification_permission_requested';
      await SharedPrefHelper.setData(key, true);

      // Also cache the timestamp
      const timestampKey = 'notification_permission_requested_time';
      await SharedPrefHelper.setData(
        timestampKey,
        DateTime.now().millisecondsSinceEpoch,
      );
    } catch (e) {
      log('Error caching permission request: $e');
    }
  }

  /// Load cached permissions
  Future<void> _loadCachedPermissions() async {
    try {
      // Load current notification permission status
      _notificationPermissionCache = await _notificationService
          .areNotificationsEnabled();
      _lastPermissionCheck = DateTime.now();
    } catch (e) {
      log('Error loading cached permissions: $e');
    }
  }

  /// Clear all permission caches (for logout/reset)
  Future<void> clearPermissionCache() async {
    try {
      log('🗑️ Clearing permission cache...');
      _notificationPermissionCache = null;
      _lastPermissionCheck = null;

      // Clear SharedPreferences permission data
      const permissionsToClean = [
        'notification_permission_requested',
        'notification_permission_requested_time',
        'notification_permission_denied_count',
        'notification_settings_opened',
        'first_time_permission_request',
      ];

      for (final key in permissionsToClean) {
        await SharedPrefHelper.removeData(key);
      }

      log('✅ Permission cache cleared');
    } catch (e) {
      log('❌ Error clearing permission cache: $e');
    }
  }

  /// Get permission status with user-friendly explanation
  PermissionExplanation getPermissionExplanation(bool isGranted) {
    if (isGranted) {
      return PermissionExplanation(
        isGranted: true,
        title: 'Notifications Enabled',
        message: 'You will receive notifications for bookings and offers.',
        actionText: null,
        shouldShowSettings: false,
      );
    } else {
      return PermissionExplanation(
        isGranted: false,
        title: 'Enable Notifications',
        message:
            'Stay updated with your bookings and special offers by enabling notifications.',
        actionText: 'Enable Notifications',
        shouldShowSettings: false,
      );
    }
  }

  /// Handle permission denied scenario with user guidance
  Future<void> _handlePermissionGuidance() async {
    try {
      log('⚠️ Providing guidance for denied notification permission');

      // Track denial count
      const denialCountKey = 'notification_permission_denied_count';
      int denialCount = await SharedPrefHelper.getInt(denialCountKey);
      denialCount++;
      await SharedPrefHelper.setData(denialCountKey, denialCount);

      if (denialCount >= 2) {
        // After 2 denials, suggest opening settings
        log('💡 Suggesting user to open device settings');
      }
    } catch (e) {
      log('❌ Error handling permission denied: $e');
    }
  }

  /// Check if notification permission is optimal for the app
  Future<bool> isNotificationPermissionOptimal() async {
    return await getNotificationPermissionStatus();
  }

  /// Get permission denial count
  Future<int> getPermissionDenialCount() async {
    try {
      const denialCountKey = 'notification_permission_denied_count';
      return await SharedPrefHelper.getInt(denialCountKey);
    } catch (e) {
      log('Error getting denial count: $e');
      return 0;
    }
  }

  /// Check if we should show settings guidance
  Future<bool> shouldShowSettingsGuidance() async {
    try {
      final denialCount = await getPermissionDenialCount();
      return denialCount >= 2;
    } catch (e) {
      log('Error checking settings guidance: $e');
      return false;
    }
  }

  /// Mark that settings were opened (to avoid repeated suggestions)
  Future<void> markSettingsOpened() async {
    try {
      const key = 'notification_settings_opened';
      await SharedPrefHelper.setData(key, true);
    } catch (e) {
      log('Error marking settings opened: $e');
    }
  }

  /// Reset permission manager state (for account deletion/logout)
  Future<void> reset() async {
    try {
      log('🔄 Resetting Permission Manager...');
      await clearPermissionCache();
      log('✅ Permission Manager reset completed');
    } catch (e) {
      log('❌ Permission Manager reset failed: $e');
    }
  }

  /// Check if this is the first time requesting permission
  Future<bool> isFirstTimeRequest() async {
    try {
      const key = 'first_time_permission_request';
      final isFirstTime = !(await SharedPrefHelper.getBool(key));
      if (isFirstTime) {
        await SharedPrefHelper.setData(key, true);
      }
      return isFirstTime;
    } catch (e) {
      log('Error checking first time request: $e');
      return true;
    }
  }
}

/// Permission explanation model
class PermissionExplanation {
  final bool isGranted;
  final String title;
  final String message;
  final String? actionText;
  final bool shouldShowSettings;

  PermissionExplanation({
    required this.isGranted,
    required this.title,
    required this.message,
    this.actionText,
    this.shouldShowSettings = false,
  });
}
