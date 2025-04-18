import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/profile/data/models/profile_response.dart';

part 'update_profile_state.freezed.dart';

@freezed
class UpdateProfileState with _$UpdateProfileState {
  const factory UpdateProfileState.initial() = _Initial;

  const factory UpdateProfileState.loading() = Loading;
  const factory UpdateProfileState.success(UserProfile userProfile) = Success;
  const factory UpdateProfileState.error(ErrorHandler errorHandler) = Error;
}
