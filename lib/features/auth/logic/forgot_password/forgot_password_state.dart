import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:temy_barber/features/auth/data/models/forgot_password_response.dart';

part 'forgot_password_state.freezed.dart';

@freezed
class ForgotPasswordState with _$ForgotPasswordState {
  const factory ForgotPasswordState.initial() = _Initial;
  const factory ForgotPasswordState.loading() = _Loading;
  const factory ForgotPasswordState.success(ForgotPasswordResponse response) = _Success;
  const factory ForgotPasswordState.error(String error) = _Error;
}