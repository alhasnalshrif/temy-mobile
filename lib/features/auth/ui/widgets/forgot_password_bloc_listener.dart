import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
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
          loading: () {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  Center(child: ShimmerLoading.circular(size: 50)),
            );
          },
          success: (response) {
            // Close loading dialog
            context.pop();

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('auth.reset_code_sent'.tr()),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate to reset password screen
            context.goNamed(
              AppRoutes.resetPasswordName,
              extra: context.read<ForgotPasswordCubit>().phoneController.text,
            );
          },
          error: (error) {
            // Close loading dialog
            context.pop();

            // Show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error),
                backgroundColor: ColorsManager.red,
              ),
            );
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }
}
