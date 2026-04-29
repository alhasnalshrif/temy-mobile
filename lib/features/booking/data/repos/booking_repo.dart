import 'package:temy_barber/core/networking/api_safe_call.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/booking/data/apis/booking_api_services.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';

class BookingRepo {
  final BookingApiServices _bookingApiServices;

  BookingRepo(this._bookingApiServices);

  Future<ApiResult<BookingResponseModel>> getBookings() async {
    return ApiSafeCall.call(() => _bookingApiServices.getBooking());
  }

  Future<ApiResult<void>> cancelBooking(String bookingId) async {
    return ApiSafeCall.callVoid(
      () => _bookingApiServices.cancelBooking(bookingId),
    );
  }
}
