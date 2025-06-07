import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
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
  }

  void logout() async {
    // Logout from OneSignal
    await _notificationCubit.logoutUser();

    // Clear shared preferences
    await SharedPrefHelper.removeData(SharedPrefKeys.userToken);
    await SharedPrefHelper.removeData(SharedPrefKeys.userId);
  }
//SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)
//SharedPrefHelper.getSecuredString(SharedPrefKeys.userId)
}
