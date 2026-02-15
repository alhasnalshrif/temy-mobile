import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/services/cleanup_service.dart';
import 'package:temy_barber/features/profile/data/repos/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _homeRepo;
  final CleanupService _cleanupService;
  static const _timeout = Duration(seconds: 20);

  ProfileCubit(this._homeRepo, this._cleanupService)
    : super(const ProfileState.initial());

  void getProfile() async {
    emit(const ProfileState.profileLoading());

    try {
      final response = await _homeRepo.getProfile().timeout(_timeout);
      response.when(
        success: (userProfile) {
          emit(ProfileState.profileSuccess(userProfile));
        },
        failure: (error) {
          emit(ProfileState.profileError(error));
        },
      );
    } on TimeoutException catch (e) {
      emit(ProfileState.profileError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(ProfileState.profileError(ErrorHandler.handle(e)));
    }
  }

  /// Enhanced logout with comprehensive data cleanup
  Future<void> logout() async {
    emit(const ProfileState.profileLoading());

    try {
      log('🚀 Starting logout process...');

      // Use CleanupService for comprehensive cleanup
      await _cleanupService.performLogoutCleanup();
      isLoggedInUser = false;

      log('✅ Logout completed successfully');
      emit(const ProfileState.initial());
    } catch (error) {
      log('❌ Logout failed: $error');
      // If logout fails, still emit initial state
      emit(const ProfileState.initial());
    }
  }

  /// Delete user account permanently
  void deleteAccount() async {
    emit(const ProfileState.deleteLoading());

    try {
      log('🚀 Starting account deletion process...');

      // Step 1: Call API to delete account on server
      final response = await _homeRepo.deleteProfile().timeout(_timeout);

      response.when(
        success: (_) {
          log('✅ Account deleted successfully on server');

          // Step 2: Use CleanupService for comprehensive cleanup
          _cleanupService.performAccountDeletionCleanup();
          isLoggedInUser = false;

          emit(
            const ProfileState.deleteSuccess('Account deleted successfully'),
          );
        },
        failure: (error) {
          log('❌ Account deletion failed: ${error.apiErrorModel.message}');
          emit(ProfileState.deleteError(error));
        },
      );
    } on TimeoutException catch (e) {
      log('❌ Account deletion error: $e');
      emit(ProfileState.deleteError(ErrorHandler.handle(e)));
    } catch (error) {
      log('❌ Account deletion error: $error');
      emit(ProfileState.deleteError(ErrorHandler.handle(error)));
    }
  }
}
