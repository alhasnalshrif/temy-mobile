import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:temy_barber/core/networking/api_constants.dart';
import 'package:temy_barber/features/settings/data/models/settings_response.dart';

part 'settings_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class SettingsApiService {
  factory SettingsApiService(Dio dio) = _SettingsApiService;

  @GET("settings")
  Future<SettingsResponse> getSettings();
}
