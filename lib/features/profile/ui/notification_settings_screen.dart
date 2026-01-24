import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/utils/responsive_utils.dart';
import 'package:temy_barber/features/profile/logic/notification_cubit.dart';
import 'package:easy_localization/easy_localization.dart';

class NotificationSettingsScreen extends StatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  State<NotificationSettingsScreen> createState() =>
      _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState
    extends State<NotificationSettingsScreen> {
  late NotificationCubit notificationCubit;

  bool pushNotifications = true;
  bool bookingReminders = true;
  bool promotionalNotifications = true;

  @override
  void initState() {
    super.initState();
    notificationCubit = getIt<NotificationCubit>();
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = ResponsiveUtils.isLargeScreen(context);
    final isDesktop = ResponsiveUtils.isDesktop(context);

    return Scaffold(
      backgroundColor: isLargeScreen ? Colors.grey[50] : Colors.white,
      appBar: AppBar(
        title: Text(
          'notifications.settings'.tr(),
          style: TextStyles.font18DarkBold,
        ),
        backgroundColor: Colors.white,
        elevation: isLargeScreen ? 0 : 0.5,
        centerTitle: isLargeScreen,
        iconTheme: const IconThemeData(color: ColorsManager.mainBlue),
        actions: [
          BlocBuilder<NotificationCubit, NotificationState>(
            bloc: notificationCubit,
            builder: (context, state) {
              final isLoading = state.runtimeType.toString().contains('Loading');
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  onPressed: isLoading ? null : _saveSettings,
                  style: TextButton.styleFrom(
                    backgroundColor: isLargeScreen && !isLoading
                        ? ColorsManager.mainBlue.withOpacity(0.1)
                        : null,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'common.save'.tr(),
                    style: TextStyles.font16DarkBold.copyWith(
                      color: isLoading ? Colors.grey : ColorsManager.mainBlue,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocListener<NotificationCubit, NotificationState>(
        bloc: notificationCubit,
        listener: (context, state) {
          if (state.runtimeType.toString().contains('SettingsLoaded')) {
            final settingsState = state as dynamic;
            setState(() {
              pushNotifications = settingsState.settings.pushNotifications;
              bookingReminders = settingsState.settings.bookingReminders;
              promotionalNotifications =
                  settingsState.settings.promotionalNotifications;
            });
          } else if (state.runtimeType.toString().contains('SettingsUpdated')) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('notifications.settings_saved'.tr()),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                width: isLargeScreen ? 400 : null,
              ),
            );
          } else if (state.runtimeType.toString().contains('Error')) {
            final errorState = state as dynamic;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorState.message),
                backgroundColor: ColorsManager.red,
                behavior: SnackBarBehavior.floating,
                width: isLargeScreen ? 400 : null,
              ),
            );
          }
        },
        child: BlocBuilder<NotificationCubit, NotificationState>(
          bloc: notificationCubit,
          builder: (context, state) {
            return Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: isDesktop ? 800 : (isLargeScreen ? 600 : double.infinity),
                ),
                margin: isLargeScreen
                    ? const EdgeInsets.symmetric(vertical: 32)
                    : EdgeInsets.zero,
                decoration: isLargeScreen
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      )
                    : null,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(isLargeScreen ? 40 : 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isLargeScreen) ...[
                        Text(
                          'Manage your notifications',
                          style: TextStyles.font24BlackBold.copyWith(
                            color: ColorsManager.mainBlue,
                          ),
                        ),
                        verticalSpace(8),
                        Text(
                          'Choose what updates you want to receive',
                          style: TextStyles.font14GrayRegular,
                        ),
                        verticalSpace(32),
                        const Divider(),
                        verticalSpace(32),
                      ],
                      _buildSectionHeader('notifications.general'.tr()),
                      verticalSpace(isLargeScreen ? 16 : 8),
                      _buildNotificationTile(
                        icon: Icons.notifications_active_outlined,
                        title: 'notifications.push_notifications'.tr(),
                        subtitle: 'notifications.push_notifications_desc'.tr(),
                        value: pushNotifications,
                        onChanged: (value) =>
                            setState(() => pushNotifications = value),
                        isLargeScreen: isLargeScreen,
                      ),
                      verticalSpace(isLargeScreen ? 32 : 24),
                      _buildSectionHeader(
                        'notifications.booking_notifications'.tr(),
                      ),
                      verticalSpace(isLargeScreen ? 16 : 8),
                      _buildNotificationTile(
                        icon: Icons.calendar_month_outlined,
                        title: 'notifications.booking_reminders'.tr(),
                        subtitle: 'notifications.booking_reminders_desc'.tr(),
                        value: bookingReminders,
                        onChanged: pushNotifications
                            ? (value) =>
                                  setState(() => bookingReminders = value)
                            : null,
                        isLargeScreen: isLargeScreen,
                      ),
                      verticalSpace(isLargeScreen ? 32 : 24),
                      _buildSectionHeader('notifications.marketing'.tr()),
                      verticalSpace(isLargeScreen ? 16 : 8),
                      _buildNotificationTile(
                        icon: Icons.local_offer_outlined,
                        title: 'notifications.promotional_notifications'.tr(),
                        subtitle: 'notifications.promotional_notifications_desc'.tr(),
                        value: promotionalNotifications,
                        onChanged: pushNotifications
                            ? (value) => setState(
                                () => promotionalNotifications = value,
                              )
                            : null,
                        isLargeScreen: isLargeScreen,
                      ),
                      if (!pushNotifications) ...[
                        verticalSpace(isLargeScreen ? 32 : 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.orange.withOpacity(0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.warning_amber_rounded, color: Colors.orange[800]),
                              horizontalSpace(12),
                              Expanded(
                                child: Text(
                                  'notifications.push_disabled_warning'.tr(),
                                  style: TextStyles.font14GrayRegular.copyWith(
                                    color: Colors.orange[800],
                                    height: 1.4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      verticalSpace(isLargeScreen ? 40 : 32),
                      _buildInfoSection(isLargeScreen),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title, 
      style: TextStyles.font18DarkBold.copyWith(
        color: ColorsManager.mainBlue,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    ValueChanged<bool>? onChanged,
    bool isLargeScreen = false,
  }) {
    final isEnabled = onChanged != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50], // Slightly different background for tiles
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: SwitchListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: isLargeScreen ? 20 : 16, 
          vertical: isLargeScreen ? 12 : 4
        ),
        secondary: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isEnabled ? ColorsManager.mainBlue.withOpacity(0.1) : Colors.grey.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: isEnabled ? ColorsManager.mainBlue : Colors.grey,
            size: 24,
          ),
        ),
        title: Text(
          title,
          style: TextStyles.font16DarkBold.copyWith(
            color: isEnabled ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            subtitle,
            style: TextStyles.font14GrayRegular.copyWith(
              color: isEnabled ? Colors.grey[600] : Colors.grey[400],
              height: 1.3,
            ),
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: ColorsManager.mainBlue,
      ),
    );
  }

  Widget _buildInfoSection(bool isLargeScreen) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ColorsManager.lightBlue.withOpacity(0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.info_outline, color: ColorsManager.mainBlue, size: 28),
          horizontalSpace(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'notifications.info_title'.tr(),
                  style: TextStyles.font16DarkBold.copyWith(
                    color: ColorsManager.mainBlue,
                  ),
                ),
                verticalSpace(4),
                Text(
                  'notifications.info_description'.tr(),
                  style: TextStyles.font14GrayRegular.copyWith(
                    color: ColorsManager.mainBlue.withOpacity(0.8),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    notificationCubit.updateNotificationSettings(
      pushNotifications: pushNotifications,
      bookingReminders: bookingReminders,
      promotionalNotifications: promotionalNotifications,
    );
  }
}
