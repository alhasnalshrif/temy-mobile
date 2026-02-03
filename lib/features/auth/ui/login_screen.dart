import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/features/auth/logic/cubit/login_cubit.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';

import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';

import '../../../core/helpers/spacing.dart';
import '../../../core/theme/styles.dart';
import '../../../core/widgets/app_text_button.dart';
import 'widgets/dont_have_account_text.dart';
import 'widgets/email_and_password.dart';
import 'widgets/terms_and_conditions_text.dart';
import 'widgets/login_bloc_listener.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Stack(
          children: [
            ResponsiveBuilder(
              mobile: _buildMobileLayout(context),
              tablet: _buildTabletLayout(context),
              desktop: _buildDesktopLayout(context),
            ),
            const LoginBlocListener(),
          ],
        ),
      ),
    );
  }

  /// Mobile layout: Vertical stack with header on top, form below.
  Widget _buildMobileLayout(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      color: Colors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
    );
  }

  /// Tablet layout: Two-column layout.
  Widget _buildTabletLayout(BuildContext context) {
    return Row(
      children: [
        // Left side: Branding
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 120,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'auth.welcome_back'.tr(),
                    style: TextStyles.font28WhiteBold,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
        // Right side: Form
        Expanded(
          flex: 3,
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 32),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: _buildLoginForm(context),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Desktop layout: Similar to tablet but with more spacing.
  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      children: [
        // Left side: Branding with larger logo
        Expanded(
          child: Container(
            color: Colors.black,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 160,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'auth.welcome_back'.tr(),
                    style: TextStyles.font28WhiteBold.copyWith(fontSize: 36),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text('Temy Barber', style: TextStyles.font16WhiteSemiBold),
                ],
              ),
            ),
          ),
        ),
        // Right side: Form with constrained width
        Expanded(
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 48),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 450),
                child: _buildLoginForm(context),
              ),
            ),
          ),
        ),
      ],
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
          verticalSpace(16),
          const EmailAndPassword(),
          GestureDetector(
            onTap: () {
              context.pushGoNamed(AppRoutes.forgotPasswordName);
            },
            child: Text(
              'auth.forgot_password'.tr(),
              style: TextStyles.font13BlueRegular,
            ),
          ),
          verticalSpace(16),
          AppTextButton(
            buttonText: 'auth.login_button'.tr(),
            textStyle: TextStyles.font16WhiteSemiBold,
            onPressed: () => validateThenDoLogin(context),
          ),
          verticalSpace(16),
          const TermsAndConditionsText(),
          verticalSpace(16),
          const Align(child: DontHaveAccountText()),
          verticalSpace(16),
          Center(
            child: TextButton(
              onPressed: () {
                context.goNamed(AppRoutes.homeName);
              },
              child: Text(
                'auth.continue_as_guest'.tr(),
                style: TextStyles.font16DarkBold,
              ),
            ),
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
