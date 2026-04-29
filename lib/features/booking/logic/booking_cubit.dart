import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/booking/data/repos/booking_repo.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'booking_state.dart';

class BookingCubit extends BaseCubit<BookingState> {
  final BookingRepo _bookingRepo;
  BookingCubit(this._bookingRepo) : super(const BookingState.initial());

  void getBooking() async {
    emit(const BookingState.bookingLoading());

    executeApi(
      apiCall: () => _bookingRepo.getBookings(),
      onSuccess: (bookingResponseModel) {
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
      onError: (error) {
        emit(BookingState.bookingError(error));
      },
    );
  }

  void cancelBooking(String bookingId) async {
    emit(const BookingState.cancelBookingLoading());

    executeApi(
      apiCall: () => _bookingRepo.cancelBooking(bookingId),
      onSuccess: (_) {
        emit(const BookingState.cancelBookingSuccess());
        getBooking();
      },
      onError: (error) {
        emit(BookingState.cancelBookingError(error));
      },
    );
  }

  void toggleBookingTab(bool showActive) {
    state.maybeWhen(
      bookingSuccess: (activeBookings, historyBookings, showActiveBookings, selectedStatus) {
        emit(BookingState.bookingSuccess(
          activeBookings: activeBookings,
          historyBookings: historyBookings,
          showActiveBookings: showActive,
        ));
      },
      orElse: () {},
    );
  }

  void filterByStatus(String status) {
    state.maybeWhen(
      bookingSuccess: (activeBookings, historyBookings, showActiveBookings, _) {
        emit(BookingState.bookingSuccess(
          activeBookings: activeBookings,
          historyBookings: historyBookings,
          showActiveBookings: showActiveBookings,
          selectedStatus: status,
        ));
      },
      orElse: () {},
    );
  }

  List<BookingData> getFilteredBookings() {
    return state.maybeWhen(
      bookingSuccess: (activeBookings, historyBookings, showActiveBookings, selectedStatus) {
        final bookings = showActiveBookings ? activeBookings : historyBookings;
        if (selectedStatus == 'all') return bookings;
        return bookings.where((booking) => booking.status == selectedStatus).toList();
      },
      orElse: () => [],
    );
  }

  bool hasUpcomingBookings() {
    return state.maybeWhen(
      bookingSuccess: (activeBookings, historyBookings, showActiveBookings, selectedStatus) {
        return activeBookings.isNotEmpty;
      },
      orElse: () => false,
    );
  }
}
