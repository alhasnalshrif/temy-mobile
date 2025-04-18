import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/profile/data/apis/profile_api_services.dart';
import 'package:temy_barber/features/profile/data/models/profile_response.dart';

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
}
