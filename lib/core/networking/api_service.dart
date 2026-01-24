import 'package:dio/dio.dart';
import 'package:temy_barber/core/networking/api_constants.dart';
import 'package:temy_barber/features/auth/data/models/login_request_body.dart';
import 'package:temy_barber/features/auth/data/models/login_response.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/auth/data/models/sign_up_request_body.dart';
import '../../features/auth/data/models/sign_up_response.dart';
import '../../features/auth/data/models/resend_code_request_body.dart';
import '../../features/auth/data/models/verification_request_body.dart';
import '../../features/auth/data/models/forgot_password_request_body.dart';
import '../../features/auth/data/models/forgot_password_response.dart';
import '../../features/auth/data/models/reset_password_request_body.dart';
import '../../features/auth/data/models/reset_password_response.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiConstants.login)
  Future<LoginResponse> login(@Body() LoginRequestBody loginRequestBody);

  @POST(ApiConstants.signup)
  Future<SignupResponse> signup(@Body() SignupRequestBody signupRequestBody);

  @POST(ApiConstants.verify)
  Future<SignupResponse> verify(
    @Body() VerificationRequestBody verificationRequestBody,
  );

  @POST(ApiConstants.resendCode)
  Future<SignupResponse> resendVerificationCode(
    @Body() ResendCodeRequestBody resendCodeRequestBody,
  );

  @POST(ApiConstants.requestPasswordReset)
  Future<ForgotPasswordResponse> requestPasswordReset(
    @Body() ForgotPasswordRequestBody forgotPasswordRequestBody,
  );

  @POST(ApiConstants.resetPassword)
  Future<ResetPasswordResponse> resetPassword(
    @Body() ResetPasswordRequestBody resetPasswordRequestBody,
  );
}
