import 'package:temy_barber/core/networking/api_safe_call.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/profile/data/apis/profile_api_services.dart';
import 'package:temy_barber/features/profile/data/models/profile_response.dart';
import 'package:temy_barber/features/profile/data/models/notification_request.dart';
import 'package:temy_barber/features/profile/data/models/notification_response.dart';

class ProfileRepo {
  final ProfileApiServices _profileApiServices;

  ProfileRepo(this._profileApiServices);

  Future<ApiResult<UserProfile>> getProfile() async {
    return ApiSafeCall.call(() => _profileApiServices.getProfile());
  }

  Future<ApiResult<UserProfile>> updateProfile(
      Map<String, dynamic> updateData) async {
    return ApiSafeCall.call(
      () => _profileApiServices.updateProfile(updateData),
    );
  }

  Future<ApiResult<void>> deleteProfile() async {
    return ApiSafeCall.callVoid(() => _profileApiServices.deleteProfile());
  }

  Future<ApiResult<NotificationResponse>> updateDeviceToken(
      NotificationTokenRequest request) async {
    return ApiSafeCall.call(
      () => _profileApiServices.updateDeviceToken(request),
    );
  }

  Future<ApiResult<NotificationResponse>> registerDevice(
      String userId, String playerId) async {
    return ApiSafeCall.call(
      () => _profileApiServices.registerDevice({
        'userId': userId,
        'playerId': playerId,
      }),
    );
  }
}
