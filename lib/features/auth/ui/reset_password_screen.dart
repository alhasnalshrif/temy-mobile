import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/app_regex.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/app_text_button.dart';
import 'package:temy_barber/core/widgets/app_text_form_field.dart';
import 'package:temy_barber/features/auth/logic/reset_password/reset_password_cubit.dart';
import 'package:temy_barber/features/auth/ui/widgets/reset_password_bloc_listener.dart';
import 'package:flutter/services.dart';

class ResetPasswordScreen extends StatelessWidget {
  final String phoneNumber;

  const ResetPasswordScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'auth.reset_password'.tr(),
          style: TextStyles.font18WhiteBold,
        ),
        backgroundColor: ColorsManager.mainBlue,
        centerTitle: true,
        
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.lock_open,
                  size: 80,
                  color: ColorsManager.mainBlue,
                ),
                verticalSpace(24),
                Text(
                  'auth.reset_password_title'.tr(),
                  style: TextStyles.font26BlueBold,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(12),
                Text(
                  'auth.reset_password_subtitle'.tr(),
                  style: TextStyles.font16GrayRegular,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(36),
                _buildResetPasswordForm(context),
                const ResetPasswordBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordForm(BuildContext context) {
    // Set the phone number in the cubit
    context.read<ResetPasswordCubit>().setPhoneNumber(phoneNumber);

    return Form(
      key: context.read<ResetPasswordCubit>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'auth.verification_code'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
          verticalSpace(12),
          AppTextFormField(
            hintText: 'auth.enter_verification_code'.tr(),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            controller: context.read<ResetPasswordCubit>().codeController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'auth.code_required'.tr();
              }
              return null;
            },
          ),
          verticalSpace(24),
          Text(
            'auth.new_password'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
          verticalSpace(12),
          AppTextFormField(
            hintText: 'auth.enter_new_password'.tr(),
            controller: context.read<ResetPasswordCubit>().passwordController,
            isObscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'auth.password_required'.tr();
              }
              if (!AppRegex.hasMinLength(value)) {
                return 'auth.password_min_length'.tr();
              }
              return null;
            },
          ),
          verticalSpace(24),
          Text(
            'auth.confirm_password'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
          verticalSpace(12),
          AppTextFormField(
            hintText: 'auth.confirm_new_password'.tr(),
            controller: context
                .read<ResetPasswordCubit>()
                .confirmPasswordController,
            isObscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'auth.confirm_password_required'.tr();
              }
              if (value !=
                  context.read<ResetPasswordCubit>().passwordController.text) {
                return 'auth.passwords_do_not_match'.tr();
              }
              return null;
            },
          ),
          verticalSpace(40),
          AppTextButton(
            buttonText: 'auth.reset_password_button'.tr(),
            textStyle: TextStyles.font16WhiteSemiBold,
            onPressed: () {
              validateThenResetPassword(context);
            },
          ),
        ],
      ),
    );
  }

  void validateThenResetPassword(BuildContext context) {
    if (context.read<ResetPasswordCubit>().formKey.currentState!.validate()) {
      context.read<ResetPasswordCubit>().resetPassword();
    }
  }
}
