import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/auth/data/repos/verification_repo.dart';
import 'package:temy_barber/features/auth/logic/verification_state.dart';

import '../data/models/verification_request_body.dart';
import '../data/models/resend_code_request_body.dart';

class VerificationCubit extends Cubit<VerificationState> {
  final VerificationRepo _verificationRepo;
  VerificationCubit(this._verificationRepo)
    : super(const VerificationState.initial());

  // Controller for verification code input
  final TextEditingController codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  // Phone number that needs verification
  String? phoneNumber;

  // Whether user came from login (vs signup)
  bool comingFromLogin = false;

  // Set the phone number that needs verification
  void setPhoneNumber(String phone) {
    phoneNumber = phone;
  }

  // Set whether user came from login
  void setComingFromLogin(bool fromLogin) {
    comingFromLogin = fromLogin;
  }

  // Verify the code
  void verifyCode() async {
    if (phoneNumber == null || phoneNumber!.isEmpty) {
      emit(const VerificationState.error(error: 'Phone number is missing'));
      return;
    }

    emit(const VerificationState.loading());
    final response = await _verificationRepo.verify(
      VerificationRequestBody(
        // phone: phoneNumber!,
        verificationCode: codeController.text,
      ),
    );

    response.when(
      success: (verificationResponse) {
        emit(VerificationState.success(verificationResponse));
      },
      failure: (error) {
        emit(
          VerificationState.error(
            error: error.apiErrorModel.message ?? 'Verification failed',
          ),
        );
      },
    );
  }

  // Resend verification code
  void resendCode() async {
    if (phoneNumber == null || phoneNumber!.isEmpty) {
      debugPrint('ERROR: Phone number is missing for resend');
      emit(const VerificationState.error(error: 'Phone number is missing'));
      return;
    }

    debugPrint('Resending verification code to: $phoneNumber');
    emit(const VerificationState.loading());
    final response = await _verificationRepo.resendCode(
      ResendCodeRequestBody(phone: phoneNumber!),
    );

    response.when(
      success: (resendResponse) {
        debugPrint('Verification code resent successfully');
        emit(const VerificationState.initial());
      },
      failure: (error) {
        debugPrint(
          'Failed to resend verification code: ${error.apiErrorModel.message}',
        );
        emit(
          VerificationState.error(
            error: error.apiErrorModel.message ?? 'Failed to resend code',
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    codeController.dispose();
    return super.close();
  }
}
