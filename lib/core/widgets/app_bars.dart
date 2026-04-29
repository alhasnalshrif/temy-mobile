import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';

/// Standard app bar with back button.
class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;
  final double elevation;

  const AppAppBar({
    super.key,
    this.title,
    this.actions,
    this.onBackPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle = true,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null ? Text(title!, style: TextStyles.font16DarkBold) : null,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? Colors.white,
      foregroundColor: foregroundColor ?? ColorsManager.black,
      leading: onBackPressed != null
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: onBackPressed,
            )
          : null,
      elevation: elevation,
      shadowColor: Colors.transparent,
      actions: actions,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Blue app bar for primary screens (home, booking, etc.).
class AppBlueAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool automaticallyImplyLeading;

  const AppBlueAppBar({
    super.key,
    this.title,
    this.actions,
    this.onBackPressed,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            )
          : null,
      centerTitle: true,
      backgroundColor: ColorsManager.mainBlue,
      elevation: 0,
      foregroundColor: Colors.white,
      automaticallyImplyLeading: automaticallyImplyLeading,
      leading: automaticallyImplyLeading
          ? (onBackPressed != null
              ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  onPressed: onBackPressed,
                )
              : null)
          : null,
      actions: actions,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorsManager.mainBlue,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

/// Profile header with logo (for profile screens).
class ProfileHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onLogoTap;

  const ProfileHeader({
    super.key,
    this.title = 'profile.title',
    this.onLogoTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title.tr(), style: TextStyles.font18WhiteSemiBold),
          GestureDetector(
            onTap: onLogoTap,
            child: Image.asset(
              'assets/images/logo.png',
              height: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
