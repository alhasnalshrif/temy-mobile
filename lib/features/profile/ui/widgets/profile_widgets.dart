import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';

/// Profile header widget with logo
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('profile.title'.tr(), style: TextStyles.font18WhiteSemiBold),
          Image.asset(
            'assets/images/logo.png',
            height: 30,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

/// Profile user info widget
class ProfileInfo extends StatelessWidget {
  final String userName;
  final String phoneNumber;
  final String? avatarUrl;

  const ProfileInfo({
    super.key,
    required this.userName,
    required this.phoneNumber,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
  }
}

/// Language selector widget
class LanguageSelector extends StatelessWidget {
  final String currentLanguage;
  final Function(String) onLanguageChanged;

  const LanguageSelector({
    super.key,
    required this.currentLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Icon(Icons.language, color: ColorsManager.mainBlue),
              horizontalSpace(12),
              Text('profile.language'.tr(), style: TextStyles.font16DarkBold),
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
                    onLanguageChanged(value);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Standard profile menu tile widget
class ProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
}

/// Danger/warning profile menu tile widget
class DangerTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const DangerTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: ColorsManager.red.withOpacity(0.1),
            highlightColor: ColorsManager.red.withOpacity(0.05),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: ColorsManager.red.withOpacity(0.05),
              leading: Icon(icon, color: ColorsManager.red),
              title: Text(
                title,
                style: TextStyles.font16DarkBold.copyWith(
                  color: ColorsManager.red,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: ColorsManager.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Logout button widget
class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.95, end: 1.0),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.mainBlue,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'logout.logout'.tr(),
                style: TextStyles.font16WhiteSemiBold,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Guest screen widget (when user is not logged in)
class GuestScreen extends StatelessWidget {
  final VoidCallback onLoginPressed;

  const GuestScreen({super.key, required this.onLoginPressed});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isLargeScreen = size.width > 600;

    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(
            maxWidth: isLargeScreen ? 800 : double.infinity,
          ),
          width: double.infinity,
          color: Colors.white,
          child: SafeArea(
            child: Column(
              children: [
                const ProfileHeader(),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(isLargeScreen ? 48.0 : 24.0),
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
                            onPressed: onLoginPressed,
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
      ),
    );
  }
}

/// Loading screen widget
class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
}
