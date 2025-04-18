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
  }
}
