import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/barber/data/models/reservation_arguments.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';
import 'package:temy_barber/features/reservations/data/models/queue_settings_response.dart';
import 'package:temy_barber/features/reservations/data/models/otp_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_state.freezed.dart';

@freezed
class ReservationState with _$ReservationState {
  const factory ReservationState.initial() = _Initial;

  // GET Reservation DETAIL
  const factory ReservationState.reservationLoading() = ReservationLoading;
  const factory ReservationState.reservationSuccess(
    ReservationResponseModel reservationRequestModel, {
    ReservationArguments? arguments,
  }) = ReservationSuccess;
  const factory ReservationState.reservationError(ErrorHandler errorHandler) =
      ReservationError;

  // GET Available Time Slots
  const factory ReservationState.timeSlotsLoading() = TimeSlotsLoading;
  const factory ReservationState.timeSlotsSuccess(
    TimeSlotsResponse timeSlotsResponse,
  ) = TimeSlotsSuccess;
  const factory ReservationState.timeSlotsError(ErrorHandler errorHandler) =
      TimeSlotsError;

  // GET Queue Settings
  const factory ReservationState.queueSettingsLoading() = QueueSettingsLoading;
  const factory ReservationState.queueSettingsSuccess(
    QueueSettingsResponse settingsResponse,
  ) = QueueSettingsSuccess;
  const factory ReservationState.queueSettingsError(ErrorHandler errorHandler) =
      QueueSettingsError;

  // OTP Verification for Guest Reservations
  const factory ReservationState.otpRequestLoading() = OtpRequestLoading;
  const factory ReservationState.otpRequestSuccess(OtpResponse otpResponse) =
      OtpRequestSuccess;
  const factory ReservationState.otpRequestError(ErrorHandler errorHandler) =
      OtpRequestError;

  const factory ReservationState.otpVerificationLoading() =
      OtpVerificationLoading;
  const factory ReservationState.otpVerificationSuccess(
    ReservationResponseModel reservationResponse, {
    ReservationArguments? arguments,
  }) = OtpVerificationSuccess;
  const factory ReservationState.otpVerificationError(
    ErrorHandler errorHandler,
  ) = OtpVerificationError;
}
