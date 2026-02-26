import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/auth/auth_service.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/features/auth/data/repos/sign_up_repo.dart';
import 'package:temy_barber/features/auth/logic/sign_up_state.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';

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

  static const _timeout = Duration(seconds: 20);

  void emitSignupStates() async {
    emit(const SignupState.signupLoading());

    try {
      final response = await _signupRepo
          .signup(
            SignupRequestBody(
              name: nameController.text,
              phone: phoneController.text,
              password: passwordController.text,
              passwordConfirmation: passwordConfirmationController.text,
              gender: 0,
            ),
          )
          .timeout(_timeout);

      await response.when(
        success: (signupResponse) async {
          await saveUserToken(
            signupResponse.token ?? '',
            signupResponse.data!.user?.id ?? '',
          );
          emit(SignupState.signupSuccess(signupResponse));
        },
        failure: (error) {
          emit(
            SignupState.signupError(
              error: error.apiErrorModel.message ?? 'Unknown error',
            ),
          );
        },
      );
    } on TimeoutException catch (_) {
      emit(
        const SignupState.signupError(
          error: 'Request timeout. Please try again.',
        ),
      );
    } catch (e) {
      emit(SignupState.signupError(error: e.toString()));
    }
  }

  Future<void> saveUserToken(String token, String id) async {
    try {
      await AuthService.instance.saveToken(token, userId: id);
      isLoggedInUser = true;
    } catch (e) {
      debugPrint('Failed to save auth token: $e');
      rethrow;
    }

    // Update device token on server after successful signup
    try {
      final notificationCubit = getIt<NotificationCubit>();
      await notificationCubit.setUserId(id);
    } catch (error) {
      // Don't fail the signup process if notification setup fails
      debugPrint('Failed to update device token after signup: $error');
    }
  }
}
