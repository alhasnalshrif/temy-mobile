import 'package:freezed_annotation/freezed_annotation.dart';

part 'verification_state.freezed.dart';

@freezed
class VerificationState<T> with _$VerificationState<T> {
  const factory VerificationState.initial() = _Initial;

  const factory VerificationState.loading() = VerificationLoading;
  const factory VerificationState.success(T data) = VerificationSuccess<T>;
  const factory VerificationState.error({required String error}) =
      VerificationError;
}
