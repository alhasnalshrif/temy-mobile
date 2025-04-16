import 'package:dio/dio.dart';
import 'package:flutter_complete_project/core/networking/api_constants.dart';
import 'package:flutter_complete_project/features/reservations/data/models/reservation_detail_request.dart';
import 'package:flutter_complete_project/features/reservations/data/apis/reservations_api_constants.dart';
import 'package:retrofit/retrofit.dart';

part 'reservations_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ReservationApiServices {
  factory ReservationApiServices(Dio dio) = _ReservationApiServices;

  @POST(ReservationsApiConstants.reservations)
  Future<ReservationRequestModel> postReservations(
      @Body() ReservationRequestModel reservationRequest);
}
