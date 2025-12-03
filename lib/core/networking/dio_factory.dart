import 'package:dio/dio.dart';
import 'package:temy_barber/core/auth/auth_interceptor.dart';
import 'package:temy_barber/core/networking/sentry_dio_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

      addDioHeader();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeader() {
    dio?.options.headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    // Note: Authorization header is now handled by AuthInterceptor
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    // This method is kept for backward compatibility
    // The AuthInterceptor will handle token injection automatically
    dio?.options.headers['authorization'] = 'Bearer $token';
  }

  static void clearTokenFromHeader() {
    dio?.options.headers.remove('authorization');
  }

  static void addDioInterceptor() {
    // Clear existing interceptors to avoid duplicates
    dio?.interceptors.clear();

    // Add Auth interceptor first (handles token injection and 401 errors)
    if (dio != null) {
      dio!.interceptors.add(AuthInterceptor(dio!));
    }

    // Add Pretty Logger for debugging
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );

    // Add Sentry interceptor for error tracking
    dio?.interceptors.add(SentryDioInterceptor());
  }
}
