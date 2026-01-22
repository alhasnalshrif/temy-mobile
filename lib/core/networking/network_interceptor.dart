import 'package:dio/dio.dart';

/// Interceptor for network-related error handling
/// Note: We don't proactively check connectivity here because connectivity_plus
/// can report false negatives (especially with VPNs, certain WiFi configs, or emulators).
/// Instead, we rely on Dio's built-in connection error detection which is more reliable.
class NetworkInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Enhance connection errors with user-friendly messages
    if (err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout) {
      // Add localized error message
      final enhancedError = DioException(
        requestOptions: err.requestOptions,
        type: err.type,
        error: err.error,
        message: 'errors.network_unreachable',
        response: err.response,
      );
      return handler.next(enhancedError);
    }

    // Pass through other errors unchanged
    return handler.next(err);
  }
}
