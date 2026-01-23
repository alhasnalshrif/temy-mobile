import 'package:dio/dio.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/settings/data/apis/settings_api_service.dart';
import 'package:temy_barber/features/settings/data/models/settings_response.dart';

class SettingsRepo {
  final SettingsApiService _settingsApiService;

  SettingsRepo(this._settingsApiService);

  Future<ApiResult<SettingsResponse>> getSettings() async {
    try {
      final response = await _settingsApiService.getSettings();
      return ApiResult.success(response);
    } catch (error) {
      // If unauthorized, we might still want default settings or handle it.
      // But for global settings usually it should be public or we handle 401 gracefully.
      if (error is DioException && error.response?.statusCode == 401) {
        // Default fallback if needed
      }
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
