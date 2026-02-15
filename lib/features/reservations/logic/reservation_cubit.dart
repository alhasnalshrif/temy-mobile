import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/data/repos/reservation_repo.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'reservation_state.dart';

/// Cubit managing all reservation-related state and API interactions.
/// Handles time-slot reservations, queue-based bookings, and guest verification.
class ReservationCubit extends Cubit<ReservationState> {
  final ReservationRepo _reservationRepo;
  static const _timeout = Duration(seconds: 20);

  ReservationCubit(this._reservationRepo)
    : super(const ReservationState.initial());

  /// Create a new reservation with time slot
  Future<void> postReservation({
    String? userId,
    required List<String> serviceIds,
    required String barberId,
    required String date,
    required String startTime,
    GuestInfo? guest,
    String? note,
    ReservationArguments? arguments,
  }) async {
    emit(const ReservationState.reservationLoading());

    try {
      final response = await _reservationRepo.postReservation(
        userId: userId,
        serviceIds: serviceIds,
        barberId: barberId,
        date: date,
        startTime: startTime,
        guest: guest,
        note: note,
      );

      response.when(
        success: (data) =>
            emit(ReservationState.reservationSuccess(data, arguments: arguments)),
        failure: (error) => emit(ReservationState.reservationError(error)),
      );
    } on TimeoutException catch (e) {
      emit(ReservationState.reservationError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(ReservationState.reservationError(ErrorHandler.handle(e)));
    }
  }

  /// Create multiple reservations in a batch
  Future<void> postMultipleReservations({
    required String userId,
    required List<Map<String, dynamic>> reservationsData,
    ReservationArguments? arguments,
  }) async {
    emit(const ReservationState.reservationLoading());

    try {
      final response = await _reservationRepo.postMultipleReservations(
        userId: userId,
        reservationsData: reservationsData,
      );

      response.when(
        success: (data) =>
            emit(ReservationState.reservationSuccess(data, arguments: arguments)),
        failure: (error) => emit(ReservationState.reservationError(error)),
      );
    } on TimeoutException catch (e) {
      emit(ReservationState.reservationError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(ReservationState.reservationError(ErrorHandler.handle(e)));
    }
  }

  /// Fetch available time slots for a specific barber and date
  Future<void> getAvailableTimeSlots({
    required String barberId,
    required DateTime date,
  }) async {
    emit(const ReservationState.timeSlotsLoading());

    try {
      final formattedDate = _formatDate(date);
      final response = await _reservationRepo.getAvailableTimeSlots(
        barberId: barberId,
        date: formattedDate,
      );

      response.when(
        success: (data) => emit(ReservationState.timeSlotsSuccess(data)),
        failure: (error) => emit(ReservationState.timeSlotsError(error)),
      );
    } on TimeoutException catch (e) {
      emit(ReservationState.timeSlotsError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(ReservationState.timeSlotsError(ErrorHandler.handle(e)));
    }
  }

  /// Join queue for a barber (queue mode booking)
  Future<void> joinQueue({
    required String barberId,
    required List<String> serviceIds,
    String? userId,
    GuestInfo? guest,
    String? note,
    ReservationArguments? arguments,
  }) async {
    emit(const ReservationState.reservationLoading());

    try {
      final response = await _reservationRepo.joinQueue(
        barberId: barberId,
        serviceIds: serviceIds,
        userId: userId,
        guest: guest,
        note: note,
      );

      response.when(
        success: (data) {
          debugPrint('Queue joined: position=${data.data.queueNumber}');
          emit(ReservationState.reservationSuccess(data, arguments: arguments));
        },
        failure: (error) => emit(ReservationState.reservationError(error)),
      );
    } on TimeoutException catch (e) {
      emit(ReservationState.reservationError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(ReservationState.reservationError(ErrorHandler.handle(e)));
    }
  }

  /// Fetch queue settings to determine booking mode
  Future<void> getQueueSettings() async {
    emit(const ReservationState.queueSettingsLoading());

    try {
      final response = await _reservationRepo.getQueueSettings();

      response.when(
        success: (data) => emit(ReservationState.queueSettingsSuccess(data)),
        failure: (error) => emit(ReservationState.queueSettingsError(error)),
      );
    } on TimeoutException catch (e) {
      emit(ReservationState.queueSettingsError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(ReservationState.queueSettingsError(ErrorHandler.handle(e)));
    }
  }

  /// Request OTP verification for guest reservations
  Future<void> requestGuestVerification({required String phone}) async {
    emit(const ReservationState.otpRequestLoading());

    try {
      final response = await _reservationRepo.requestGuestVerification(
        phone: phone,
      );

      response.when(
        success: (data) => emit(ReservationState.otpRequestSuccess(data)),
        failure: (error) => emit(ReservationState.otpRequestError(error)),
      );
    } on TimeoutException catch (e) {
      emit(ReservationState.otpRequestError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(ReservationState.otpRequestError(ErrorHandler.handle(e)));
    }
  }

  /// Verify OTP and create guest reservation
  Future<void> verifyAndCreateGuestReservation({
    required String phone,
    required String otp,
    required String userName,
    required String barberId,
    required List<String> serviceIds,
    required String date,
    required String startTime,
    String? note,
    ReservationArguments? arguments,
  }) async {
    emit(const ReservationState.otpVerificationLoading());

    try {
      final response = await _reservationRepo.verifyAndCreateGuestReservation(
        phone: phone,
        otp: otp,
        userName: userName,
        barberId: barberId,
        serviceIds: serviceIds,
        date: date,
        startTime: startTime,
        note: note,
      );

      response.when(
        success: (data) => emit(
          ReservationState.otpVerificationSuccess(data, arguments: arguments),
        ),
        failure: (error) => emit(ReservationState.otpVerificationError(error)),
      );
    } on TimeoutException catch (e) {
      emit(ReservationState.otpVerificationError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(ReservationState.otpVerificationError(ErrorHandler.handle(e)));
    }
  }

  /// Format DateTime to API-compatible string (yyyy-MM-dd)
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
