import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/auth/data/models/reset_password_request_body.dart';
import 'package:temy_barber/features/auth/data/repos/forgot_password_repo.dart';
import 'package:temy_barber/features/auth/logic/reset_password/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ForgotPasswordRepo _forgotPasswordRepo;

  // Add form key and controllers
  final TextEditingController codeController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  // Store phone number
  String? _phoneNumber;

  ResetPasswordCubit(this._forgotPasswordRepo) : super(const ResetPasswordState.initial());

  // Set phone number from previous screen
  void setPhoneNumber(String phone) {
    _phoneNumber = phone;
  }

  Future<void> resetPassword() async {
    if (_phoneNumber == null || _phoneNumber!.isEmpty) {
      emit(const ResetPasswordState.error('Phone number is missing'));
      return;
    }
    
    emit(const ResetPasswordState.loading());
    
    final response = await _forgotPasswordRepo.resetPassword(
      ResetPasswordRequestBody(
        phone: _phoneNumber!,
        code: codeController.text,
        newPassword: passwordController.text,
        passwordConfirm: confirmPasswordController.text,
      ),
    );
    
    response.when(
      success: (data) {
        emit(ResetPasswordState.success(data));
      },
      failure: (error) {
        emit(ResetPasswordState.error(error.apiErrorModel.message ?? 'An error occurred'));
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