import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/networking/dio_factory.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/services/permission_manager.dart';
import 'package:temy_barber/core/services/notification_service.dart';
import 'package:temy_barber/features/profile/data/repos/profile_repo.dart';
import '../../../core/routing/routes.dart';
import 'profile_state.dart';
import 'dart:developer';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _homeRepo;
  final NotificationService _notificationService;

  ProfileCubit(this._homeRepo, this._notificationService)
      : super(const ProfileState.initial());

  void getProfile() async {
    emit(const ProfileState.profileLoading());
    final response = await _homeRepo.getProfile();
    response.when(
      success: (userProfile) {
        emit(ProfileState.profileSuccess(userProfile));
      },
      failure: (error) {
        emit(ProfileState.profileError(error));
      },
    );
  }

  /// Enhanced logout with comprehensive data cleanup
  Future<void> logout() async {
    emit(const ProfileState.profileLoading());

    try {
      log('🚀 Starting comprehensive logout process...');

      // Step 1: Logout from OneSignal
      log('📱 Clearing notification data...');
      await _notificationService.logoutUser();

      // Step 2: Clear HTTP authorization header
      log('🔐 Clearing API authorization...');
      DioFactory.clearTokenFromHeader();

      // Step 3: Clear all shared preferences (both regular and secure)
      log('🗑️ Clearing all local storage...');
      await SharedPrefHelper.clearAllData();
      await SharedPrefHelper.clearAllSecuredData();

      // Step 4: Clear any cached app data
      await _clearCachedData();

      // Step 5: Reset notification permissions state
      await _resetNotificationState();

      // Step 6: Update global login state
      isLoggedInUser = false;

      log('✅ Logout completed successfully');
      emit(const ProfileState.initial());
    } catch (error) {
      log('❌ Logout failed: $error');
      // If logout fails, still clear local data and emit initial state
      await _forceCleanup();
      emit(const ProfileState.initial());
    }
  }

  /// Delete user account permanently
  void deleteAccount(dialogContext) async {
    emit(const ProfileState.deleteLoading());

    try {
      log('🚀 Starting account deletion process...');

      // Step 1: Call API to delete account on server
      final response = await _homeRepo.deleteProfile();

      response.when(
        success: (deletedProfile) {
          log('✅ Account deleted successfully on server');
          Navigator.of(dialogContext).pushReplacementNamed(Routes.loginScreen);

          // Step 2: Perform comprehensive local cleanup
          _performCompleteCleanup();

          emit(ProfileState.deleteSuccess(
              deletedProfile.message ?? 'Account deleted successfully'));
        },
        failure: (error) {
          log('❌ Account deletion failed: ${error.apiErrorModel.message}');
          emit(ProfileState.deleteError(error));
        },
      );
    } catch (error) {
      log('❌ Account deletion error: $error');
      emit(ProfileState.deleteError(
        // Create a basic error handler for unexpected errors
        ErrorHandler.handle(error),
      ));
    }
  }

  /// Perform comprehensive cleanup after account deletion
  Future<void> _performCompleteCleanup() async {
    try {
      log('🧹 Performing complete cleanup...');

      // Clear all OneSignal data
      await _notificationService.logoutUser();

      // Clear API headers
      DioFactory.clearTokenFromHeader();

      // Clear all local storage
      await SharedPrefHelper.clearAllData();
      await SharedPrefHelper.clearAllSecuredData();

      // Clear cached data
      await _clearCachedData();

      // Reset notification state
      await _resetNotificationState();

      // Reset global state
      isLoggedInUser = false;

      log('✅ Complete cleanup finished');
    } catch (error) {
      log('❌ Cleanup error: $error');
    }
  }

  /// Force cleanup in case of logout failure
  Future<void> _forceCleanup() async {
    try {
      log('🔄 Force cleanup in progress...');
      DioFactory.clearTokenFromHeader();
      await SharedPrefHelper.clearAllData();
      await SharedPrefHelper.clearAllSecuredData();
      await _clearCachedData();
      await _resetNotificationState();
      isLoggedInUser = false;
      log('✅ Force cleanup completed');
    } catch (error) {
      log('❌ Force cleanup error: $error');
    }
  }

  /// Clear any cached application data
  Future<void> _clearCachedData() async {
    try {
      // Clear any cached reservations, bookings, or other app-specific data
      // This can be extended based on what your app caches locally
      log('📱 Clearing cached app data...');

      // Clear cached images, temporary files, etc. if needed
      // For now, this is a placeholder for future cache clearing
    } catch (error) {
      log('❌ Error clearing cached data: $error');
    }
  }

  /// Reset notification permission state
  Future<void> _resetNotificationState() async {
    try {
      log('🔔 Resetting notification state...');
      // Reset any notification-related states or permissions
      await PermissionManager.instance.reset();
    } catch (error) {
      log('❌ Error resetting notification state: $error');
    }
  }
}
