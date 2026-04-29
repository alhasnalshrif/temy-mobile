import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/widgets/dialog_helper.dart';
import 'package:temy_barber/core/widgets/snackbar_helper.dart';
import 'package:temy_barber/features/auth/logic/forgot_password/forgot_password_cubit.dart';
import 'package:temy_barber/features/auth/logic/forgot_password/forgot_password_state.dart';

class ForgotPasswordBlocListener extends StatelessWidget {
  const ForgotPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        state.whenOrNull(
          loading: () => DialogHelper.showLoading(context),
          success: (response) {
            DialogHelper.dismissLoading(context);
            SnackbarHelper.showSuccess(context, 'auth.reset_code_sent'.tr());
            context.goNamed(
              AppRoutes.resetPasswordName,
              extra: context.read<ForgotPasswordCubit>().phoneController.text,
            );
          },
          error: (error) {
            DialogHelper.dismissLoading(context);
            SnackbarHelper.showError(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
