import 'api_error_handler.dart';
import 'api_result.dart';

class ApiSafeCall {
  static Future<ApiResult<T>> call<T>(Future<T> Function() apiCall) async {
    try {
      final response = await apiCall();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  static Future<ApiResult<void>> callVoid(Future<void> Function() apiCall) async {
    try {
      await apiCall();
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
