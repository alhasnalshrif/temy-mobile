import 'package:temy_barber/core/networking/api_error_handler.dart';
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
    try {
      final response = await _apiService.requestPasswordReset(forgotPasswordRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ResetPasswordResponse>> resetPassword(
      ResetPasswordRequestBody resetPasswordRequestBody) async {
    try {
      final response = await _apiService.resetPassword(resetPasswordRequestBody);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}