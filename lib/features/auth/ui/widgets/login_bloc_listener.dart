import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/routing/app_router_go.dart';
import 'package:temy_barber/core/widgets/dialog_helper.dart';
import 'package:temy_barber/features/auth/logic/cubit/login_cubit.dart';
import 'package:temy_barber/features/auth/logic/cubit/login_state.dart';

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
            DialogHelper.showLoading(context);
          },
          success: (loginResponse) {
            DialogHelper.dismissLoading(context);

            final user = loginResponse.data?.user;
            final isVerified = user?.verified ?? false;

            debugPrint('Login successful. User verified: $isVerified');

            if (!isVerified) {
              final phoneNumber = user?.phone ?? '';
              final countryCode = user?.countryCode ?? '';
              final fullPhone = '$countryCode$phoneNumber';

              debugPrint(
                'User not verified. Navigating to verification screen with phone: $fullPhone',
              );

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.goNamed(
                    AppRoutes.verificationName,
                    extra: {
                      'phoneNumber': fullPhone,
                      'shouldAutoResend': false,
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
            DialogHelper.dismissLoading(context);
            DialogHelper.showError(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
