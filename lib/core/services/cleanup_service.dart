import 'dart:developer';
import 'package:temy_barber/core/auth/auth_service.dart';
import 'package:temy_barber/core/services/notification_service.dart';
import 'package:temy_barber/core/services/permission_manager.dart';

/// Service responsible for cleaning up user data during logout and account deletion
class CleanupService {
  final NotificationService _notificationService;

  CleanupService(this._notificationService);

  /// Perform comprehensive cleanup for logout
  Future<void> performLogoutCleanup() async {
    try {
      log('🚀 Starting comprehensive logout cleanup...');

      // Step 1: Clear notification data
      log('📱 Clearing notification data...');
      await _notificationService.logoutUser();

      // Step 2: Clear authentication
      log('🔐 Clearing authentication...');
      await AuthService.instance.clearAuthentication();

      // Step 3: Clear cached data
      await _clearCachedData();

      // Step 4: Reset notification permissions state
      await _resetNotificationState();

      log('✅ Logout cleanup completed successfully');
    } catch (error) {
      log('❌ Logout cleanup failed: $error');
      // Force cleanup even if there's an error
      await _forceCleanup();
      rethrow;
    }
  }

  /// Perform complete cleanup after account deletion
  Future<void> performAccountDeletionCleanup() async {
    try {
      log('🧹 Performing complete account deletion cleanup...');

      // Clear all OneSignal data
      await _notificationService.logoutUser();

      // Clear authentication
      await AuthService.instance.clearAuthentication();

      // Clear cached data
      await _clearCachedData();

      // Reset notification state
      await _resetNotificationState();

      log('✅ Account deletion cleanup finished');
    } catch (error) {
      log('❌ Account deletion cleanup error: $error');
      await _forceCleanup();
    }
  }

  /// Force cleanup in case of errors
  Future<void> _forceCleanup() async {
    try {
      log('🔄 Force cleanup in progress...');
      await AuthService.instance.clearAuthentication();
      await _clearCachedData();
      await _resetNotificationState();
      log('✅ Force cleanup completed');
    } catch (error) {
      log('❌ Force cleanup error: $error');
    }
  }

  /// Clear any cached application data
  Future<void> _clearCachedData() async {
    try {
      log('📱 Clearing cached app data...');
      // Add any cached data clearing logic here
      // e.g., clear cached reservations, bookings, images, etc.
    } catch (error) {
      log('❌ Error clearing cached data: $error');
    }
  }

  /// Reset notification permission state
  Future<void> _resetNotificationState() async {
    try {
      log('🔔 Resetting notification state...');
      await PermissionManager.instance.reset();
    } catch (error) {
      log('❌ Error resetting notification state: $error');
    }
  }
}
