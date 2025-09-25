import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  void initState() {
    super.initState();
    // Move the initialization to initState and use a post-frame callback
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _initializeControllers();
      }
    });
  }

  void _initializeControllers() {
    try {
      final loginCubit = context.read<LoginCubit>();
      passwordController = loginCubit.passwordController;
      setupPasswordControllerListener();
      setState(() {
        _isInitialized = true;
      });
    } catch (e) {
      // If we can't access the cubit, try again in the next frame
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_isInitialized) {
          _initializeControllers();
        }
      });
    }
  }

  void setupPasswordControllerListener() {
    _passwordListener = () {
      if (mounted) {
        setState(() {
          hasMinLength = AppRegex.hasMinLength(passwordController.text);
        });
      }
    };
    passwordController.addListener(_passwordListener!);
  }

  @override
  Widget build(BuildContext context) {
    // Access the LoginCubit directly since it's provided by BlocProvider
    final loginCubit = context.read<LoginCubit>();

    return Form(
      key: loginCubit.formKey,
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
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isPhoneNumberValid(value)) {
                    return 'Please enter a valid phone number';
                  }
                },
                controller: loginCubit.emailController,
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
                controller: loginCubit.passwordController,
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
