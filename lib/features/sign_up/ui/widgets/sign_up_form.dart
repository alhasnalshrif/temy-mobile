import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/app_regex.dart';
import 'package:temy_barber/features/sign_up/logic/sign_up_cubit.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool isPasswordObscureText = true;
  bool isPasswordConfirmationObscureText = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    passwordController = context.read<SignupCubit>().passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<SignupCubit>().formKey,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'auth.signup.name'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              verticalSpace(8),
              AppTextFormField(
                hintText: 'auth.signup.name_placeholder'.tr(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'auth.signup.name_error'.tr();
                  }
                  return null;
                },
                controller: context.read<SignupCubit>().nameController,
              ),
            ],
          ),
          verticalSpace(18),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'auth.signup.phone'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              verticalSpace(8),
              AppTextFormField(
                hintText: 'auth.signup.phone_placeholder'.tr(),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isPhoneNumberValid(value)) {
                    return 'auth.signup.phone_error'.tr();
                  }
                  return null;
                },
                controller: context.read<SignupCubit>().phoneController,
              ),
            ],
          ),
          verticalSpace(18),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'auth.signup.password'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              verticalSpace(8),
              AppTextFormField(
                controller: context.read<SignupCubit>().passwordController,
                hintText: 'auth.signup.password_placeholder'.tr(),
                isObscureText: isPasswordObscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordObscureText = !isPasswordObscureText;
                    });
                  },
                  child: Icon(
                    isPasswordObscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'auth.signup.password_confirmation_error'.tr();
                  }
                  return null;
                },
              ),
            ],
          ),
          verticalSpace(18),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'auth.signup.password_confirmation'.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              verticalSpace(8),
              AppTextFormField(
                controller:
                    context.read<SignupCubit>().passwordConfirmationController,
                hintText: 'auth.signup.password_confirmation_placeholder'.tr(),
                isObscureText: isPasswordConfirmationObscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordConfirmationObscureText =
                          !isPasswordConfirmationObscureText;
                    });
                  },
                  child: Icon(
                    isPasswordConfirmationObscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'auth.signup.password_confirmation_error'.tr();
                  }
                  return null;
                },
              ),
            ],
          ),
          verticalSpace(24),
        ],
      ),
    );
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }
}
