import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/auth/logic/cubit/login_cubit.dart';
import 'package:temy_barber/features/auth/logic/cubit/login_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import '../../../../core/theme/styles.dart';

import 'package:temy_barber/core/routing/app_router_go.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is Loading || current is Success || current is Error,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            setupLoadingState(context);
          },
          success: (loginResponse) {
            Navigator.of(context, rootNavigator: true).pop();

            // Check if user is verified
            final user = loginResponse.data?.user;
            final isVerified = user?.verified ?? false;

            debugPrint('Login successful. User verified: $isVerified');

            if (!isVerified) {
              // User is not verified, navigate to verification screen
              final phoneNumber = user?.phone ?? '';
              final countryCode = user?.countryCode ?? '';
              final fullPhone = '$countryCode$phoneNumber';

              debugPrint(
                'User not verified. Navigating to verification screen with phone: $fullPhone',
              );

              // Navigate after the current frame to avoid build scope errors
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.goNamed(
                    AppRoutes.verificationName,
                    extra: {
                      'phoneNumber': fullPhone,
                      'shouldAutoResend': true,
                      'comingFromLogin': true,
                    },
                  );
                }
              });
              return;
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (context.mounted) {
                context.goNamed(AppRoutes.homeName);
              } else {
                AppRouterGo.navigatorKey.currentState?.context.goNamed(
                  AppRoutes.homeName,
                );
              }
            });
          },
          error: (error) {
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupLoadingState(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) =>
          const Center(child: CircularProgressIndicator(color: Colors.white)),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    Navigator.of(context, rootNavigator: true).pop(); // Close loading dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.error, color: ColorsManager.red, size: 32),
        content: Text(error, style: TextStyles.font15DarkBlueMedium),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              'common.got_it'.tr(),
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }
}
