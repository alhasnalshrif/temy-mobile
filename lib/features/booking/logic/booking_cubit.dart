import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/booking/data/repos/booking_repo.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepo _bookingRepo;
  BookingCubit(this._bookingRepo) : super(const BookingState.initial());

  static const _timeout = Duration(seconds: 20);

  void getBooking() async {
    emit(const BookingState.bookingLoading());

    try {
      final response = await _bookingRepo.getBookings().timeout(_timeout);

      response.when(
        success: (bookingResponseModel) {
          final allBookings = bookingResponseModel.bookingDataList ?? [];
          allBookings.sort((a, b) {
            final dateComparison = (b.date ?? '').compareTo(a.date ?? '');
            if (dateComparison != 0) return dateComparison;
            return (b.startTime ?? '').compareTo(a.startTime ?? '');
          });

          final activeBookings = allBookings
              .where((booking) =>
                  booking.status == 'pending' || booking.status == 'confirmed')
              .toList();
          final historyBookings = allBookings
              .where((booking) =>
                  booking.status == 'completed' || booking.status == 'cancelled')
              .toList();

          emit(BookingState.bookingSuccess(
            activeBookings: activeBookings,
            historyBookings: historyBookings,
          ));
        },
        failure: (error) {
          emit(BookingState.bookingError(error));
        },
      );
    } on TimeoutException catch (e) {
      emit(BookingState.bookingError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(BookingState.bookingError(ErrorHandler.handle(e)));
    }
  }

  void cancelBooking(String bookingId) async {
    emit(const BookingState.cancelBookingLoading());

    try {
      final response =
          await _bookingRepo.cancelBooking(bookingId).timeout(_timeout);

      response.when(
        success: (_) {
          emit(const BookingState.cancelBookingSuccess());
          getBooking();
        },
        failure: (error) {
          emit(BookingState.cancelBookingError(error));
        },
      );
    } on TimeoutException catch (e) {
      emit(BookingState.cancelBookingError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(BookingState.cancelBookingError(ErrorHandler.handle(e)));
    }
  }
}
