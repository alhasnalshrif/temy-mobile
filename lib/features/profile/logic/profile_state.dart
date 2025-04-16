import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/profile/data/models/profile_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = _Initial;

  // categories
  const factory ProfileState.profileLoading() = ProfileLoading;
  const factory ProfileState.profileSuccess(UserProfile userProfile) =
      ProfileSuccess;

  const factory ProfileState.profileError(ErrorHandler errorHandler) =
      ProfileError;
}
