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
        emit(BookingState.bookingSuccess(bookingResponseModel));
      },
      failure: (error) {
        emit(BookingState.bookingError(error));
      },
    );
  }
}
