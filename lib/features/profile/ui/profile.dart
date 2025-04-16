import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/features/profile/logic/profile_cubit.dart';
import 'package:temy_barber/features/profile/logic/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
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
                    'الملف الشخصي',
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
            // Enhanced profile section with better spacing and alignment
            BlocBuilder<ProfileCubit, ProfileState>(
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
                    userName = value.userProfile.user?.name ?? 'User Name';
                    phoneNumber =
                        value.userProfile.user?.phone ?? 'Phone Number';
                    avatarUrl = value.userProfile.user?.avatar;
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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            userName,
                            style: TextStyles.font24WhiteBold,
                          ),
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
            // White bottom section with rounded corners
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Enhanced notification switch with better styling
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: SwitchListTile(
                        activeColor: ColorsManager.mainBlue,
                        activeTrackColor:
                            ColorsManager.mainBlue.withOpacity(0.2),
                        trackOutlineColor:
                            WidgetStateProperty.all(ColorsManager.mainBlue),
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
                              'الإشعارات',
                              style: TextStyles.font16DarkBold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildProfileTile(
                      'تعديل الحساب',
                      Icons.person_outline,
                      onTap: () {},
                    ),
                    _buildProfileTile(
                      'الخصوصية',
                      Icons.lock_outline,
                      onTap: () {},
                    ),
                    _buildProfileTile(
                      'المساعدة',
                      Icons.help_outline,
                      onTap: () {},
                    ),
                    _buildProfileTile(
                      'عنا',
                      Icons.info_outline,
                      onTap: () {},
                    ),
                    const Spacer(),
                    // Enhanced logout button with subtle animation
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.95, end: 1.0),
                      duration: const Duration(milliseconds: 300),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsManager.mainBlue,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: Text(
                                'تسجيل الخروج',
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
