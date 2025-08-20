import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/profile/data/apis/profile_api_services.dart';
import 'package:temy_barber/features/profile/data/models/profile_response.dart';
import 'package:temy_barber/features/profile/data/models/notification_request.dart';
import 'package:temy_barber/features/profile/data/models/notification_response.dart';

class ProfileRepo {
  final ProfileApiServices _profileApiServices;

  ProfileRepo(this._profileApiServices);

  Future<ApiResult<UserProfile>> getProfile() async {
    try {
      final response = await _profileApiServices.getProfile();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<UserProfile>> updateProfile(
      Map<String, dynamic> updateData) async {
    try {
      final response = await _profileApiServices.updateProfile(updateData);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<UserProfile>> deleteProfile() async {
    try {
      final response = await _profileApiServices.deleteProfile();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  // Notification methods
  Future<ApiResult<NotificationResponse>> updateDeviceToken(
      NotificationTokenRequest request) async {
    try {
      final response = await _profileApiServices.updateDeviceToken(request);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<NotificationResponse>> registerDevice(
      String userId, String playerId) async {
    try {
      final response = await _profileApiServices.registerDevice({
        'userId': userId,
        'playerId': playerId,
      });
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
