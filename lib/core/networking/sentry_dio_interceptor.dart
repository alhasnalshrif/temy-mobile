import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter/foundation.dart';

class SentryDioInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Capture network errors to Sentry
    _captureNetworkError(err);
    super.onError(err, handler);
  }

  void _captureNetworkError(DioException error) async {
    // Don't capture errors in debug mode to avoid noise
    if (kDebugMode) return;

    await Sentry.captureException(
      error,
      stackTrace: error.stackTrace,
      withScope: (scope) {
        scope.setTag('error_type', 'network_error');
        scope.setTag('http_method', error.requestOptions.method);
        scope.setTag('http_status_code', error.response?.statusCode?.toString() ?? 'unknown');
        
        // Add request details
        scope.setExtra('url', error.requestOptions.uri.toString());
        scope.setExtra('method', error.requestOptions.method);
        scope.setExtra('response_status_code', error.response?.statusCode);
        scope.setExtra('response_data', error.response?.data?.toString());
        
        // Add request headers (excluding sensitive data)
        final sanitizedHeaders = <String, dynamic>{};
        error.requestOptions.headers.forEach((key, value) {
          if (!_isSensitiveHeader(key)) {
            sanitizedHeaders[key] = value;
          }
        });
        scope.setExtra('request_headers', sanitizedHeaders);
          // Categorize the error
        scope.setExtra('error_type', _getErrorType(error));
        scope.setExtra('error_message', error.message ?? 'Unknown network error');
        scope.setExtra('is_timeout', error.type == DioExceptionType.connectionTimeout ||
                       error.type == DioExceptionType.receiveTimeout ||
                       error.type == DioExceptionType.sendTimeout);
      },
    );
  }

  String _getErrorType(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return 'connection_timeout';
      case DioExceptionType.sendTimeout:
        return 'send_timeout';
      case DioExceptionType.receiveTimeout:
        return 'receive_timeout';
      case DioExceptionType.badResponse:
        return 'bad_response';
      case DioExceptionType.cancel:
        return 'request_cancelled';
      case DioExceptionType.connectionError:
        return 'connection_error';
      case DioExceptionType.unknown:
        return 'unknown_error';
      default:
        return 'unknown_error';
    }
  }

  bool _isSensitiveHeader(String headerName) {
    final sensitiveHeaders = [
      'authorization',
      'cookie',
      'set-cookie',
      'x-api-key',
      'x-auth-token',
    ];
    return sensitiveHeaders.contains(headerName.toLowerCase());
  }
  
  /// Capture OneSignal initialization errors
  void captureOneSignalError(Object error, {
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? additionalData,
  }) async {
    // Don't capture errors in debug mode to avoid noise
    if (kDebugMode) return;

    await Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) {
        scope.setTag('error_type', 'onesignal_error');
        scope.setTag('component', 'notification_service');
        
        // Add context information
        scope.setExtra('error_context', context ?? 'Unknown context');
        scope.setExtra('error_message', error.toString());
        scope.setExtra('timestamp', DateTime.now().toIso8601String());
        
        // Add any additional data
        if (additionalData != null) {
          additionalData.forEach((key, value) {
            scope.setExtra(key, value);
          });
        }
        
        // Categorize error type
        if (error.toString().contains('Must call \'initWithContext\'')) {
          scope.setExtra('onesignal_error_type', 'initialization_context_missing');
        } else if (error.toString().contains('MissingPluginException')) {
          scope.setExtra('onesignal_error_type', 'plugin_not_registered');
        } else if (error.toString().contains('permission')) {
          scope.setExtra('onesignal_error_type', 'permission_error');
        } else {
          scope.setExtra('onesignal_error_type', 'unknown_onesignal_error');
        }
      },
    );
  }
}
