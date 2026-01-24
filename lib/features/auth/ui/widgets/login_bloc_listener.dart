import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/features/auth/logic/cubit/login_cubit.dart';
import 'package:temy_barber/features/auth/logic/cubit/login_state.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart'; // Import shimmer
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
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

            // Set user ID for OneSignal after successful login
            final userId = loginResponse.data?.user?.id;
            if (userId != null) {
              // Get NotificationCubit directly from GetIt instead of from context
              try {
                final notificationCubit = getIt<NotificationCubit>();
                notificationCubit.setUserId(userId);
              } catch (e) {
                debugPrint('Could not access NotificationCubit: $e');
              }
            }

            context.goNamed(AppRoutes.dashboardName);
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
        child: ShimmerLoading.circular(size: 50), // Example shimmer
      ),
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        icon: const Icon(Icons.error, color: ColorsManager.red, size: 32),
        content: Text(error, style: TextStyles.font15DarkBlueMedium),
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
