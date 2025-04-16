import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'barber_state.freezed.dart';

@freezed
class BarberState with _$BarberState {
  const factory BarberState.initial() = _Initial;

// GET BARBER DETAIL
  const factory BarberState.barberLoading() = BarberLoading;
  const factory BarberState.barberSuccess(
      BarberDetailResponseModel barberDetailResponseModel) = BarberSuccess;
  const factory BarberState.barberError(ErrorHandler errorHandler) =
      BarberError;
}
