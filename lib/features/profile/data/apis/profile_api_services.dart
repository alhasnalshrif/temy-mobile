import 'package:dio/dio.dart';
import 'package:temy_barber/core/networking/api_constants.dart';
import 'package:temy_barber/features/profile/data/apis/profile_api_constants.dart';
import 'package:temy_barber/features/profile/data/models/profile_response.dart';
import 'package:temy_barber/features/profile/data/models/notification_request.dart';
import 'package:temy_barber/features/profile/data/models/notification_response.dart';
import 'package:retrofit/retrofit.dart';

part 'profile_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ProfileApiServices {
  factory ProfileApiServices(Dio dio, {String baseUrl}) = _ProfileApiServices;

  @GET(HomeApiConstants.profile)
  Future<UserProfile> getProfile();
  @PUT(HomeApiConstants.profileUpdate)
  Future<UserProfile> updateProfile(@Body() Map<String, dynamic> updateData);
  // Notification endpoints
  @POST(HomeApiConstants.updateDeviceToken)
  Future<NotificationResponse> updateDeviceToken(
      @Body() NotificationTokenRequest request);

  @POST(HomeApiConstants.updateDeviceToken)
  Future<NotificationResponse> registerDevice(
      @Body() Map<String, dynamic> deviceData);

 
}
