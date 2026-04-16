import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/profile/data/models/notification_response.dart';
import 'package:temy_barber/features/profile/data/repos/profile_repo.dart';
import 'package:temy_barber/core/services/notification_service.dart';
import 'package:temy_barber/core/services/permission_manager.dart';
import 'package:temy_barber/core/helpers/shared_pref_helper.dart';
import 'package:temy_barber/core/helpers/constants.dart';
import 'dart:developer';

part 'notification_cubit.freezed.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  final ProfileRepo _profileRepo;
  final NotificationService _notificationService;

  NotificationCubit(this._profileRepo, this._notificationService)
    : super(const NotificationState.initial());

  static const String _lastRegisteredPlayerIdPrefix =
      'notification_last_registered_player_';

  /// Initialize notifications and sync with server
  Future<void> initializeNotifications() async {
    emit(const NotificationState.loading());

    try {
      // Update device token on server
      await _updateDeviceTokenOnServer();
    } catch (error) {
      log('Failed to initialize notifications: $error');
      emit(NotificationState.error(error.toString()));
    }
  }

  /// Update device token on server
  Future<void> _updateDeviceTokenOnServer({bool force = false}) async {
    try {
      final playerId = await _notificationService.getPlayerId();
      final userId = await SharedPrefHelper.getSecuredString(
        SharedPrefKeys.userId,
      );

      log('Retrieved playerId: ${playerId ?? "null"}');
      log('Retrieved userId: ${userId ?? "null"}');

      if (playerId != null && userId != null && userId.isNotEmpty) {
        final cacheKey = '$_lastRegisteredPlayerIdPrefix$userId';
        final cachedPlayerId = await SharedPrefHelper.getString(cacheKey);
        final didDeviceChange = cachedPlayerId != playerId;

        if (!force && !didDeviceChange) {
          log('Player ID unchanged, skipping device re-registration');
          return;
        }

        final result = await _profileRepo.registerDevice(userId, playerId);
        result.when(
          success: (response) {
            log('Device registered successfully: ${response.message}');
            SharedPrefHelper.setData(cacheKey, playerId);
          },
          failure: (error) {
            log('Failed to register device: ${error.apiErrorModel.message}');
            // Don't throw error, just log it
          },
        );
      } else {
        log('Missing userId or playerId, skipping device registration');
      }
    } catch (error) {
      log('Error registering device: $error');
      // Don't rethrow error to prevent app crashes
    }
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
      emit(
        NotificationState.settingsUpdated(
          NotificationResponse(
            status: 'success',
            message: 'Notification settings updated',
          ),
        ),
      );
    } catch (error) {
      emit(NotificationState.error(error.toString()));
    }
  }

  /// Get notification history

  /// Mark notification as read

  /// Request notification permission
  Future<void> requestNotificationPermission() async {
    emit(const NotificationState.loading());

    try {
      final granted = await PermissionManager.instance
          .requestNotificationPermission();
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
      final enabled = await PermissionManager.instance
          .getNotificationPermissionStatus();
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

      // Always sync on login; backend can add new devices when needed.
      await _updateDeviceTokenOnServer(force: true);
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

  /// Retry device token registration (useful for debugging)
  Future<void> retryDeviceRegistration() async {
    emit(const NotificationState.loading());
    try {
      await _updateDeviceTokenOnServer();
      emit(
        NotificationState.settingsUpdated(
          NotificationResponse(
            status: 'success',
            message: 'Device registration retried successfully',
          ),
        ),
      );
    } catch (error) {
      emit(NotificationState.error(error.toString()));
    }
  }

  // Add methods for notification settings and history management
  Future<void> getNotificationSettings() async {
    // TODO: Implement when backend API is ready
    emit(const NotificationState.loading());
    // For now, emit mock data
    emit(
      NotificationState.settingsLoaded(
        NotificationSettingsResponse(
          pushNotifications: true,
          bookingReminders: true,
          promotionalNotifications: false,
        ),
      ),
    );
  }
}
