import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:temy_barber/core/auth/auth_service.dart';

class AuthInterceptor extends Interceptor {
  // ignore: unused_field
  final Dio _dio;

  AuthInterceptor(this._dio);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {

    final token = await AuthService.instance.getToken();

    if (token != null && token.isNotEmpty) {
      options.headers['authorization'] = 'Bearer $token';
    } else {
      debugPrint('AuthInterceptor: No token available');
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
 

    // Handle 401 Unauthorized errors
    if (err.response?.statusCode == 401) {
      debugPrint(
        '🔐 AuthInterceptor: 401 Unauthorized - Token invalid or expired',
      );

      await AuthService.instance.clearAuthentication();

        debugPrint('AuthInterceptor: User needs to re-authenticate');
    }

    // Handle 403 Forbidden errors
    if (err.response?.statusCode == 403) {
      debugPrint(
        'AuthInterceptor: 403 Forbidden - Insufficient permissions',
      );
    }

    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
      '✅ AuthInterceptor: Response received - Status: ${response.statusCode}',
    );

    // Check if response contains a new token (some APIs return refreshed tokens)
    // We skip this for signup/login responses to avoid duplicate saves
    final path = response.requestOptions.path;
    final isAuthEndpoint = path.contains('signup') || path.contains('login');

    if (!isAuthEndpoint &&
        response.data is Map &&
        response.data.containsKey('token')) {
      final newToken = response.data['token'];
      if (newToken != null && newToken is String && newToken.isNotEmpty) {
        debugPrint('🔄 AuthInterceptor: New token received in response, updating...');
        AuthService.instance.saveToken(newToken);
      }
    }

    handler.next(response);
  }
}
