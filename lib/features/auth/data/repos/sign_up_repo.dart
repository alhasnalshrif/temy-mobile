import 'package:temy_barber/core/networking/api_safe_call.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/networking/api_service.dart';
import 'package:temy_barber/features/auth/data/models/sign_up_request_body.dart';
import 'package:temy_barber/features/auth/data/models/sign_up_response.dart';

class SignupRepo {
  final ApiService _apiService;

  SignupRepo(this._apiService);

  Future<ApiResult<SignupResponse>> signup(
      SignupRequestBody signupRequestBody) async {
    return ApiSafeCall.call(
      () => _apiService.signup(signupRequestBody),
    );
  }
}
