import 'package:flutter/material.dart';
import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/auth/data/models/reset_password_request_body.dart';
import 'package:temy_barber/features/auth/data/repos/forgot_password_repo.dart';
import 'package:temy_barber/features/auth/logic/reset_password/reset_password_state.dart';

class ResetPasswordCubit extends BaseCubit<ResetPasswordState> {
  final ForgotPasswordRepo _forgotPasswordRepo;

  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? _phoneNumber;

  ResetPasswordCubit(this._forgotPasswordRepo) : super(const ResetPasswordState.initial());

  void setPhoneNumber(String phone) {
    _phoneNumber = phone;
  }

  Future<void> resetPassword() async {
    if (_phoneNumber == null || _phoneNumber!.isEmpty) {
      emit(const ResetPasswordState.error('Phone number is missing'));
      return;
    }

    emit(const ResetPasswordState.loading());

    executeApi(
      apiCall: () => _forgotPasswordRepo.resetPassword(
        ResetPasswordRequestBody(
          phone: _phoneNumber!,
          code: codeController.text,
          newPassword: passwordController.text,
          passwordConfirm: confirmPasswordController.text,
        ),
      ),
      onSuccess: (data) {
        emit(ResetPasswordState.success(data));
      },
      onError: (error) {
        emit(ResetPasswordState.error(
          error.apiErrorModel.message ?? 'An error occurred',
        ));
      },
    );
  }

  void reset() {
    emit(const ResetPasswordState.initial());
  }

  @override
  Future<void> close() {
    codeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
