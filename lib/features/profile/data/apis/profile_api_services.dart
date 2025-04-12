import 'package:dio/dio.dart';
import 'package:flutter_complete_project/core/networking/api_constants.dart';
import 'package:flutter_complete_project/features/profile/data/apis/profile_api_constants.dart';
import 'package:flutter_complete_project/features/profile/data/models/profile_response.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ProfileApiServices {
  factory ProfileApiServices(Dio dio) = _ProfileApiServices;

  @GET(HomeApiConstants.profile)
  Future<UserProfile> getProfile();
}
