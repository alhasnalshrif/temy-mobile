import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:temy_barber/features/auth/data/models/reset_password_response.dart';

part 'reset_password_state.freezed.dart';

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.initial() = _Initial;
  const factory ResetPasswordState.loading() = _Loading;
  const factory ResetPasswordState.success(ResetPasswordResponse response) = _Success;
  const factory ResetPasswordState.error(String error) = _Error;
}