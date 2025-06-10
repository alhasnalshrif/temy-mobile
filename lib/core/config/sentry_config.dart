import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class SentryConfig {
  // TODO: Replace with your actual Sentry DSN from sentry.io
  static const String _dsn = 'YOUR_SENTRY_DSN_HERE';
  
  static Future<void> init() async {
    await SentryFlutter.init(
      (options) {
        options.dsn = _dsn;
        options.environment = kDebugMode ? 'development' : 'production';
        options.debug = kDebugMode;
        
        // Performance monitoring
        options.tracesSampleRate = kDebugMode ? 1.0 : 0.1; // 100% in debug, 10% in production
        
        // Error tracking options
        options.attachStacktrace = true;
        options.enableAutoSessionTracking = true;
        options.autoAppStart = true;
        
        // Capture options
        options.captureFailedRequests = true;
        options.maxBreadcrumbs = 100;
        
        // Filter out sensitive information
        options.beforeSend = (event, hint) {
          // Filter out any sensitive data here if needed
          return event;
        };
      },
    );
  }
  
  /// Capture an exception manually
  static Future<void> captureException(
    dynamic exception, {
    dynamic stackTrace,
    String? tag,
    Map<String, dynamic>? extra,
  }) async {
    await Sentry.captureException(
      exception,
      stackTrace: stackTrace,
      withScope: (scope) {
        if (tag != null) {
          scope.setTag('custom_tag', tag);
        }
        if (extra != null) {
          extra.forEach((key, value) {
            scope.setExtra(key, value);
          });
        }
      },
    );
  }
  
  /// Capture a message manually
  static Future<void> captureMessage(
    String message, {
    SentryLevel level = SentryLevel.info,
    String? tag,
    Map<String, dynamic>? extra,
  }) async {
    await Sentry.captureMessage(
      message,
      level: level,
      withScope: (scope) {
        if (tag != null) {
          scope.setTag('custom_tag', tag);
        }
        if (extra != null) {
          extra.forEach((key, value) {
            scope.setExtra(key, value);
          });
        }
      },
    );
  }
  
  /// Add breadcrumb for debugging
  static void addBreadcrumb(String message, {String? category}) {
    Sentry.addBreadcrumb(
      Breadcrumb(
        message: message,
        category: category ?? 'custom',
        level: SentryLevel.info,
      ),
    );
  }
  
  /// Set user context
  static void setUser({
    String? id,
    String? email,
    String? username,
    Map<String, dynamic>? extras,
  }) {
    Sentry.configureScope((scope) {
      scope.setUser(SentryUser(
        id: id,
        email: email,
        username: username,
        extras: extras,
      ));
    });
  }
    /// Clear user context (e.g., on logout)
  static void clearUser() {
    Sentry.configureScope((scope) {
      scope.setUser(null);
    });
  }
}
