import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/profile/data/repos/profile_repo.dart';
import 'package:temy_barber/features/profile/logic/update_profile_state.dart';

class UpdateProfileCubit extends BaseCubit<UpdateProfileState> {
  final ProfileRepo _profileRepo;
  UpdateProfileCubit(this._profileRepo)
      : super(const UpdateProfileState.initial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void updateProfileData() async {
    if (formKey.currentState!.validate()) {
      emit(const UpdateProfileState.loading());

      executeApi(
        apiCall: () => _profileRepo.updateProfile({
          'name': nameController.text,
          'phone': phoneController.text,
        }),
        onSuccess: (userProfile) {
          emit(UpdateProfileState.success(userProfile));
        },
        onError: (error) {
          emit(UpdateProfileState.error(error));
        },
      );
    }
  }

  void initializeFields(String name, String phone) {
    nameController.text = name;
    phoneController.text = phone;
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
