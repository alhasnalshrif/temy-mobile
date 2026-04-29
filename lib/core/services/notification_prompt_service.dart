import 'package:flutter/material.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/services/permission_manager.dart';
import 'package:easy_localization/easy_localization.dart';

/// Service to manage notification prompts for users who have disabled notifications
class NotificationPromptService {
  NotificationPromptService._();
  static final NotificationPromptService instance = NotificationPromptService._();

  static const String _appLaunchCounterKey = 'notification_prompt_app_launch_count';
  static const String _lastPromptTimeKey = 'notification_prompt_last_shown';
  static const int _promptFrequency = 5; // Show prompt every 5 app launches
  static const Duration _minTimeBetweenPrompts = Duration(days: 7); // Minimum time between prompts

  /// Check if we should show the notification prompt
  Future<bool> shouldShowPrompt() async {
    // Check if notifications are currently enabled
    final notificationsEnabled = await PermissionManager.instance
        .getNotificationPermissionStatus();

    if (notificationsEnabled) {
      // Reset counter if notifications are enabled
      await _resetCounter();
      return false;
    }

    // Get current launch count
    int launchCount = await _getLaunchCount();
    launchCount++;
    await _setLaunchCount(launchCount);

    // Check if we've reached the threshold
    if (launchCount % _promptFrequency == 0) {
      // Check if enough time has passed since last prompt
      final lastPromptTime = await _getLastPromptTime();
      final now = DateTime.now();

      if (lastPromptTime == null ||
          now.difference(lastPromptTime) > _minTimeBetweenPrompts) {
        return true;
      }
    }

    return false;
  }

  /// Show the notification prompt modal with personalization
  Future<void> showPrompt(
    BuildContext context, {
    String? userName,
    bool hasUpcomingBookings = false,
  }) async {
    await _setLastPromptTime(DateTime.now());

    if (!context.mounted) return;

    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) => _NotificationPromptBottomSheet(
        userName: userName,
        hasUpcomingBookings: hasUpcomingBookings,
      ),
    );
  }

  /// Reset the launch counter (call when notifications are enabled)
  Future<void> _resetCounter() async {
    await SharedPrefHelper.setData(_appLaunchCounterKey, 0);
  }

  /// Get the current app launch count
  Future<int> _getLaunchCount() async {
    final count = await SharedPrefHelper.getInt(_appLaunchCounterKey);
    return count;
  }

  /// Set the app launch count
  Future<void> _setLaunchCount(int count) async {
    await SharedPrefHelper.setData(_appLaunchCounterKey, count);
  }

  /// Get the last time the prompt was shown
  Future<DateTime?> _getLastPromptTime() async {
    final timestamp = await SharedPrefHelper.getString(_lastPromptTimeKey);
    if (timestamp.isEmpty) return null;
    try {
      return DateTime.parse(timestamp);
    } catch (e) {
      return null;
    }
  }

  /// Set the last time the prompt was shown
  Future<void> _setLastPromptTime(DateTime time) async {
    await SharedPrefHelper.setData(_lastPromptTimeKey, time.toIso8601String());
  }
}

/// Bottom sheet widget for notification prompt
class _NotificationPromptBottomSheet extends StatelessWidget {
  final String? userName;
  final bool hasUpcomingBookings;

  const _NotificationPromptBottomSheet({
    this.userName,
    this.hasUpcomingBookings = false,
  });

  @override
  Widget build(BuildContext context) {
    final personalizedTitle = _getPersonalizedTitle();
    final personalizedDescription = _getPersonalizedDescription();

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Icon
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.blue[50],
              shape: BoxShape.circle,
            ),
            child: Icon(
              hasUpcomingBookings
                  ? Icons.event_available_outlined
                  : Icons.notifications_active_outlined,
              size: 32,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(height: 24),

          // Personalized Title
          Text(
            personalizedTitle,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),

          // Personalized Description
          Text(
            personalizedDescription,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),

          // Enable button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final granted = await PermissionManager.instance
                    .requestNotificationPermission(force: true);

                if (granted && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('notifications.enabled_success'.tr()),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else if (!granted && context.mounted) {
                  // Show settings guidance if permission denied
                  final shouldShowSettings = await PermissionManager.instance
                      .shouldShowSettingsGuidance();

                  if (shouldShowSettings && context.mounted) {
                    _showSettingsDialog(context);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'notifications.prompt_enable_button'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Later button
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey[600],
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'notifications.prompt_later_button'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPersonalizedTitle() {
    if (userName != null && userName!.isNotEmpty) {
      return 'notifications.prompt_title_personalized'.tr(namedArgs: {
        'name': userName!,
      });
    }
    return 'notifications.prompt_title'.tr();
  }

  String _getPersonalizedDescription() {
    if (hasUpcomingBookings) {
      return 'notifications.prompt_description_bookings'.tr();
    }
    return 'notifications.prompt_description'.tr();
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('notifications.open_settings_title'.tr()),
        content: Text('notifications.open_settings_message'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('common.cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await PermissionManager.instance.openSystemSettings();
            },
            child: Text('notifications.open_settings_action'.tr()),
          ),
        ],
      ),
    );
  }
}
