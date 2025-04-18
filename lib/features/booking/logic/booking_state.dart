import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'booking_state.freezed.dart';

@freezed
class BookingState with _$BookingState {
  const factory BookingState.initial() = _Initial;

  // booking
  const factory BookingState.bookingLoading() = BookingLoading;
  const factory BookingState.bookingSuccess({
    required List<BookingData> activeBookings,
    required List<BookingData> historyBookings,
  }) = BookingSuccess;

  const factory BookingState.bookingError(ErrorHandler errorHandler) =
      BookingError;
}
