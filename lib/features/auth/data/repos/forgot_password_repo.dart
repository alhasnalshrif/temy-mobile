import 'package:temy_barber/core/networking/api_safe_call.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/networking/api_service.dart';
import 'package:temy_barber/features/auth/data/models/forgot_password_request_body.dart';
import 'package:temy_barber/features/auth/data/models/forgot_password_response.dart';
import 'package:temy_barber/features/auth/data/models/reset_password_request_body.dart';
import 'package:temy_barber/features/auth/data/models/reset_password_response.dart';

class ForgotPasswordRepo {
  final ApiService _apiService;

  ForgotPasswordRepo(this._apiService);

  Future<ApiResult<ForgotPasswordResponse>> requestPasswordReset(
      ForgotPasswordRequestBody forgotPasswordRequestBody) async {
    return ApiSafeCall.call(
      () => _apiService.requestPasswordReset(forgotPasswordRequestBody),
    );
  }

  Future<ApiResult<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequestBody resetPasswordRequestBody) async {
    return ApiSafeCall.call(
      () => _apiService.resetPassword(resetPasswordRequestBody),
    );
  }
}
