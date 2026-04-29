import 'package:temy_barber/core/networking/api_safe_call.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/networking/api_service.dart';
import 'package:temy_barber/features/auth/data/models/sign_up_response.dart';
import 'package:temy_barber/features/auth/data/models/resend_code_request_body.dart';
import 'package:temy_barber/features/auth/data/models/verification_request_body.dart';

class VerificationRepo {
  final ApiService _apiService;

  VerificationRepo(this._apiService);

  Future<ApiResult<SignupResponse>> verify(
      VerificationRequestBody verificationRequestBody) async {
    return ApiSafeCall.call(
      () => _apiService.verify(verificationRequestBody),
    );
  }

  Future<ApiResult<SignupResponse>> resendCode(
      ResendCodeRequestBody resendCodeRequestBody) async {
    return ApiSafeCall.call(
      () => _apiService.resendVerificationCode(resendCodeRequestBody),
    );
  }
}
