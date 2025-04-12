import 'package:flutter_complete_project/core/networking/api_error_handler.dart';
import 'package:flutter_complete_project/core/networking/api_result.dart';
import 'package:flutter_complete_project/features/profile/data/apis/profile_api_services.dart';
import 'package:flutter_complete_project/features/profile/data/models/profile_response.dart';

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
}
