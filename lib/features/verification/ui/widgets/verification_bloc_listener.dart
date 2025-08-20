import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/networking/dio_factory.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';
import 'package:temy_barber/features/verification/logic/verification_cubit.dart';
import 'package:temy_barber/features/verification/logic/verification_state.dart';

class VerificationBlocListener extends StatelessWidget {
  const VerificationBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationCubit, VerificationState>(
      listenWhen: (previous, current) =>
          current is VerificationLoading ||
          current is VerificationSuccess ||
          current is VerificationError,
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            setupLoadingState(context);
          },
          success: (verificationResponse) {
            context.pop();

            // Check if user came from login
            final cubit = context.read<VerificationCubit>();
            if (cubit.comingFromLogin) {
              // User came from login, save token and navigate to dashboard
              _handleLoginVerificationSuccess(context, verificationResponse);
            } else {
              // User came from signup, show success dialog and navigate to login
              showSuccessDialog(context);
            }
          },
          error: (error) {
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void _handleLoginVerificationSuccess(
      BuildContext context, verificationResponse) async {
    try {
      // Save token and user data
      final token = verificationResponse.token ?? '';
      final userId = verificationResponse.data?.user?.id ?? '';

      if (token.isNotEmpty && userId.isNotEmpty) {
        await _saveUserToken(token, userId);

        // Set user ID for OneSignal
        try {
          final notificationCubit = getIt<NotificationCubit>();
          await notificationCubit.setUserId(userId);
        } catch (e) {
          debugPrint('Could not access NotificationCubit: $e');
        }

        // Navigate to dashboard
        context.pushReplacementNamed(Routes.dashboardScreen);
      } else {
        // Something went wrong, show error
        setupErrorState(context, 'Verification completed but login failed');
      }
    } catch (e) {
      setupErrorState(context, 'Failed to complete login after verification');
    }
  }

  Future<void> _saveUserToken(String token, String id) async {
    // Save token to shared preferences
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userId, id);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('verification.success_title'.tr()),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('verification.success_message'.tr()),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: ColorsManager.mainBlue,
                disabledForegroundColor: Colors.grey.withOpacity(0.38),
              ),
              onPressed: () {
                context.pushReplacementNamed(Routes.loginScreen);
              },
              child: Text('verification.continue_to_login'.tr()),
            ),
          ],
        );
      },
    );
  }

  void setupErrorState(BuildContext context, String error) {
    context.pop();
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
              context.pop();
            },
            child: Text(
              'verification.got_it'.tr(),
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }

  void setupLoadingState(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Center(
        child: ShimmerLoading.circular(size: 50),
      ),
    );
  }
}
