import 'package:flutter/material.dart';
import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/auth/data/repos/verification_repo.dart';
import 'package:temy_barber/features/auth/logic/verification_state.dart';

import '../data/models/verification_request_body.dart';
import '../data/models/resend_code_request_body.dart';

class VerificationCubit extends BaseCubit<VerificationState> {
  final VerificationRepo _verificationRepo;
  VerificationCubit(this._verificationRepo)
    : super(const VerificationState.initial());

  final TextEditingController codeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  String? phoneNumber;
  bool comingFromLogin = false;

  void setPhoneNumber(String phone) {
    phoneNumber = phone;
  }

  void setComingFromLogin(bool fromLogin) {
    comingFromLogin = fromLogin;
  }

  void verifyCode() async {
    if (phoneNumber == null || phoneNumber!.isEmpty) {
      emit(const VerificationState.error(error: 'Phone number is missing'));
      return;
    }

    emit(const VerificationState.loading());

    executeApi(
      apiCall: () => _verificationRepo.verify(
        VerificationRequestBody(
          verificationCode: codeController.text,
        ),
      ),
      onSuccess: (verificationResponse) {
        emit(VerificationState.success(verificationResponse));
      },
      onError: (error) {
        emit(
          VerificationState.error(
            error: error.apiErrorModel.message ?? 'Verification failed',
          ),
        );
      },
    );
  }

  void resendCode() async {
    if (phoneNumber == null || phoneNumber!.isEmpty) {
      debugPrint('ERROR: Phone number is missing for resend');
      emit(const VerificationState.error(error: 'Phone number is missing'));
      return;
    }

    debugPrint('Resending verification code to: $phoneNumber');
    emit(const VerificationState.loading());

    executeApi(
      apiCall: () => _verificationRepo.resendCode(
        ResendCodeRequestBody(phone: phoneNumber!),
      ),
      onSuccess: (resendResponse) {
        debugPrint('Verification code resent successfully');
        emit(const VerificationState.initial());
      },
      onError: (error) {
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
