import 'package:dio/dio.dart';
import 'package:temy_barber/core/networking/api_constants.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_detail_request.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';
import 'package:temy_barber/features/reservations/data/apis/reservations_api_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'reservations_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ReservationApiServices {
  factory ReservationApiServices(Dio dio) = _ReservationApiServices;

  @POST(ReservationsApiConstants.reservations)
  Future<ReservationResponseModel> postReservations(
      @Body() ReservationRequestModel reservationRequest);

  @POST('${ReservationsApiConstants.reservations}/multiple')
  Future<ReservationResponseModel> postMultipleReservations(
      @Body() List<ReservationRequestModel> reservationsRequest);

  @GET('${ReservationsApiConstants.reservations}/available-slots')
  Future<TimeSlotsResponse> getAvailableTimeSlots(
      @Query('barberId') String barberId, @Query('date') String date);
}
