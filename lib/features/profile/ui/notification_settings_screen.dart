import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'notifications.settings'.tr(),
          style: TextStyles.font18DarkBold,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorsManager.mainBlue),
        actions: [
          BlocBuilder<NotificationCubit, NotificationState>(
            bloc: notificationCubit,
            builder: (context, state) {
              final isLoading =
                  state.runtimeType.toString().contains('Loading');
              return TextButton(
                onPressed: isLoading ? null : _saveSettings,
                child: Text(
                  'common.save'.tr(),
                  style: TextStyles.font16DarkBold.copyWith(
                    color: isLoading ? Colors.grey : ColorsManager.mainBlue,
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
              ),
            );
          } else if (state.runtimeType.toString().contains('Error')) {
            final errorState = state as dynamic;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(errorState.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: BlocBuilder<NotificationCubit, NotificationState>(
          bloc: notificationCubit,
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('notifications.general'.tr()),
                  verticalSpace(8),
                  _buildNotificationTile(
                    icon: Icons.notifications,
                    title: 'notifications.push_notifications'.tr(),
                    subtitle: 'notifications.push_notifications_desc'.tr(),
                    value: pushNotifications,
                    onChanged: (value) =>
                        setState(() => pushNotifications = value),
                  ),
                  verticalSpace(24),
                  _buildSectionHeader(
                      'notifications.booking_notifications'.tr()),
                  verticalSpace(8),
                  _buildNotificationTile(
                    icon: Icons.schedule,
                    title: 'notifications.booking_reminders'.tr(),
                    subtitle: 'notifications.booking_reminders_desc'.tr(),
                    value: bookingReminders,
                    onChanged: pushNotifications
                        ? (value) => setState(() => bookingReminders = value)
                        : null,
                  ),
                  verticalSpace(24),
                  _buildSectionHeader('notifications.marketing'.tr()),
                  verticalSpace(8),
                  _buildNotificationTile(
                    icon: Icons.local_offer,
                    title: 'notifications.promotional_notifications'.tr(),
                    subtitle:
                        'notifications.promotional_notifications_desc'.tr(),
                    value: promotionalNotifications,
                    onChanged: pushNotifications
                        ? (value) =>
                            setState(() => promotionalNotifications = value)
                        : null,
                  ),
                  if (!pushNotifications) ...[
                    verticalSpace(24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border:
                            Border.all(color: Colors.orange.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.warning, color: Colors.orange[700]),
                          horizontalSpace(12),
                          Expanded(
                            child: Text(
                              'notifications.push_disabled_warning'.tr(),
                              style: TextStyles.font14GrayRegular.copyWith(
                                color: Colors.orange[700],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  verticalSpace(32),
                  _buildInfoSection(),
                ],
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
      style: TextStyles.font18DarkBold,
    );
  }

  Widget _buildNotificationTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    ValueChanged<bool>? onChanged,
  }) {
    final isEnabled = onChanged != null;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SwitchListTile(
        secondary: Icon(
          icon,
          color: isEnabled ? ColorsManager.mainBlue : Colors.grey,
        ),
        title: Text(
          title,
          style: TextStyles.font16DarkBold.copyWith(
            color: isEnabled ? Colors.black : Colors.grey,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyles.font14GrayRegular.copyWith(
            color: isEnabled ? Colors.grey[600] : Colors.grey[400],
          ),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: ColorsManager.mainBlue,
        activeTrackColor: ColorsManager.mainBlue.withOpacity(0.2),
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorsManager.lightBlue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: ColorsManager.lightBlue.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: ColorsManager.mainBlue),
              horizontalSpace(8),
              Text(
                'notifications.info_title'.tr(),
                style: TextStyles.font16DarkBold.copyWith(
                  color: ColorsManager.mainBlue,
                ),
              ),
            ],
          ),
          verticalSpace(8),
          Text(
            'notifications.info_description'.tr(),
            style: TextStyles.font14GrayRegular.copyWith(
              color: ColorsManager.mainBlue,
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
