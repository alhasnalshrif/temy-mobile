import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/widgets/shimmer_loading.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/networking/dio_factory.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';
import 'package:temy_barber/features/auth/logic/verification_cubit.dart';
import 'package:temy_barber/features/auth/logic/verification_state.dart';

class VerificationBlocListener extends StatelessWidget {
  static bool _isDialogOpen = false;

  const VerificationBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<VerificationCubit, VerificationState>(
      listenWhen: (previous, current) => current.maybeWhen(
        loading: () => true,
        success: (_) => true,
        error: (_) => true,
        initial: () => previous is VerificationLoading,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            setupLoadingState(context);
          },
          initial: () {
            _dismissActiveDialog(context);
          },
          success: (verificationResponse) {
            _dismissActiveDialog(context);
            final cubit = context.read<VerificationCubit>();
            if (cubit.comingFromLogin) {
              _handleLoginVerificationSuccess(context, verificationResponse);
            } else {
           
              context.goNamed(AppRoutes.loginName);
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
    BuildContext context,
    verificationResponse,
  ) async {
    try {
      // Save token and user data
      final token = verificationResponse.token ?? '';
      final userId = verificationResponse.data?.user?.id ?? '';

      if (token.isNotEmpty && userId.isNotEmpty) {
        await _saveUserToken(token, userId);

        try {
          final notificationCubit = getIt<NotificationCubit>();
          await notificationCubit.setUserId(userId);
        } catch (e) {
          debugPrint('Could not access NotificationCubit: $e');
        }

        context.goNamed(AppRoutes.dashboardName);
      } else {
        // Somethin went wrong, show error
        setupErrorState(context, 'Verification completed but login failed');
      }
    } catch (e) {
      setupErrorState(context, 'Failed to complete login after verification');
    }
  }

  Future<void> _saveUserToken(String token, String id) async {
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, token);
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userId, id);
    DioFactory.setTokenIntoHeaderAfterLogin(token);
  }

  void setupErrorState(BuildContext context, String error) {
    _dismissActiveDialog(context);
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
              'verification.got_it'.tr(),
              style: TextStyles.font14BlueSemiBold,
            ),
          ),
        ],
      ),
    );
  }

  void setupLoadingState(BuildContext context) {
    if (_isDialogOpen) {
      return;
    }
    _isDialogOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) =>
          Center(child: ShimmerLoading.circular(size: 50)),
    ).whenComplete(() {
      _isDialogOpen = false;
    });
  }

  void _dismissActiveDialog(BuildContext context) {
    if (_isDialogOpen) {
      Navigator.of(context, rootNavigator: true).pop();
      _isDialogOpen = false;
    }
  }
}
