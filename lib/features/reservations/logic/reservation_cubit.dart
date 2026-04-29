import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/data/repos/reservation_repo.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'reservation_state.dart';

class ReservationCubit extends BaseCubit<ReservationState> {
  final ReservationRepo _reservationRepo;

  ReservationCubit(this._reservationRepo)
    : super(const ReservationState.initial());

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

    executeApi(
      apiCall: () => _reservationRepo.postReservation(
        userId: userId,
        serviceIds: serviceIds,
        barberId: barberId,
        date: date,
        startTime: startTime,
        guest: guest,
        note: note,
      ),
      onSuccess: (data) =>
          emit(ReservationState.reservationSuccess(data, arguments: arguments)),
      onError: (error) => emit(ReservationState.reservationError(error)),
    );
  }

  Future<void> postMultipleReservations({
    required String userId,
    required List<Map<String, dynamic>> reservationsData,
    ReservationArguments? arguments,
  }) async {
    emit(const ReservationState.reservationLoading());

    executeApi(
      apiCall: () => _reservationRepo.postMultipleReservations(
        userId: userId,
        reservationsData: reservationsData,
      ),
      onSuccess: (data) =>
          emit(ReservationState.reservationSuccess(data, arguments: arguments)),
      onError: (error) => emit(ReservationState.reservationError(error)),
    );
  }

  Future<void> getAvailableTimeSlots({
    required String barberId,
    required DateTime date,
  }) async {
    emit(const ReservationState.timeSlotsLoading());

    final formattedDate = _formatDate(date);
    executeApi(
      apiCall: () => _reservationRepo.getAvailableTimeSlots(
        barberId: barberId,
        date: formattedDate,
      ),
      onSuccess: (data) => emit(ReservationState.timeSlotsSuccess(data)),
      onError: (error) => emit(ReservationState.timeSlotsError(error)),
    );
  }

  Future<void> joinQueue({
    required String barberId,
    required List<String> serviceIds,
    String? userId,
    GuestInfo? guest,
    String? note,
    ReservationArguments? arguments,
  }) async {
    emit(const ReservationState.reservationLoading());

    executeApi(
      apiCall: () => _reservationRepo.joinQueue(
        barberId: barberId,
        serviceIds: serviceIds,
        userId: userId,
        guest: guest,
        note: note,
      ),
      onSuccess: (data) {
        debugPrint('Queue joined: position=${data.data.queueNumber}');
        emit(ReservationState.reservationSuccess(data, arguments: arguments));
      },
      onError: (error) => emit(ReservationState.reservationError(error)),
    );
  }

  Future<void> getQueueSettings() async {
    emit(const ReservationState.queueSettingsLoading());

    executeApi(
      apiCall: () => _reservationRepo.getQueueSettings(),
      onSuccess: (data) => emit(ReservationState.queueSettingsSuccess(data)),
      onError: (error) => emit(ReservationState.queueSettingsError(error)),
    );
  }

  Future<void> requestGuestVerification({required String phone}) async {
    emit(const ReservationState.otpRequestLoading());

    executeApi(
      apiCall: () => _reservationRepo.requestGuestVerification(phone: phone),
      onSuccess: (data) => emit(ReservationState.otpRequestSuccess(data)),
      onError: (error) => emit(ReservationState.otpRequestError(error)),
    );
  }

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

    executeApi(
      apiCall: () => _reservationRepo.verifyAndCreateGuestReservation(
        phone: phone,
        otp: otp,
        userName: userName,
        barberId: barberId,
        serviceIds: serviceIds,
        date: date,
        startTime: startTime,
        note: note,
      ),
      onSuccess: (data) => emit(
        ReservationState.otpVerificationSuccess(data, arguments: arguments),
      ),
      onError: (error) => emit(ReservationState.otpVerificationError(error)),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
