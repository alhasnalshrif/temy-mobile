import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/app_text_form_field.dart';
import 'package:temy_barber/features/profile/data/models/profile_response.dart';
import 'package:temy_barber/features/profile/logic/profile_cubit.dart';
import 'package:temy_barber/features/profile/logic/update_profile_cubit.dart';
import 'package:temy_barber/features/profile/logic/update_profile_state.dart';

class UpdateProfileScreen extends StatelessWidget {
  final User currentUser;
  const UpdateProfileScreen({super.key, required this.currentUser});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: ColorsManager.mainBlue,
        statusBarIconBrightness: Brightness.light,
      ),
    );
    return BlocProvider(
      create: (context) =>
          getIt<UpdateProfileCubit>()
            ..initializeFields(currentUser.name ?? '', currentUser.phone ?? ''),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'profile.update_profile_title'.tr(),
            style: TextStyles.font18WhiteBold,
          ),
          leading: const BackButton(color: Colors.white),
          backgroundColor: ColorsManager.mainBlue,
          centerTitle: isLargeScreen,
          // backgroundColor: Colors.white,
        ),
        body: Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isLargeScreen ? 600 : double.infinity,
            ),
            child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
              listener: (context, state) {
                state.whenOrNull(
                  success: (userProfile) {
                    context.read<ProfileCubit>().getProfile();
                    context.pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          userProfile.message ?? 'profile.update_success'.tr(),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  error: (errorHandler) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          errorHandler.apiErrorModel.message ??
                              'profile.update_error'.tr(),
                        ),
                        backgroundColor: ColorsManager.red,
                      ),
                    );
                  },
                );
              },
              builder: (context, state) {
                final cubit = context.read<UpdateProfileCubit>();
                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(isLargeScreen ? 32.0 : 16.0),
                    child: Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          verticalSpace(20),
                          AppTextFormField(
                            hintText: 'profile.name_label'.tr(),
                            controller: cubit.nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'profile.name_required'.tr();
                              }
                              return null;
                            },
                          ),
                          verticalSpace(16),
                          AppTextFormField(
                            hintText: 'profile.phone_label'.tr(),
                            controller: cubit.phoneController,
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'profile.phone_required'.tr();
                              }
                              // Add more specific phone validation if needed
                              return null;
                            },
                          ),
                          verticalSpace(30),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state is Loading
                                  ? null
                                  : () => cubit.updateProfileData(),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsManager.mainBlue,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: state is Loading
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'profile.save_changes'.tr(),
                                      style: TextStyles.font16WhiteSemiBold,
                                    ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
