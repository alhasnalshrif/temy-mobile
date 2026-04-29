import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/widgets/dialog_helper.dart';
import 'package:temy_barber/core/widgets/snackbar_helper.dart';
import 'package:temy_barber/features/auth/logic/reset_password/reset_password_cubit.dart';
import 'package:temy_barber/features/auth/logic/reset_password/reset_password_state.dart';

class ResetPasswordBlocListener extends StatelessWidget {
  const ResetPasswordBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ResetPasswordCubit, ResetPasswordState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        state.whenOrNull(
          loading: () => DialogHelper.showLoading(context),
          success: (response) {
            DialogHelper.dismissLoading(context);
            SnackbarHelper.showSuccess(context, 'auth.password_reset_success'.tr());
            context.go(AppRoutes.Login);
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
