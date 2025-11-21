import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/profile/data/repos/profile_repo.dart';
import 'package:temy_barber/features/profile/logic/update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final ProfileRepo _profileRepo;
  UpdateProfileCubit(this._profileRepo)
      : super(const UpdateProfileState.initial());

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void updateProfileData() async {
    if (formKey.currentState!.validate()) {
      emit(const UpdateProfileState.loading());
      final response = await _profileRepo.updateProfile({
        'name': nameController.text,
        'phone': phoneController.text,
      });
      response.when(
        success: (userProfile) {
          emit(UpdateProfileState.success(userProfile));
        },
        failure: (error) {
          emit(UpdateProfileState.error(error));
        },
      );
    }
  }

  // Method to initialize controllers with current data
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
