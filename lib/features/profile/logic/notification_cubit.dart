import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:temy_barber/features/profile/data/models/notification_request.dart';
import 'package:temy_barber/features/profile/data/models/notification_response.dart';
import 'package:temy_barber/features/profile/data/repos/profile_repo.dart';
import 'package:temy_barber/core/services/notification_service.dart';
import 'dart:io' show Platform;
import 'dart:developer';

part 'notification_cubit.freezed.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final ProfileRepo _profileRepo;
  final NotificationService _notificationService;

  NotificationCubit(this._profileRepo, this._notificationService)
      : super(const NotificationState.initial());

  /// Initialize notifications and sync with server
  Future<void> initializeNotifications() async {
    emit(const NotificationState.loading());

    try {
      // Get current notification settings from server
      await getNotificationSettings();

      // Update device token on server
      await _updateDeviceTokenOnServer();
    } catch (error) {
      log('Failed to initialize notifications: $error');
      emit(NotificationState.error(error.toString()));
    }
  }

  /// Update device token on server
  Future<void> _updateDeviceTokenOnServer() async {
    try {
      final token = await _notificationService.getPushToken();
      final playerId = await _notificationService.getPlayerId();

      if (token != null) {
        final request = NotificationTokenRequest(
          deviceToken: token,
          playerId: playerId,
          platform: Platform.isAndroid ? 'android' : 'ios',
        );

        final result = await _profileRepo.updateDeviceToken(request);
        result.when(
          success: (response) {
            log('Device token updated successfully: ${response.message}');
          },
          failure: (error) {
            log('Failed to update device token: ${error.apiErrorModel.message}');
          },
        );
      }
    } catch (error) {
      log('Error updating device token: $error');
    }
  }

  /// Get notification settings from server
  Future<void> getNotificationSettings() async {
    emit(const NotificationState.loading());

    final result = await _profileRepo.getNotificationSettings();
    result.when(
      success: (settings) {
        emit(NotificationState.settingsLoaded(settings));
      },
      failure: (error) {
        emit(NotificationState.error(error.apiErrorModel.message ??
            'Failed to load notification settings'));
      },
    );
  }

  /// Update notification settings
  Future<void> updateNotificationSettings({
    required bool pushNotifications,
    bool? bookingReminders,
    bool? promotionalNotifications,
  }) async {
    emit(const NotificationState.loading());

    try {
      // Update local notification service
      await _notificationService.setNotificationEnabled(pushNotifications);

      // Update server settings
      final request = NotificationSettingsRequest(
        pushNotifications: pushNotifications,
        bookingReminders: bookingReminders,
        promotionalNotifications: promotionalNotifications,
      );

      final result = await _profileRepo.updateNotificationSettings(request);
      result.when(
        success: (response) {
          emit(NotificationState.settingsUpdated(response));
          // Refresh settings
          getNotificationSettings();
        },
        failure: (error) {
          emit(NotificationState.error(error.apiErrorModel.message ??
              'Failed to update notification settings'));
        },
      );
    } catch (error) {
      emit(NotificationState.error(error.toString()));
    }
  }

  /// Get notification history
  Future<void> getNotificationHistory() async {
    emit(const NotificationState.loading());

    final result = await _profileRepo.getNotificationHistory();
    result.when(
      success: (history) {
        emit(NotificationState.historyLoaded(history));
      },
      failure: (error) {
        emit(NotificationState.error(error.apiErrorModel.message ??
            'Failed to load notification history'));
      },
    );
  }

  /// Mark notification as read
  Future<void> markNotificationAsRead(int notificationId) async {
    final result = await _profileRepo.markNotificationAsRead(notificationId);
    result.when(
      success: (response) {
        log('Notification marked as read: ${response.message}');
        // Refresh notification history
        getNotificationHistory();
      },
      failure: (error) {
        log('Failed to mark notification as read: ${error.apiErrorModel.message}');
      },
    );
  }

  /// Request notification permission
  Future<void> requestNotificationPermission() async {
    emit(const NotificationState.loading());

    try {
      final granted =
          await _notificationService.requestNotificationPermission();
      if (granted) {
        emit(const NotificationState.permissionGranted());
        // Initialize notifications after permission granted
        await initializeNotifications();
      } else {
        emit(const NotificationState.permissionDenied());
      }
    } catch (error) {
      emit(NotificationState.error(error.toString()));
    }
  }

  /// Check notification permission status
  Future<void> checkNotificationPermission() async {
    try {
      final enabled = await _notificationService.areNotificationsEnabled();
      if (enabled) {
        emit(const NotificationState.permissionGranted());
      } else {
        emit(const NotificationState.permissionDenied());
      }
    } catch (error) {
      emit(NotificationState.error(error.toString()));
    }
  }

  /// Set user ID for OneSignal (call after login)
  Future<void> setUserId(String userId) async {
    try {
      await _notificationService.setUserId(userId);
      // Update device token after setting user ID
      await _updateDeviceTokenOnServer();
    } catch (error) {
      log('Failed to set user ID: $error');
    }
  }

  /// Logout user from OneSignal (call after logout)
  Future<void> logoutUser() async {
    try {
      await _notificationService.logoutUser();
    } catch (error) {
      log('Failed to logout user: $error');
    }
  }
}
