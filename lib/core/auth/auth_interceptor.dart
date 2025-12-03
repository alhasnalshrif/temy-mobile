import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:temy_barber/core/auth/auth_service.dart';

/// Dio interceptor to handle authentication and token refresh
class AuthInterceptor extends Interceptor {
  final Dio _dio;
  
  AuthInterceptor(this._dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint('🔐 AuthInterceptor: Intercepting request to ${options.path}');
    
    // Get token from storage
    final token = await AuthService.instance.getToken();
    
    if (token != null && token.isNotEmpty) {
      // Add token to request headers
      options.headers['authorization'] = 'Bearer $token';
      debugPrint('✅ AuthInterceptor: Token added to request');
    } else {
      debugPrint('⚠️ AuthInterceptor: No token available');
    }
    
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint('❌ AuthInterceptor: Error intercepted - Status: ${err.response?.statusCode}');
    
    // Handle 401 Unauthorized errors
    if (err.response?.statusCode == 401) {
      debugPrint('🔐 AuthInterceptor: 401 Unauthorized - Token invalid or expired');
      
      // Clear authentication data
      await AuthService.instance.clearAuthentication();
      
      // TODO: If your backend supports token refresh, implement it here
      // Example:
      // try {
      //   final newToken = await _refreshToken();
      //   if (newToken != null) {
      //     await AuthService.instance.saveToken(newToken);
      //     return _retry(err.requestOptions, handler);
      //   }
      // } catch (e) {
      //   debugPrint('❌ AuthInterceptor: Token refresh failed: $e');
      // }
      
      // If no refresh or refresh failed, clear auth and pass error
      debugPrint('🚪 AuthInterceptor: User needs to re-authenticate');
    }
    
    // Handle 403 Forbidden errors
    if (err.response?.statusCode == 403) {
      debugPrint('🚫 AuthInterceptor: 403 Forbidden - Insufficient permissions');
    }
    
    handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint('✅ AuthInterceptor: Response received - Status: ${response.statusCode}');
    
    // Check if response contains a new token (some APIs return refreshed tokens)
    if (response.data is Map && response.data.containsKey('token')) {
      final newToken = response.data['token'];
      if (newToken != null && newToken is String && newToken.isNotEmpty) {
        debugPrint('🔄 AuthInterceptor: New token received, updating...');
        AuthService.instance.saveToken(newToken);
      }
    }
    
    handler.next(response);
  }

  // Uncomment and implement these methods when your backend supports token refresh
  
  // /// Retry a failed request with new token
  // Future<Response<dynamic>> _retry(
  //   RequestOptions requestOptions,
  //   ErrorInterceptorHandler handler,
  // ) async {
  //   debugPrint('🔄 AuthInterceptor: Retrying request...');
  //   
  //   final options = Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );
  //   
  //   return _dio.request<dynamic>(
  //     requestOptions.path,
  //     data: requestOptions.data,
  //     queryParameters: requestOptions.queryParameters,
  //     options: options,
  //   );
  // }

  // /// Refresh token (implement based on your backend API)
  // Future<String?> _refreshToken() async {
  //   try {
  //     debugPrint('🔄 AuthInterceptor: Attempting to refresh token...');
  //     
  //     // TODO: Implement token refresh logic based on your backend
  //     // Example:
  //     // final refreshToken = await SharedPrefHelper.getSecuredString('refreshToken');
  //     // if (refreshToken == null) return null;
  //     // 
  //     // final response = await _dio.post(
  //     //   '/auth/refresh',
  //     //   data: {'refreshToken': refreshToken},
  //     // );
  //     // 
  //     // if (response.statusCode == 200 && response.data['token'] != null) {
  //     //   return response.data['token'];
  //     // }
  //     
  //     return null;
  //   } catch (e) {
  //     debugPrint('❌ AuthInterceptor: Token refresh error: $e');
  //     return null;
  //   }
  // }
}
