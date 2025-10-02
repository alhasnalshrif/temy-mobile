import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/networking/dio_factory.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/features/auth/data/models/login_request_body.dart';
import 'package:temy_barber/features/auth/data/repos/login_repo.dart';
import 'package:temy_barber/features/auth/logic/cubit/login_state.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());
    final response = await _loginRepo.login(
      LoginRequestBody(
        phone: emailController.text,
        password: passwordController.text,
      ),
    );
    response.when(success: (loginResponse) async {
      await saveUserToken(
          loginResponse.token ?? '', loginResponse.data!.user?.id ?? '');
      emit(LoginState.success(loginResponse));
    }, failure: (error) {
      emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
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
