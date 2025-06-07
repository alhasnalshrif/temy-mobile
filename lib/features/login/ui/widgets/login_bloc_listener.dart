import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/features/login/logic/cubit/login_cubit.dart';
import 'package:temy_barber/features/login/logic/cubit/login_state.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart'; // Import shimmer
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theme/styles.dart';

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
            context.pop();

            // Set user ID for OneSignal after successful login
            final userId = loginResponse.data?.user?.id;
            if (userId != null) {
              final notificationCubit = context.read<NotificationCubit>();
              notificationCubit.setUserId(userId);
            }

            context.pushReplacementNamed(Routes.dashboardScreen);
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
      builder: (context) => Center(
        // Replace CircularProgressIndicator with ShimmerLoading
        child: ShimmerLoading.circular(
          size: 50,
        ), // Example shimmer
      ),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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
              context.pop();
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
