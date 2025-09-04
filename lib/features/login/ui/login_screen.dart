import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/features/login/logic/cubit/login_cubit.dart';
import 'package:temy_barber/features/login/logic/cubit/login_state.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/extensions.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theme/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import '../../../core/routing/routes.dart';
import 'widgets/dont_have_account_text.dart';
import 'widgets/email_and_password.dart';
import 'widgets/terms_and_conditions_text.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false, // Prevent back navigation
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          // Exit the app when back button is pressed
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top gradient section with logo and welcome text
              const SizedBox(height: 60),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'auth.welcome_back'.tr(),
                      style: TextStyles.font28WhiteBold,
                    ),
                    verticalSpace(16),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              verticalSpace(20),
              // White bottom section with rounded corners
              Expanded(
                child: Container(
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  padding: const EdgeInsets.all(30),
                  child: _buildLoginForm(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpace(10),
          Text(
            'auth.enter_credentials'.tr(),
            style: TextStyles.font16WhiteSemiBold.copyWith(color: Colors.black),
          ),
          verticalSpace(24),
          const EmailAndPassword(),
          verticalSpace(24),
          GestureDetector(
            onTap: () {
              // TODO: Navigate to forgot password screen
            },
            child: Text(
              'auth.forgot_password'.tr(),
              style: TextStyles.font13BlueRegular,
            ),
          ),
          verticalSpace(40),
          AppTextButton(
            buttonText: 'auth.login_button'.tr(),
            textStyle: TextStyles.font16WhiteSemiBold,
            onPressed: () => validateThenDoLogin(context),
          ),
          const SizedBox(height: 16),
          const TermsAndConditionsText(),
          const SizedBox(height: 30),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.center,
            child: DontHaveAccountText(),
          ),
          // Using direct approach to avoid Provider issues with NotificationCubit
          BlocListener<LoginCubit, LoginState>(
            listenWhen: (previous, current) =>
                current is Loading || current is Success || current is Error,
            listener: (context, state) {
              state.whenOrNull(
                loading: () {
                  showDialog(
                    context: context,
                    builder: (context) =>
                        Center(child: ShimmerLoading.circular(size: 50)),
                  );
                },
                success: (loginResponse) {
                  Navigator.of(context).pop(); // Close loading dialog

                  // Set user ID for OneSignal directly from GetIt
                  final userId = loginResponse.data?.user?.id;
                  if (userId != null) {
                    try {
                      final notificationCubit = getIt<NotificationCubit>();
                      notificationCubit.setUserId(userId);
                    } catch (e) {
                      debugPrint('Could not access NotificationCubit: $e');
                    }
                  }

                  context.pushReplacementNamed(Routes.dashboardScreen);
                },
                error: (error) {
                  Navigator.of(context).pop(); // Close loading dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.white,

                      icon: const Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 32,
                      ),
                      content: Text(
                        error,
                        style: TextStyles.font15DarkBlueMedium,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'common.got_it'.tr(),
                            style: TextStyles.font14BlueSemiBold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  void validateThenDoLogin(BuildContext context) {
    if (context.read<LoginCubit>().formKey.currentState!.validate()) {
      context.read<LoginCubit>().emitLoginStates();
    }
  }
}
