import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/features/profile/data/repos/profile_repo.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _homeRepo;
  ProfileCubit(this._homeRepo) : super(const ProfileState.initial());

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

  getProfileData() {}
}
