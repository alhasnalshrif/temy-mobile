import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/data/repos/reservation_repo.dart';
import 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final ReservationRepo _reservationRepo;

  ReservationCubit(this._reservationRepo)
      : super(const ReservationState.initial());

  void postReservation({
    required String userId,
    required List<String> serviceIds,
    required String barberId,
    required String date,
    required String startTime,
    ReservationArguments? arguments,
  }) async {
    emit(const ReservationState.reservationLoading());
    final response = await _reservationRepo.postReservation(
      userId: userId,
      serviceIds: serviceIds,
      barberId: barberId,
      date: date,
      startTime: startTime,
    );
    response.when(
      success: (reservationResponse) {
        emit(ReservationState.reservationSuccess(
          reservationResponse,
          arguments: arguments,
        ));
      },
      failure: (error) {
        emit(ReservationState.reservationError(error));
      },
    );
  }

  void postMultipleReservations({
    required String userId,
    required List<Map<String, dynamic>> reservationsData,
    ReservationArguments? arguments,
  }) async {
    emit(const ReservationState.reservationLoading());
    final response = await _reservationRepo.postMultipleReservations(
      userId: userId,
      reservationsData: reservationsData,
    );
    response.when(
      success: (reservationResponse) {
        emit(ReservationState.reservationSuccess(
          reservationResponse,
          arguments: arguments,
        ));
      },
      failure: (error) {
        emit(ReservationState.reservationError(error));
      },
    );
  }

  void getAvailableTimeSlots({
    required String barberId,
    required DateTime date,
  }) async {
    emit(const ReservationState.timeSlotsLoading());

    // Format date as 'yyyy-MM-dd'
    final formattedDate =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    final response = await _reservationRepo.getAvailableTimeSlots(
      barberId: barberId,
      date: formattedDate,
    );

    response.when(
      success: (timeSlotsResponse) {
        emit(ReservationState.timeSlotsSuccess(timeSlotsResponse));
      },
      failure: (error) {
        emit(ReservationState.timeSlotsError(error));
      },
    );
  }
}
