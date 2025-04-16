import 'package:flutter_complete_project/core/networking/api_error_handler.dart';
import 'package:flutter_complete_project/features/reservations/data/models/reservation_detail_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_state.freezed.dart';

@freezed
class ReservationState with _$ReservationState {
  const factory ReservationState.initial() = _Initial;


// GET Reservation DETAIL
  const factory ReservationState.reservationLoading() = ReservationLoading;
  const factory ReservationState.reservationSuccess(
      ReservationRequestModel reservationRequestModel) = ReservationSuccess;
  const factory ReservationState.reservationError(ErrorHandler errorHandler) =
      ReservationError;
}
