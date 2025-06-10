import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/networking/dio_factory.dart';
import 'package:temy_barber/features/profile/data/repos/profile_repo.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _homeRepo;
  final NotificationCubit _notificationCubit;

  ProfileCubit(this._homeRepo, this._notificationCubit)
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
  }  void logout() async {
    emit(const ProfileState.profileLoading());
    
    try {
      // Logout from OneSignal first
      await _notificationCubit.logoutUser();

      // Clear HTTP authorization header
      DioFactory.clearTokenFromHeader();

      // Clear all shared preferences (both regular and secure)
      await SharedPrefHelper.clearAllData();
      await SharedPrefHelper.clearAllSecuredData();
      
      // Update global login state
      isLoggedInUser = false;
      
      emit(const ProfileState.initial());
    } catch (error) {
      // If logout fails, still clear local data and emit initial state
      DioFactory.clearTokenFromHeader();
      await SharedPrefHelper.clearAllData();
      await SharedPrefHelper.clearAllSecuredData();
      isLoggedInUser = false;
      emit(const ProfileState.initial());
    }
  }
//SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)
//SharedPrefHelper.getSecuredString(SharedPrefKeys.userId)
}
