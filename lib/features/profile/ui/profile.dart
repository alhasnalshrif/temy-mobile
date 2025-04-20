import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/extensions.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/routing/routes.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/profile/data/models/profile_response.dart';
import 'package:temy_barber/features/profile/logic/profile_cubit.dart';
import 'package:temy_barber/features/profile/logic/profile_state.dart';
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

  @override
  void initState() {
    super.initState();
    _loadSavedLanguage();
  }

  Future<void> _loadSavedLanguage() async {
    final savedLanguage =
        await SharedPrefHelper.getString(SharedPrefKeys.language);
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
    final size = MediaQuery.of(context).size;

    // Setting status bar to black with white icons for profile screen
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header section with logo and title
            Padding(
              padding: const EdgeInsets.only(
                  top: 50, left: 20, right: 20, bottom: 20),
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
            // Profile info section
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Hero(
                        tag: 'profile-avatar',
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 35,
                            backgroundImage: avatarUrl != null
                                ? NetworkImage(avatarUrl!)
                                : const AssetImage('assets/images/temy.png')
                                    as ImageProvider,
                          ),
                        ),
                      ),
                      horizontalSpace(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: TextStyles.font24WhiteBold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              phoneNumber,
                              style: TextStyles.font16WhiteSemiBold.copyWith(
                                color: Colors.white.withOpacity(0.7),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            verticalSpace(20),
            // White container with profile options - now with Expanded and SingleChildScrollView
            Expanded(
              child: Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: SafeArea(
                  top: false,
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Notifications switch
                              Container(
                                margin: const EdgeInsets.only(bottom: 16),
                              
                                child: SwitchListTile(
                                  activeColor: ColorsManager.mainBlue,
                                  activeTrackColor:
                                      ColorsManager.mainBlue.withOpacity(0.2),
                                  trackOutlineColor: WidgetStateProperty.all(
                                      Colors.transparent),
                                  value: true,
                                  onChanged: (value) {},
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  title: Row(
                                    children: [
                                      const Icon(Icons.notifications_outlined,
                                          color: ColorsManager.mainBlue),
                                      horizontalSpace(12),
                                      Text(
                                        'profile.notifications'.tr(),
                                        style: TextStyles.font16DarkBold,
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Language selector
                              Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                // decoration: BoxDecoration(
                                //   borderRadius: BorderRadius.circular(12),
                                //   border:
                                //       Border.all(color: Colors.grey.shade200),
                                // ),
                                padding: const EdgeInsets.all(16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.language,
                                            color: ColorsManager.mainBlue),
                                        horizontalSpace(12),
                                        Text(
                                          'profile.language'.tr(),
                                          style: TextStyles.font16DarkBold,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 120,
                                      child: DropdownButtonFormField<String>(
                                        value: currentLanguage,
                                        isDense: true,
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 12, vertical: 8),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade300),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: const BorderSide(
                                                color: ColorsManager.mainBlue),
                                          ),
                                        ),
                                        items: [
                                          DropdownMenuItem(
                                            value: 'ar',
                                            child: Text(
                                              'profile.arabic'.tr(),
                                              style: TextStyles
                                                  .font14DarkBlueMedium,
                                            ),
                                          ),
                                          DropdownMenuItem(
                                            value: 'en',
                                            child: Text(
                                              'profile.english'.tr(),
                                              style: TextStyles
                                                  .font14DarkBlueMedium,
                                            ),
                                          ),
                                        ],
                                        onChanged: (value) {
                                          if (value != null) {
                                            _changeLanguage(value);
                                          }
                                        },
                                        dropdownColor: Colors.white,
                                        icon: const Icon(Icons.arrow_drop_down,
                                            color: ColorsManager.mainBlue),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Other profile options
                              _buildProfileTile(
                                'profile.edit_account'.tr(),
                                Icons.person_outline,
                                onTap: () {
                                  final state =
                                      context.read<ProfileCubit>().state;
                                  state.maybeMap(
                                    profileSuccess: (successState) {
                                      if (successState.userProfile.user !=
                                          null) {
                                        context.pushNamed(
                                            Routes.updateProfileScreen,
                                            arguments:
                                                successState.userProfile.user!);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text(
                                                  'profile.user_data_error'
                                                      .tr())),
                                        );
                                      }
                                    },
                                    orElse: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'profile.data_unavailable'
                                                    .tr())),
                                      );
                                    },
                                  );
                                },
                              ),
                              _buildProfileTile(
                                'profile.privacy'.tr(),
                                Icons.lock_outline,
                                onTap: () {},
                              ),
                              _buildProfileTile(
                                'profile.help'.tr(),
                                Icons.help_outline,
                                onTap: () {},
                              ),
                              _buildProfileTile(
                                'profile.about'.tr(),
                                Icons.info_outline,
                                onTap: () {},
                              ),

                              const Spacer(),

                              // Logout button
                              TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0.95, end: 1.0),
                                duration: const Duration(milliseconds: 300),
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          context.read<ProfileCubit>().logout();
                                          context.pushNamed(Routes.loginScreen);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ColorsManager.mainBlue,
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 16),
                                        ),
                                        child: Text(
                                          'logout'.tr(),
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
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(String title, IconData icon,
      {required VoidCallback onTap}) {
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
              title: Text(
                title,
                style: TextStyles.font16DarkBold,
              ),
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
