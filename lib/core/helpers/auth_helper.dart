import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/helpers/extensions.dart';

/// Authentication state for the current user.
class AuthState {
  final bool isGuest;
  final bool isLoading;
  final String? token;

  const AuthState({
    this.isGuest = true,
    this.isLoading = false,
    this.token,
  });

  AuthState copyWith({bool? isGuest, bool? isLoading, String? token}) {
    return AuthState(
      isGuest: isGuest ?? this.isGuest,
      isLoading: isLoading ?? this.isLoading,
      token: token ?? this.token,
    );
  }
}

/// Mixin for checking authentication status in widgets.
mixin AuthCheckMixin<T extends StatefulWidget> on State<T> {
  AuthState _authState = const AuthState(isLoading: true);

  AuthState get authState => _authState;

  @override
  void initState() {
    super.initState();
    checkAuthStatus();
  }

  /// Check if user is logged in or guest.
  Future<void> checkAuthStatus() async {
    final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    if (mounted) {
      setState(() {
        _authState = AuthState(
          isGuest: token.isEmpty,
          isLoading: false,
          token: token,
        );
      });
    }
  }

  /// Navigate to login if guest.
  void navigateIfGuest(BuildContext context) {
    if (_authState.isGuest) {
      context.goNamed(AppRoutes.loginName);
    }
  }

  /// Show guest required dialog.
  void showGuestRequiredDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const GuestRequiredDialog(),
    );
  }
}

/// Dialog shown when user needs to login.
class GuestRequiredDialog extends StatelessWidget {
  const GuestRequiredDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      icon: Icon(
        Icons.lock_outline,
        size: 48,
        color: ColorsManager.mainBlue.withAlpha(128),
      ),
      title: Text(
        'auth.login_required_title'.tr(),
        textAlign: TextAlign.center,
        style: TextStyles.font24BlackBold,
      ),
      content: Text(
        'auth.login_required_message'.tr(),
        textAlign: TextAlign.center,
        style: TextStyles.font14GrayRegular,
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.goNamed(AppRoutes.loginName);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.mainBlue,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('auth.login_button'.tr(), style: TextStyles.font16WhiteSemiBold),
          ),
        ),
      ],
    );
  }
}

/// Widget that shows guest login screen when user is not authenticated.
class GuestLoginScreen extends StatelessWidget {
  final String? title;
  final VoidCallback? onLoginPressed;

  const GuestLoginScreen({
    super.key,
    this.title,
    this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;

    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: isLargeScreen ? 800 : double.infinity),
          width: double.infinity,
          color: Colors.white,
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(isLargeScreen ? 48.0 : 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    size: 80,
                    color: ColorsManager.mainBlue.withAlpha(128),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'auth.login_required_title'.tr(),
                    style: TextStyles.font24BlackBold.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'auth.login_required_message'.tr(),
                    style: TextStyles.font14GrayRegular.copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onLoginPressed ?? () => context.goNamed(AppRoutes.loginName),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.mainBlue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text('auth.login_button'.tr(), style: TextStyles.font16WhiteSemiBold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Future-based auth check helper for non-widget contexts.
class AuthHelper {
  /// Check if current user is guest.
  static Future<bool> isGuest() async {
    final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    return token.isEmpty;
  }

  /// Get user token.
  static Future<String> getToken() async {
    return await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  }

  /// Check if user is authenticated.
  static Future<bool> isAuthenticated() async {
    final token = await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
    return token.isNotEmpty;
  }
}
