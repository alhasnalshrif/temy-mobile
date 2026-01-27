import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';

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
  final bool isVertical;

  const ProfileInfo({
    super.key,
    required this.userName,
    required this.phoneNumber,
    this.avatarUrl,
    this.isVertical = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: isVertical
          ? Column(
              children: [
                _buildAvatar(),
                verticalSpace(16),
                _buildInfoText(center: true),
              ],
            )
          : Row(
              children: [_buildAvatar(), horizontalSpace(16), _buildInfoText()],
            ),
    );
  }

  Widget _buildAvatar() {
    return Hero(
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
              : const AssetImage('assets/images/temy.png') as ImageProvider,
          onBackgroundImageError: avatarUrl != null
              ? (exception, stackTrace) {
                  // Handle network errors gracefully
                }
              : null,
        ),
      ),
    );
  }

  Widget _buildInfoText({bool center = false}) {
    return Column(
      crossAxisAlignment: center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(userName, style: TextStyles.font24WhiteBold),
        Text(
          phoneNumber,
          style: TextStyles.font16WhiteSemiBold.copyWith(
            color: Colors.white.withAlpha(179),
          ),
        ),
      ],
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
              Icon(
                Icons.language,
                color: ResponsiveUtils.isTablet(context)
                    ? ColorsManager.mainBlue
                    : Colors.white,
              ),
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
            splashColor: ColorsManager.mainBlue.withAlpha(25),
            highlightColor: ColorsManager.mainBlue.withAlpha(13),
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
            splashColor: ColorsManager.red.withAlpha(25),
            highlightColor: ColorsManager.red.withAlpha(13),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              tileColor: ColorsManager.red.withAlpha(13),
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
                          color: ColorsManager.mainBlue.withAlpha(128),
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

/// Desktop specific profile card with hover effect
class DesktopProfileCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isDanger;

  const DesktopProfileCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isDanger = false,
  });

  @override
  State<DesktopProfileCard> createState() => _DesktopProfileCardState();
}

class _DesktopProfileCardState extends State<DesktopProfileCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.isDanger
                    ? ColorsManager.red.withAlpha(_isHovered ? 51 : 13)
                    : Colors.black.withAlpha(_isHovered ? 26 : 13),
                blurRadius: _isHovered ? 20 : 10,
                offset: Offset(0, _isHovered ? 8 : 4),
              ),
            ],
            border: Border.all(
              color: widget.isDanger
                  ? ColorsManager.red.withAlpha(25)
                  : Colors.transparent,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: widget.isDanger
                      ? ColorsManager.red.withAlpha(25)
                      : ColorsManager.mainBlue.withAlpha(25),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.icon,
                  size: 32,
                  color: widget.isDanger
                      ? ColorsManager.red
                      : ColorsManager.mainBlue,
                ),
              ),
              verticalSpace(16),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: widget.isDanger
                    ? TextStyles.font16DarkBold.copyWith(
                        color: ColorsManager.red,
                      )
                    : TextStyles.font16DarkBold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
