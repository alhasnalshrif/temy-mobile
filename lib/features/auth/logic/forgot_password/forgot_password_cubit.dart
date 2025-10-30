import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/features/auth/data/models/forgot_password_request_body.dart';
import 'package:temy_barber/features/auth/data/repos/forgot_password_repo.dart';
import 'package:temy_barber/features/auth/logic/forgot_password/forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final ForgotPasswordRepo _forgotPasswordRepo;

  // Add form key and phone controller
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  ForgotPasswordCubit(this._forgotPasswordRepo) : super(const ForgotPasswordState.initial());

  Future<void> requestPasswordReset() async {
    emit(const ForgotPasswordState.loading());
    
    final response = await _forgotPasswordRepo.requestPasswordReset(
      ForgotPasswordRequestBody(phone: phoneController.text),
    );
    
    response.when(
      success: (data) {
        emit(ForgotPasswordState.success(data));
      },
      failure: (error) {
        emit(ForgotPasswordState.error(error.apiErrorModel.message ?? 'An error occurred'));
      },
    );
  }

  void reset() {
    emit(const ForgotPasswordState.initial());
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}