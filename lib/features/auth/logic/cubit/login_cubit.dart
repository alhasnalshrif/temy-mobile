import 'package:flutter/material.dart';
import 'package:temy_barber/core/auth/auth_service.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/auth/data/models/login_request_body.dart';
import 'package:temy_barber/features/auth/data/repos/login_repo.dart';
import 'package:temy_barber/features/auth/logic/cubit/login_state.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';

class LoginCubit extends BaseCubit<LoginState> {
  final LoginRepo _loginRepo;

  LoginCubit(this._loginRepo) : super(const LoginState.initial());

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitLoginStates() async {
    emit(const LoginState.loading());

    executeApi(
      apiCall: () => _loginRepo.login(
        LoginRequestBody(
          phone: emailController.text,
          password: passwordController.text,
        ),
      ),
      onSuccess: (data) async {
        await saveUserToken(data.token ?? '', data.data!.user?.id ?? '');
        emit(LoginState.success(data));
      },
      onError: (error) {
        emit(LoginState.error(error: error.apiErrorModel.message ?? ''));
      },
    );
  }

  Future<void> saveUserToken(String token, String id) async {
    try {
      await AuthService.instance.saveToken(token, userId: id);
      isLoggedInUser = true;
    } catch (e) {
      debugPrint('Failed to save auth token: $e');
      rethrow;
    }

    try {
      final notificationCubit = getIt<NotificationCubit>();
      await notificationCubit.setUserId(id);
    } catch (error) {
      debugPrint('Failed to update device token after login: $error');
    }
  }
}
