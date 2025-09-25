import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/app_regex.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/login/logic/cubit/login_cubit.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;

  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  late TextEditingController passwordController;
  bool _isInitialized = false;
  VoidCallback? _passwordListener;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      passwordController = context.read<LoginCubit>().passwordController;
      setupPasswordControllerListener();
      _isInitialized = true;
    }
  }

  void setupPasswordControllerListener() {
    _passwordListener = () {
      setState(() {
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    };
    passwordController.addListener(_passwordListener!);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('رقم الهاتف', style: TextStyles.font14Blue2SemiBold),
              verticalSpace(8),
              AppTextFormField(
                hintText: '01012345678',
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isPhoneNumberValid(value)) {
                    return 'Please enter a valid phone number';
                  }
                },
                controller: context.read<LoginCubit>().emailController,
              ),
            ],
          ),
          verticalSpace(18),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('الرقم السري', style: TextStyles.font14Blue2SemiBold),
              verticalSpace(8),
              AppTextFormField(
                controller: context.read<LoginCubit>().passwordController,
                hintText: '*********',
                isObscureText: isObscureText,
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureText = !isObscureText;
                    });
                  },
                  child: Icon(
                    isObscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid password';
                  }
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
    // Remove the specific listener if it was added
    if (_isInitialized && _passwordListener != null) {
      passwordController.removeListener(_passwordListener!);
    }
    super.dispose();
  }
}
