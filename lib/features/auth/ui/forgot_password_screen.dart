import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/app_regex.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/app_text_button.dart';
import 'package:temy_barber/core/widgets/app_text_form_field.dart';
import 'package:temy_barber/features/auth/logic/forgot_password/forgot_password_cubit.dart';
import 'package:temy_barber/features/auth/ui/widgets/forgot_password_bloc_listener.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('auth.forgot_password'.tr(), style: TextStyles.font18WhiteBold),
        backgroundColor: ColorsManager.mainBlue,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Icon(
                  Icons.lock_reset,
                  size: 80,
                  color: ColorsManager.mainBlue,
                ),
                verticalSpace(24),
                Text(
                  'auth.forgot_password_title'.tr(),
                  style: TextStyles.font26BlueBold,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(12),
                Text(
                  'auth.forgot_password_subtitle'.tr(),
                  style: TextStyles.font16GrayRegular,
                  textAlign: TextAlign.center,
                ),
                verticalSpace(36),
                _buildForgotPasswordForm(context),
                const ForgotPasswordBlocListener(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordForm(BuildContext context) {
    return Form(
      key: context.read<ForgotPasswordCubit>().formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'auth.phone_number'.tr(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Theme.of(context).primaryColor,
            ),
          ),
          verticalSpace(12),
          AppTextFormField(
            hintText: 'auth.enter_phone_number'.tr(),
            keyboardType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            controller: context.read<ForgotPasswordCubit>().phoneController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'auth.phone_required'.tr();
              }
              if (!AppRegex.isPhoneNumberValid(value)) {
                return 'auth.phone_invalid'.tr();
              }
              return null;
            },
          ),
          verticalSpace(40),
          AppTextButton(
            buttonText: 'auth.send_reset_code'.tr(),
            textStyle: TextStyles.font16WhiteSemiBold,
            onPressed: () {
              validateThenRequestReset(context);
            },
          ),
        ],
      ),
    );
  }

  void validateThenRequestReset(BuildContext context) {
    if (context.read<ForgotPasswordCubit>().formKey.currentState!.validate()) {
      context.read<ForgotPasswordCubit>().requestPasswordReset();
    }
  }
}