import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/routing/app_router_go.dart';
import 'package:temy_barber/core/widgets/dialog_helper.dart';
import 'package:temy_barber/features/auth/logic/sign_up_cubit.dart';
import '../../logic/sign_up_state.dart';

class SignupBlocListener extends StatelessWidget {
  const SignupBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupCubit, SignupState>(
      listenWhen: (previous, current) =>
          current is SignupLoading ||
          current is SignupSuccess ||
          current is SignupError,
      listener: (context, state) {
        state.whenOrNull(
          signupLoading: () {
            DialogHelper.showLoading(context);
          },
          signupSuccess: (signupResponse) {
            DialogHelper.dismissLoading(context);

            final isVerified = signupResponse.data?.user?.verified ?? false;

            if (isVerified) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.goNamed(AppRoutes.homeName);
                } else {
                  AppRouterGo.navigatorKey.currentState?.context.goNamed(
                    AppRoutes.homeName,
                  );
                }
              });
            } else {
              final phoneNumber = context
                  .read<SignupCubit>()
                  .phoneController
                  .text;

              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (context.mounted) {
                  context.goNamed(
                    AppRoutes.verificationName,
                    extra: {
                      'phoneNumber': phoneNumber,
                      'shouldAutoResend': false,
                      'comingFromLogin': false,
                    },
                  );
                }
              });
            }
          },
          signupError: (error) {
            DialogHelper.dismissLoading(context);
            DialogHelper.showError(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
