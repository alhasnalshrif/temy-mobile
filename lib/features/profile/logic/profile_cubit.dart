import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/core/services/cleanup_service.dart';
import 'package:temy_barber/features/profile/data/repos/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends BaseCubit<ProfileState> {
  final ProfileRepo _homeRepo;
  final CleanupService _cleanupService;

  ProfileCubit(this._homeRepo, this._cleanupService)
    : super(const ProfileState.initial());

  void getProfile() async {
    emit(const ProfileState.profileLoading());

    executeApi(
      apiCall: () => _homeRepo.getProfile(),
      onSuccess: (userProfile) {
        if (userProfile.user?.name != null) {
          SharedPrefHelper.setData(
            SharedPrefKeys.userName,
            userProfile.user!.name,
          );
        }
        emit(ProfileState.profileSuccess(userProfile));
      },
      onError: (error) {
        emit(ProfileState.profileError(error));
      },
    );
  }

  Future<void> logout() async {
    emit(const ProfileState.profileLoading());

    try {
      log('🚀 Starting logout process...');
      await _cleanupService.performLogoutCleanup();
      isLoggedInUser = false;
      log('✅ Logout completed successfully');
      emit(const ProfileState.initial());
    } catch (error) {
      log('❌ Logout failed: $error');
      emit(const ProfileState.initial());
    }
  }

  void deleteAccount() async {
    emit(const ProfileState.deleteLoading());

    executeApi(
      apiCall: () => _homeRepo.deleteProfile(),
      onSuccess: (_) {
        log('✅ Account deleted successfully on server');
        _cleanupService.performAccountDeletionCleanup();
        isLoggedInUser = false;
        emit(const ProfileState.deleteSuccess('Account deleted successfully'));
      },
      onError: (error) {
        log('❌ Account deletion failed: ${error.apiErrorModel.message}');
        emit(ProfileState.deleteError(error));
      },
    );
  }
}
