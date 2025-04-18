import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/features/booking/data/repos/booking_repo.dart';
import 'booking_state.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepo _bookingRepo;
  BookingCubit(this._bookingRepo) : super(const BookingState.initial());

  void getBooking() async {
    emit(const BookingState.bookingLoading());
    final response = await _bookingRepo.getBookings();
    response.when(
      success: (bookingResponseModel) {
        final allBookings = bookingResponseModel.bookingDataList ?? [];
        // Sort bookings by date and time, most recent first
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
        print('activeBookings: ${activeBookings.length}');
        print('historyBookings: ${historyBookings.length}');

        emit(BookingState.bookingSuccess(
          activeBookings: activeBookings,
          historyBookings: historyBookings,
        ));
      },
      failure: (error) {
        emit(BookingState.bookingError(error));
      },
    );
  }

  void cancelBooking(String bookingId) async {
    emit(const BookingState.cancelBookingLoading());
    final response = await _bookingRepo.cancelBooking(bookingId);
    response.when(
      success: (_) {
        emit(const BookingState.cancelBookingSuccess());
        // Refresh the booking list after successful cancellation
        getBooking();
      },
      failure: (error) {
        emit(BookingState.cancelBookingError(error));
      },
    );
  }
}
