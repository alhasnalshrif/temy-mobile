import 'package:flutter/material.dart';
import 'package:flutter_complete_project/core/helpers/spacing.dart';
import 'package:flutter_complete_project/core/theme/colors.dart';
import 'package:flutter_complete_project/core/theme/styles.dart';

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
            // Top section with profile picture and logo
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'الملف الشخصي',
                    style: TextStyles.font18WhiteMeduim,
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/profile.jpg'),
                  ),
                  horizontalSpace(10),
                  Text(
                    'abdo tarek',
                    style: TextStyles.font18WhiteMeduim,
                  ),
                ],
              ),
            ),
            verticalSpace(20),
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
                    SwitchListTile(
                      tileColor: Colors.grey[50],
                      activeColor: ColorsManager.mainBlue,
                      activeTrackColor: ColorsManager.mainBlue.withOpacity(0.2),
                      trackOutlineColor:
                          MaterialStateProperty.all(ColorsManager.mainBlue),
                      value: true,
                      onChanged: (value) {},
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Row(
                        children: [
                          Icon(Icons.notifications_outlined,
                              color: ColorsManager.mainBlue),
                          horizontalSpace(12),
                          Text(
                            'الإشعارات',
                            style: TextStyles.font16DarkBold,
                          ),
                        ],
                      ),
                    ),
                    verticalSpace(12),
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
                    // Logout button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.mainBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: Text(
                          'تسجيل الخروج',
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
    );
  }

  Widget _buildProfileTile(String title, IconData icon,
      {required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        tileColor: Colors.grey[50],
        leading: Icon(icon, color: ColorsManager.mainBlue),
        title: Text(
          title,
          style: TextStyles.font16DarkBold,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[600],
        ),
      ),
    );
  }
}
