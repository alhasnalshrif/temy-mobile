import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/features/auth/data/repos/sign_up_repo.dart';
import 'package:temy_barber/features/auth/logic/sign_up_state.dart';

import '../../../core/di/dependency_injection.dart';
import '../../../core/helpers/constants.dart';
import '../../../core/helpers/shared_pref_helper.dart';
import '../../../core/networking/dio_factory.dart';
import '../../profile/logic/notification_cubit.dart';
import '../data/models/sign_up_request_body.dart';

class SignupCubit extends Cubit<SignupState> {
  final SignupRepo _signupRepo;
  SignupCubit(this._signupRepo) : super(const SignupState.initial());

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmationController =
      TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitSignupStates() async {
    emit(const SignupState.signupLoading());
    final response = await _signupRepo.signup(
      SignupRequestBody(
        name: nameController.text,
        phone: phoneController.text,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmationController.text,
        gender: 0,
      ),
    );
    response.when(success: (signupResponse) async {
      await saveUserToken(
          signupResponse.token ?? '', signupResponse.data!.user?.id ?? '');
      emit(SignupState.signupSuccess(signupResponse));
    }, failure: (error) {
      emit(SignupState.signupError(error: error.apiErrorModel.message ?? ''));
    });
  }


  Future<void> saveUserToken(String token, String id) async {
    // save token to shared preferences
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userId, id);
    DioFactory.setTokenIntoHeaderAfterLogin(token);

    // Update device token on server after successful login
    try {
      final notificationCubit = getIt<NotificationCubit>();
      await notificationCubit.setUserId(id);
    } catch (error) {
      // Don't fail the login process if notification setup fails
      debugPrint('Failed to update device token after login: $error');
    }
  }
}
