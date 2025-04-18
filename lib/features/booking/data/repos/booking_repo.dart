import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/booking/data/apis/booking_api_services.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';

class BookingRepo {
  final BookingApiServices _bookingApiServices;

  BookingRepo(this._bookingApiServices);

  Future<ApiResult<BookingResponseModel>> getBookings() async {
    try {
      final response = await _bookingApiServices.getBooking();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> cancelBooking(String bookingId) async {
    try {
      await _bookingApiServices.cancelBooking(bookingId);
      return const ApiResult.success(null); // Indicate success with no data
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
