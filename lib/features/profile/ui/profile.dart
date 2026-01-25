import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/routing/app_routes.dart';
import 'package:temy_barber/features/profile/logic/profile_cubit.dart';
import 'package:temy_barber/features/profile/logic/profile_state.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';
import 'package:temy_barber/features/profile/ui/helpers/profile_auth_helper.dart';
import 'package:temy_barber/features/profile/ui/helpers/profile_language_helper.dart';
import 'package:temy_barber/features/profile/ui/helpers/profile_dialogs.dart';
import 'package:temy_barber/features/profile/ui/widgets/profile_widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String currentLanguage = 'ar';
  late NotificationCubit notificationCubit;
  bool _isDeleteDialogShown = false;
  bool _isGuest = true;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    notificationCubit = getIt<NotificationCubit>();
    _initializeProfile();
  }

  /// Initialize profile by checking auth status and loading language
  Future<void> _initializeProfile() async {
    final isGuest = ProfileAuthHelper.isGuest();
    final savedLanguage = await ProfileLanguageHelper.loadSavedLanguage();

    setState(() {
      _isGuest = isGuest;
      currentLanguage = savedLanguage;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _isDeleteDialogShown = false;
    super.dispose();
  }

  /// Handle language change
  Future<void> _onLanguageChanged(String languageCode) async {
    await ProfileLanguageHelper.changeLanguage(context, languageCode);
    setState(() {
      currentLanguage = languageCode;
    });
  }

  /// Handle logout button press
  Future<void> _onLogoutPressed() async {
    final shouldLogout = await ProfileDialogs.showLogoutDialog(context);

    if (shouldLogout && mounted) {
      await context.read<ProfileCubit>().logout();
      if (mounted) {
        context.goNamed(AppRoutes.loginName);
      }
    }
  }

  /// Handle delete account button press
  void _onDeleteAccountPressed() {
    if (_isDeleteDialogShown) return;

    _isDeleteDialogShown = true;
    final profileCubit = context.read<ProfileCubit>();

    ProfileDialogs.showDeleteAccountDialog(context, profileCubit, () {
      if (mounted) {
        setState(() {
          _isDeleteDialogShown = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Set status bar styling
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    // Show loading screen while initializing
    if (_isLoading) {
      return const LoadingScreen();
    }

    // Show guest screen if user is not logged in
    if (_isGuest) {
      return GuestScreen(
        onLoginPressed: () => context.goNamed(AppRoutes.loginName),
      );
    }

    // Main profile screen for logged-in users
    return ResponsiveBuilder(
      mobile: _buildMobileLayout(size),
      desktop: _buildDesktopLayout(size),
    );
  }

  /// Build mobile layout
  Widget _buildMobileLayout(Size size) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ProfileHeader(),
              _buildProfileInfoSection(),
              verticalSpace(30),
              _buildProfileMenuSection(size),
            ],
          ),
        ),
      ),
    );
  }

  /// Build desktop layout
  Widget _buildDesktopLayout(Size size) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with dark background to match mobile look or custom for desktop
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const ProfileHeader(),
              ),
              verticalSpace(24),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left Panel: Profile Info
                    Expanded(
                      flex: 4,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildProfileInfoSection(isVertical: true),
                            verticalSpace(24),
                            Divider(color: Colors.white.withOpacity(0.1)),
                            verticalSpace(24),
                            LanguageSelector(
                              currentLanguage: currentLanguage,
                              onLanguageChanged: _onLanguageChanged,
                            ),
                          ],
                        ),
                      ),
                    ),
                    horizontalSpace(24),
                    // Right Panel: Actions Grid
                    Expanded(
                      flex: 8,
                      child: Container(
                        padding: const EdgeInsets.all(24),
                        // Removed white background and shadow for cleaner look with cards
                        child: _buildDesktopMenuGrid(),
                      ),
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

  /// Build profile info section with user data
  Widget _buildProfileInfoSection({bool isVertical = false}) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          current is ProfileLoading ||
          current is ProfileSuccess ||
          current is ProfileError,
      builder: (context, state) {
        String userName = 'User Name';
        String phoneNumber = 'Phone Number';
        String? avatarUrl;

        state.maybeMap(
          profileSuccess: (value) {
            final currentUser = value.userProfile.user;
            userName = currentUser?.name ?? 'User Name';
            phoneNumber = currentUser?.phone ?? 'Phone Number';
            avatarUrl = currentUser?.avatar;
          },
          orElse: () {},
        );

        return ProfileInfo(
          userName: userName,
          phoneNumber: phoneNumber,
          avatarUrl: avatarUrl,
          isVertical: isVertical,
        );
      },
    );
  }

  /// Build profile menu section for mobile
  Widget _buildProfileMenuSection(Size size) {
    return Container(
      width: size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LanguageSelector(
            currentLanguage: currentLanguage,
            onLanguageChanged: _onLanguageChanged,
          ),
          verticalSpace(10),
          _buildEditAccountTile(),
          ProfileTile(
            title: 'profile.privacy'.tr(),
            icon: Icons.lock_outline,
            onTap: () => context.goNamed(AppRoutes.privacyPolicyName),
          ),
          ProfileTile(
            title: 'profile.help'.tr(),
            icon: Icons.help_outline,
            onTap: () => context.goNamed(AppRoutes.helpName),
          ),
          ProfileTile(
            title: 'profile.about'.tr(),
            icon: Icons.info_outline,
            onTap: () => context.goNamed(AppRoutes.aboutName),
          ),
          DangerTile(
            title: 'profile.delete_account'.tr(),
            icon: Icons.delete_forever_outlined,
            onTap: _onDeleteAccountPressed,
          ),
          verticalSpace(20),
          LogoutButton(onPressed: _onLogoutPressed),
        ],
      ),
    );
  }

  /// Build profile menu grid for desktop
  Widget _buildDesktopMenuGrid() {
    return GridView.count(
      crossAxisCount: 3, // Increased column count for better card layout
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      childAspectRatio: 1.2, // Adjusted for card shape
      shrinkWrap: true,
      children: [
        _buildDesktopEditAccountCard(),
        DesktopProfileCard(
          title: 'profile.privacy'.tr(),
          icon: Icons.lock_outline,
          onTap: () => context.goNamed(AppRoutes.privacyPolicyName),
        ),
        DesktopProfileCard(
          title: 'profile.help'.tr(),
          icon: Icons.help_outline,
          onTap: () => context.goNamed(AppRoutes.helpName),
        ),
        DesktopProfileCard(
          title: 'profile.about'.tr(),
          icon: Icons.info_outline,
          onTap: () => context.goNamed(AppRoutes.aboutName),
        ),
        DesktopProfileCard(
          title: 'profile.delete_account'.tr(),
          icon: Icons.delete_forever_outlined,
          onTap: _onDeleteAccountPressed,
          isDanger: true,
        ),
        DesktopProfileCard(
          title: 'logout.logout'.tr(),
          icon: Icons.logout,
          onTap: _onLogoutPressed,
          isDanger: true,
        ),
      ],
    );
  }

  /// Build desktop edit account card
  Widget _buildDesktopEditAccountCard() {
    return DesktopProfileCard(
      title: 'profile.edit_account'.tr(),
      icon: Icons.person_outline,
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
              _showErrorSnackBar('profile.user_data_error'.tr());
            }
          },
          orElse: () {
            _showErrorSnackBar('profile.data_unavailable'.tr());
          },
        );
      },
    );
  }

  /// Build edit account tile with state handling
  Widget _buildEditAccountTile() {
    return ProfileTile(
      title: 'profile.edit_account'.tr(),
      icon: Icons.person_outline,
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
              _showErrorSnackBar('profile.user_data_error'.tr());
            }
          },
          orElse: () {
            _showErrorSnackBar('profile.data_unavailable'.tr());
          },
        );
      },
    );
  }

  /// Show error message to user
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
