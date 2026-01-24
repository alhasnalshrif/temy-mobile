import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/profile/logic/profile_cubit.dart';
import 'package:temy_barber/features/profile/logic/profile_state.dart';

class ProfileDialogs {
  ProfileDialogs._();

  /// Show logout confirmation dialog
  static Future<bool> showLogoutDialog(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.white,
        key: UniqueKey(),
        title: Text('logout.confirm_title'.tr()),
        content: Text('logout.confirm_message'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text('default_booking.cancel'.tr()),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: ColorsManager.red),
            child: Text('logout.logout'.tr()),
          ),
        ],
      ),
    );

    return shouldLogout ?? false;
  }

  /// Show delete account warning dialog
  static Future<void> showDeleteAccountDialog(
    BuildContext context,
    ProfileCubit profileCubit,
    VoidCallback onDialogClosed,
  ) async {
    await showDialog(
      context: context,
      builder: (dialogContext) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              onDialogClosed();
            }
          },
          child: BlocProvider<ProfileCubit>.value(
            value: profileCubit,
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  const Icon(Icons.warning, color: ColorsManager.red, size: 28),
                  horizontalSpace(8),
                  Expanded(
                    child: Text(
                      'delete_account.warning_title'.tr(),
                      style: TextStyles.font18DarkBold.copyWith(
                        color: ColorsManager.red,
                      ),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'delete_account.warning_message'.tr(),
                      style: TextStyles.font14DarkBlueMedium,
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    onDialogClosed();
                    Navigator.of(dialogContext).pop();
                  },
                  child: Text(
                    'delete_account.cancel_button'.tr(),
                    style: TextStyles.font14BlueSemiBold,
                  ),
                ),
                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) async {
                    state.maybeMap(
                      deleteSuccess: (successState) {
                        onDialogClosed();
                        Navigator.of(dialogContext).pop();

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(successState.message),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // Perform logout after successful delete
                        context.read<ProfileCubit>().logout();

                        // Navigate to login screen
                        if (context.mounted) {
                          context.goNamed(AppRoutes.loginName);
                        }
                      },
                      deleteError: (errorState) {
                        onDialogClosed();
                        Navigator.of(dialogContext).pop();

                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              errorState.errorHandler.apiErrorModel.message ??
                                  'delete_account.delete_failed'.tr(),
                            ),
                            backgroundColor: ColorsManager.red,
                          ),
                        );
                      },
                      orElse: () {},
                    );
                  },
                  builder: (context, state) {
                    final isLoading = state.maybeMap(
                      deleteLoading: (_) => true,
                      orElse: () => false,
                    );

                    return ElevatedButton(
                      onPressed: !isLoading
                          ? () {
                              context.read<ProfileCubit>().deleteAccount(
                                dialogContext,
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorsManager.red,
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              'delete_account.confirm_button'.tr(),
                              style: TextStyles.font16WhiteSemiBold,
                            ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
