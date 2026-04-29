import 'package:flutter/material.dart';
import 'package:temy_barber/core/auth/auth_service.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/auth/data/repos/sign_up_repo.dart';
import 'package:temy_barber/features/auth/logic/sign_up_state.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';

import '../data/models/sign_up_request_body.dart';

class SignupCubit extends BaseCubit<SignupState> {
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

    executeApi(
      apiCall: () => _signupRepo.signup(
        SignupRequestBody(
          name: nameController.text,
          phone: phoneController.text,
          password: passwordController.text,
          passwordConfirmation: passwordConfirmationController.text,
          gender: 0,
        ),
      ),
      onSuccess: (signupResponse) async {
        await saveUserToken(
          signupResponse.token ?? '',
          signupResponse.data!.user?.id ?? '',
        );
        emit(SignupState.signupSuccess(signupResponse));
      },
      onError: (error) {
        emit(
          SignupState.signupError(
            error: error.apiErrorModel.message ?? 'Unknown error',
          ),
        );
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
      debugPrint('Failed to update device token after signup: $error');
    }
  }
}
