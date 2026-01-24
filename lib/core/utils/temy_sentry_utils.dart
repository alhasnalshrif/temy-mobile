import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:temy_barber/core/config/sentry_config.dart';

/// Utility class for common Sentry operations specific to the Temy Barber app
class TemySentryUtils {
  /// Track user authentication events
  static Future<void> trackAuthEvent(
    String event, {
    String? userId,
    String? error,
  }) async {
    await SentryConfig.captureMessage(
      'Auth Event: $event',
      level: error != null ? SentryLevel.error : SentryLevel.info,
      tag: 'authentication',
      extra: {
        'event': event,
        'userId': userId,
        'error': error,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Track booking-related events and errors
  static Future<void> trackBookingEvent(
    String event, {
    String? bookingId,
    String? barberId,
    String? userId,
    String? error,
  }) async {
    await SentryConfig.captureMessage(
      'Booking Event: $event',
      level: error != null ? SentryLevel.error : SentryLevel.info,
      tag: 'booking',
      extra: {
        'event': event,
        'bookingId': bookingId,
        'barberId': barberId,
        'userId': userId,
        'error': error,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Track payment-related events
  static Future<void> trackPaymentEvent(
    String event, {
    String? paymentId,
    String? amount,
    String? currency,
    String? error,
  }) async {
    await SentryConfig.captureMessage(
      'Payment Event: $event',
      level: error != null ? SentryLevel.error : SentryLevel.info,
      tag: 'payment',
      extra: {
        'event': event,
        'paymentId': paymentId,
        'amount': amount,
        'currency': currency,
        'error': error,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Track navigation events
  static void trackNavigation(String fromRoute, String toRoute) {
    SentryConfig.addBreadcrumb(
      'Navigation: $fromRoute → $toRoute',
      category: 'navigation',
    );
  }

  /// Track feature usage
  static void trackFeatureUsage(
    String feature, {
    Map<String, dynamic>? properties,
  }) {
    SentryConfig.addBreadcrumb(
      'Feature Used: $feature',
      category: 'feature_usage',
    );

    if (properties != null) {
      Sentry.configureScope((scope) {
        scope.setContexts('feature_data', properties);
      });
    }
  }

  /// Track critical business errors
  static Future<void> trackCriticalError(
    String error, {
    String? context,
    Map<String, dynamic>? additionalData,
  }) async {
    await SentryConfig.captureMessage(
      'Critical Error: $error',
      level: SentryLevel.fatal,
      tag: 'critical',
      extra: {
        'error': error,
        'context': context,
        'timestamp': DateTime.now().toIso8601String(),
        ...?additionalData,
      },
    );
  }

  /// Track performance issues
  static Future<void> trackPerformanceIssue(
    String issue, {
    int? duration,
    String? operation,
  }) async {
    await SentryConfig.captureMessage(
      'Performance Issue: $issue',
      level: SentryLevel.warning,
      tag: 'performance',
      extra: {
        'issue': issue,
        'duration_ms': duration,
        'operation': operation,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Set user context after login
  static void setUserContext({
    required String userId,
    String? email,
    String? name,
    String? phone,
    String? userType, // 'customer' or 'barber'
  }) {
    SentryConfig.setUser(
      id: userId,
      email: email,
      username: name,
      data: {
        'phone': phone,
        'user_type': userType,
        'login_time': DateTime.now().toIso8601String(),
      },
    );
  }

  /// Track app lifecycle events
  static void trackAppLifecycle(String event) {
    SentryConfig.addBreadcrumb(
      'App Lifecycle: $event',
      category: 'app_lifecycle',
    );
  }

  /// Track OneSignal notification events and errors
  static Future<void> trackNotificationEvent(
    String event, {
    String? error,
    String? permissionStatus,
    String? playerId,
    Map<String, dynamic>? additionalData,
  }) async {
    await SentryConfig.captureMessage(
      'Notification Event: $event',
      level: error != null ? SentryLevel.error : SentryLevel.info,
      tag: 'notifications',
      extra: {
        'event': event,
        'error': error,
        'permission_status': permissionStatus,
        'player_id': playerId,
        'timestamp': DateTime.now().toIso8601String(),
        ...?additionalData,
      },
    );
  }

  /// Track OneSignal initialization status
  static Future<void> trackOneSignalInit({
    required bool success,
    String? appId,
    String? error,
    String? version,
  }) async {
    await SentryConfig.captureMessage(
      'OneSignal Initialization: ${success ? "Success" : "Failed"}',
      level: success ? SentryLevel.info : SentryLevel.error,
      tag: 'onesignal_init',
      extra: {
        'success': success,
        'app_id':
            appId?.substring(0, 8) ??
            'unknown', // Only log first 8 chars for privacy
        'error': error,
        'version': version,
        'timestamp': DateTime.now().toIso8601String(),
      },
    );
  }
}

/// Extension for easier Sentry integration in widgets
extension WidgetSentryExtension on Object {
  /// Safely execute a function and report errors to Sentry
  Future<T?> executeSafely<T>(
    Future<T> Function() function, {
    String? context,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      return await function();
    } catch (e, stackTrace) {
      await SentryConfig.captureException(
        e,
        stackTrace: stackTrace,
        tag: 'widget_error',
        extra: {
          'context': context ?? runtimeType.toString(),
          'timestamp': DateTime.now().toIso8601String(),
          ...?additionalData,
        },
      );
      return null;
    }
  }
}
