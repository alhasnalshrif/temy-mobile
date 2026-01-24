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
        scope.setTag(
          'http_status_code',
          error.response?.statusCode?.toString() ?? 'unknown',
        );

        // Add request details using contexts instead of deprecated setExtra
        final sanitizedHeaders = <String, dynamic>{};
        error.requestOptions.headers.forEach((key, value) {
          if (!_isSensitiveHeader(key)) {
            sanitizedHeaders[key] = value;
          }
        });

        scope.setContexts('request_info', {
          'url': error.requestOptions.uri.toString(),
          'method': error.requestOptions.method,
          'response_status_code': error.response?.statusCode,
          'response_data': error.response?.data?.toString(),
          'request_headers': sanitizedHeaders,
          'error_type': _getErrorType(error),
          'error_message': error.message ?? 'Unknown network error',
          'is_timeout':
              error.type == DioExceptionType.connectionTimeout ||
              error.type == DioExceptionType.receiveTimeout ||
              error.type == DioExceptionType.sendTimeout,
        });
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
  void captureOneSignalError(
    Object error, {
    StackTrace? stackTrace,
    String? context,
    Map<String, dynamic>? additionalData,
  }) async {
    // Don't capture errors in debug mode to avoid noise
    if (kDebugMode) return;

    String onesignalErrorType = 'unknown_onesignal_error';
    if (error.toString().contains('Must call \'initWithContext\'')) {
      onesignalErrorType = 'initialization_context_missing';
    } else if (error.toString().contains('MissingPluginException')) {
      onesignalErrorType = 'plugin_not_registered';
    } else if (error.toString().contains('permission')) {
      onesignalErrorType = 'permission_error';
    }

    await Sentry.captureException(
      error,
      stackTrace: stackTrace,
      withScope: (scope) {
        scope.setTag('error_type', 'onesignal_error');
        scope.setTag('component', 'notification_service');

        // Add context information using setContexts
        final contextData = <String, dynamic>{
          'error_context': context ?? 'Unknown context',
          'error_message': error.toString(),
          'timestamp': DateTime.now().toIso8601String(),
          'onesignal_error_type': onesignalErrorType,
        };

        // Add any additional data
        if (additionalData != null) {
          contextData.addAll(additionalData);
        }

        scope.setContexts('onesignal_error_info', contextData);
      },
    );
  }
}
