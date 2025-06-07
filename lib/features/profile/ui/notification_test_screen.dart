import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/di/dependency_injection.dart';
import 'package:temy_barber/core/helpers/spacing.dart';
import 'package:temy_barber/core/theme/colors.dart';
import 'package:temy_barber/core/theme/styles.dart';
import 'package:temy_barber/core/services/notification_service.dart';
import 'package:temy_barber/core/utils/notification_helper.dart';
import 'package:temy_barber/core/config/notification_config.dart';
import '../logic/notification_cubit.dart';

class NotificationTestScreen extends StatelessWidget {
  const NotificationTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<NotificationCubit>()..initializeNotifications(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notification Testing'),
          backgroundColor: ColorsManager.mainBlue,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<NotificationCubit, NotificationState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildConfigurationStatus(),
                  verticalSpace(20),
                  _buildDeviceInfo(context),
                  verticalSpace(20),
                  _buildTestActions(context),
                  verticalSpace(20),
                  _buildSetupInstructions(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildConfigurationStatus() {
    final status = NotificationHelper.getConfigurationStatus();
    final isConfigured = status['isConfigured'] as bool;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isConfigured ? Icons.check_circle : Icons.warning,
                  color: isConfigured ? Colors.green : Colors.orange,
                ),
                horizontalSpace(8),
                Text(
                  'Configuration Status',
                  style: TextStyles.font16DarkBold,
                ),
              ],
            ),
            verticalSpace(12),
            _buildStatusRow('App ID Configured', isConfigured),
            _buildStatusRow('Debug Logging', status['debugLogging'] as bool),
            if (isConfigured)
              _buildInfoRow('App ID', status['appId'] as String),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceInfo(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Device Information',
              style: TextStyles.font16DarkBold,
            ),
            verticalSpace(12),
            FutureBuilder<String?>(
              future: getIt<NotificationService>().getPlayerId(),
              builder: (context, snapshot) {
                return _buildInfoRow(
                  'Player ID',
                  snapshot.data ?? 'Loading...',
                );
              },
            ),
            FutureBuilder<String?>(
              future: getIt<NotificationService>().getPushToken(),
              builder: (context, snapshot) {
                final token = snapshot.data;
                return _buildInfoRow(
                  'Push Token',
                  token != null ? '${token.substring(0, 20)}...' : 'Loading...',
                );
              },
            ),
            FutureBuilder<bool>(
              future: getIt<NotificationService>().areNotificationsEnabled(),
              builder: (context, snapshot) {
                return _buildStatusRow(
                  'Notifications Enabled',
                  snapshot.data ?? false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestActions(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Actions',
              style: TextStyles.font16DarkBold,
            ),
            verticalSpace(12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _sendTestNotification(context),
                icon: const Icon(Icons.send),
                label: const Text('Send Test Notification'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.mainBlue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            verticalSpace(8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _requestPermissions(context),
                icon: const Icon(Icons.security),
                label: const Text('Request Permissions'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            verticalSpace(8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _runFullTest(context),
                icon: const Icon(Icons.science),
                label: const Text('Run Full Test'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetupInstructions() {
    if (NotificationConfig.isConfigured) {
      return const SizedBox.shrink();
    }

    return Card(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info, color: Colors.orange),
                horizontalSpace(8),
                Text(
                  'Setup Required',
                  style: TextStyles.font16DarkBold,
                ),
              ],
            ),
            verticalSpace(12),
            const Text(
              'To enable notifications, you need to:\n\n'
              '1. Create a OneSignal account at onesignal.com\n'
              '2. Create a new app and get your App ID\n'
              '3. Update NotificationConfig.oneSignalAppId\n'
              '4. Update onesignalAppId in android/app/build.gradle\n\n'
              'See ONESIGNAL_SETUP.md for detailed instructions.',
            ),
            verticalSpace(12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => NotificationHelper.printSetupInstructions(),
                icon: const Icon(Icons.help),
                label: const Text('Print Setup Instructions'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusRow(String label, bool status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Row(
            children: [
              Icon(
                status ? Icons.check : Icons.close,
                color: status ? Colors.green : Colors.red,
                size: 20,
              ),
              horizontalSpace(4),
              Text(
                status ? 'Yes' : 'No',
                style: TextStyle(
                  color: status ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(fontFamily: 'monospace'),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _sendTestNotification(BuildContext context) async {
    try {
      await getIt<NotificationService>().sendTestNotification();
      _showSnackBar(context, 'Test notification sent!', Colors.green);
    } catch (e) {
      _showSnackBar(context, 'Failed to send notification: $e', Colors.red);
    }
  }

  void _requestPermissions(BuildContext context) async {
    try {
      final granted =
          await getIt<NotificationService>().requestNotificationPermission();
      _showSnackBar(
        context,
        granted ? 'Permission granted!' : 'Permission denied',
        granted ? Colors.green : Colors.orange,
      );
    } catch (e) {
      _showSnackBar(context, 'Failed to request permission: $e', Colors.red);
    }
  }

  void _runFullTest(BuildContext context) async {
    try {
      _showSnackBar(context, 'Running full test... Check logs', Colors.blue);
      await NotificationHelper.testNotifications();
    } catch (e) {
      _showSnackBar(context, 'Test failed: $e', Colors.red);
    }
  }

  void _showSnackBar(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
