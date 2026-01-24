import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/profile/data/models/profile_response.dart';
import 'package:temy_barber/features/profile/logic/profile_cubit.dart';
import 'package:temy_barber/features/profile/logic/profile_state.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String currentLanguage = 'ar';
  bool notificationsEnabled = true;
  late NotificationCubit notificationCubit;
  bool _isDeleteDialogShown = false;
  bool _isGuest = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    notificationCubit = getIt<NotificationCubit>();
    _checkLoginStatus();
    _loadSavedLanguage();
  }

  Future<void> _checkLoginStatus() async {
    final token = await SharedPrefHelper.getSecuredString(
      SharedPrefKeys.userToken,
    );
    setState(() {
      _isGuest = token.isEmpty;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    // Clean up any resources if needed and reset dialog flag
    _isDeleteDialogShown = false;
    super.dispose();
  }

  Future<void> _loadSavedLanguage() async {
    final savedLanguage = await SharedPrefHelper.getString(
      SharedPrefKeys.language,
    );
    if (savedLanguage.isNotEmpty) {
      setState(() {
        currentLanguage = savedLanguage;
      });
    }
  }

  Future<void> _changeLanguage(String languageCode) async {
    await SharedPrefHelper.setData(SharedPrefKeys.language, languageCode);
    await context.setLocale(Locale(languageCode));
    setState(() {
      currentLanguage = languageCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(
      context,
    ).size; // Setting status bar to black with white icons for profile screen
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    if (_isLoading) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.white,
          child: const Center(
            child: CircularProgressIndicator(color: ColorsManager.mainBlue),
          ),
        ),
      );
    }

    if (_isGuest) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.white,
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'profile.title'.tr(),
                        style: TextStyles.font18WhiteSemiBold,
                      ),
                      Image.asset(
                        'assets/images/logo.png',
                        height: 30,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock_outline,
                          size: 80,
                          color: ColorsManager.mainBlue.withOpacity(0.5),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'auth.login_required_title'.tr(),
                          style: TextStyles.font24BlackBold.copyWith(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'auth.login_required_message'.tr(),
                          style: TextStyles.font14GrayRegular.copyWith(
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              context.goNamed(AppRoutes.loginName);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.mainBlue,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'auth.login_button'.tr(),
                              style: TextStyles.font16WhiteSemiBold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: Colors.black,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'profile.title'.tr(),
                      style: TextStyles.font18WhiteSemiBold,
                    ),
                    verticalSpace(16),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 30,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              BlocBuilder<ProfileCubit, ProfileState>(
                buildWhen: (previous, current) =>
                    current is ProfileLoading ||
                    current is ProfileSuccess ||
                    current is ProfileError,
                builder: (context, state) {
                  String userName = 'User Name';
                  String phoneNumber = 'Phone Number';
                  String? avatarUrl;
                  User? currentUser;

                  state.maybeMap(
                    profileSuccess: (value) {
                      currentUser = value.userProfile.user;
                      userName = currentUser?.name ?? 'User Name';
                      phoneNumber = currentUser?.phone ?? 'Phone Number';
                      avatarUrl = currentUser?.avatar;
                    },
                    orElse: () {},
                  );

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        Hero(
                          tag: 'profile-avatar',
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 35,
                              backgroundImage: avatarUrl != null
                                  ? NetworkImage(avatarUrl!)
                                  : const AssetImage('assets/images/temy.png')
                                        as ImageProvider,
                              onBackgroundImageError: avatarUrl != null
                                  ? (exception, stackTrace) {
                                      // Handle network errors gracefully
                                    }
                                  : null,
                            ),
                          ),
                        ),
                        horizontalSpace(16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(userName, style: TextStyles.font24WhiteBold),
                            Text(
                              phoneNumber,
                              style: TextStyles.font16WhiteSemiBold.copyWith(
                                color: Colors.white.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              verticalSpace(30),
              Container(
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.language,
                                color: ColorsManager.mainBlue,
                              ),
                              horizontalSpace(12),
                              Text(
                                'profile.language'.tr(),
                                style: TextStyles.font16DarkBold,
                              ),
                            ],
                          ),
                          Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                borderRadius: BorderRadius.circular(8),
                                value: currentLanguage,
                                isExpanded: true,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: ColorsManager.mainBlue,
                                ),
                                dropdownColor: Colors.white,
                                items: [
                                  DropdownMenuItem(
                                    value: 'ar',
                                    child: Text(
                                      'profile.arabic'.tr(),
                                      style: TextStyles.font14DarkBlueMedium,
                                    ),
                                  ),
                                  DropdownMenuItem(
                                    value: 'en',
                                    child: Text(
                                      'profile.english'.tr(),
                                      style: TextStyles.font14DarkBlueMedium,
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    _changeLanguage(value);
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(10),
                    _buildProfileTile(
                      'profile.edit_account'.tr(),
                      Icons.person_outline,
                      onTap: () {
                        final state = context.read<ProfileCubit>().state;
                        state.maybeMap(
                          profileSuccess: (successState) {
                            if (successState.userProfile.user != null) {
                              context.goNamed(
                                AppRoutes.updateProfileName,
                                extra: successState.userProfile.user!,
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('profile.user_data_error'.tr()),
                                ),
                              );
                            }
                          },
                          orElse: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('profile.data_unavailable'.tr()),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    _buildProfileTile(
                      'profile.privacy'.tr(),
                      Icons.lock_outline,
                      onTap: () {
                        context.goNamed(AppRoutes.privacyPolicyName);
                      },
                    ),
                    _buildProfileTile(
                      'profile.help'.tr(),
                      Icons.help_outline,
                      onTap: () {
                        context.goNamed(AppRoutes.helpName);
                      },
                    ),
                    _buildProfileTile(
                      'profile.about'.tr(),
                      Icons.info_outline,
                      onTap: () {
                        context.goNamed(AppRoutes.aboutName);
                      },
                    ),
                    // Add delete account option
                    _buildDangerTile(
                      'profile.delete_account'.tr(),
                      Icons.delete_forever_outlined,
                      onTap: () {
                        _showDeleteAccountDialog(context);
                      },
                    ),
                    verticalSpace(20),
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.95, end: 1.0),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                // Show confirmation dialog
                                final shouldLogout = await showDialog<bool>(
                                  context: context,
                                  builder: (dialogContext) => AlertDialog(
                                    backgroundColor: Colors.white,

                                    key:
                                        UniqueKey(), // Add unique key to prevent GlobalKey conflicts
                                    title: Text('logout.confirm_title'.tr()),
                                    content: Text(
                                      'logout.confirm_message'.tr(),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        child: Text(
                                          'default_booking.cancel'.tr(),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(true),
                                        style: TextButton.styleFrom(
                                          foregroundColor: Colors.red,
                                        ),
                                        child: Text('logout.logout'.tr()),
                                      ),
                                    ],
                                  ),
                                );

                                if (shouldLogout == true) {
                                  await context.read<ProfileCubit>().logout();
                                  if (context.mounted) {
                                    context.goNamed(AppRoutes.loginName);
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsManager.mainBlue,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              child: Text(
                                'logout.logout'.tr(),
                                style: TextStyles.font16WhiteSemiBold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileTile(
    String title,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: ColorsManager.mainBlue.withOpacity(0.1),
            highlightColor: ColorsManager.mainBlue.withOpacity(0.05),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: Colors.white,
              leading: Icon(icon, color: ColorsManager.mainBlue),
              title: Text(title, style: TextStyles.font16DarkBold),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: ColorsManager.mainBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDangerTile(
    String title,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: Colors.red.withOpacity(0.1),
            highlightColor: Colors.red.withOpacity(0.05),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: Colors.red.withOpacity(0.05),
              leading: Icon(icon, color: Colors.red),
              title: Text(
                title,
                style: TextStyles.font16DarkBold.copyWith(color: Colors.red),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog(BuildContext context) {
    if (_isDeleteDialogShown) return; // Prevent multiple dialogs

    _isDeleteDialogShown = true;

    // Capture the ProfileCubit from the original context
    final ProfileCubit profileCubit = context.read<ProfileCubit>();

    void closeDialog() {
      if (mounted) {
        setState(() {
          _isDeleteDialogShown = false;
        });
      }
    }

    showDialog(
      context: context,
      builder: (dialogContext) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) {
              closeDialog();
            }
          },
          child: BlocProvider<ProfileCubit>.value(
            value: profileCubit,
            child: AlertDialog(
              backgroundColor: Colors.white,
              title: Row(
                children: [
                  const Icon(Icons.warning, color: Colors.red, size: 28),
                  horizontalSpace(8),
                  Expanded(
                    child: Text(
                      'delete_account.warning_title'.tr(),
                      style: TextStyles.font18DarkBold.copyWith(
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              content: SizedBox(
                width: double.maxFinite,
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
                    closeDialog();
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
                        closeDialog();
                        Navigator.of(dialogContext).pop(); // Close dialog

                        // Show success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(successState.message),
                            backgroundColor: Colors.green,
                          ),
                        );

                        // Perform logout after successful delete and wait to finish
                        context.read<ProfileCubit>().logout();

                        // Navigate to login screen
                        if (context.mounted) {
                          context.goNamed(AppRoutes.loginName);
                        }
                      },
                      deleteError: (errorState) {
                        closeDialog();
                        Navigator.of(dialogContext).pop(); // Close dialog

                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              errorState.errorHandler.apiErrorModel.message ??
                                  'delete_account.delete_failed'.tr(),
                            ),
                            backgroundColor: Colors.red,
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
                        backgroundColor: Colors.red,
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
