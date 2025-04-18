import 'package:dio/dio.dart';
import 'package:temy_barber/core/networking/api_constants.dart';
import 'package:temy_barber/features/booking/data/apis/booking_api_constants.dart';
import 'package:temy_barber/features/booking/data/models/booking_response.dart';
import 'package:retrofit/retrofit.dart';

part 'booking_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class BookingApiServices {
  factory BookingApiServices(Dio dio) = _BookingApiServices;

  @GET(BookingApiConstants.reservations)
  Future<BookingResponseModel> getBooking();

  @PATCH(BookingApiConstants.cancelReservation)
  Future<void> cancelBooking(@Path("id") String bookingId);
}
