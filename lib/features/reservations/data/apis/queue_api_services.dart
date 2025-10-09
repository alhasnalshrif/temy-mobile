import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:temy_barber/core/networking/api_constants.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'package:temy_barber/features/reservations/data/models/queue_settings_response.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';
import 'reservations_api_constants.dart';

part 'queue_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class QueueApiServices {
  factory QueueApiServices(Dio dio) = _QueueApiServices;

  // Join the queue (authenticated users)
  @POST("/${ReservationsApiConstants.queueJoin}")
  Future<ReservationResponseModel> joinQueue(@Body() JoinQueueRequest request);

  // Join the queue (guest users - no auth required)
  @POST("/${ReservationsApiConstants.queueGuestJoin}")
  Future<ReservationResponseModel> joinQueueGuest(
    @Body() JoinQueueRequest request,
  );

  // Get queue status for a barber
  @GET("/${ReservationsApiConstants.queueStatus}/{barberId}")
  Future<QueueStatusResponse> getQueueStatus(@Path("barberId") String barberId);

  // Get my queue position
  @GET("/${ReservationsApiConstants.queuePosition}/{reservationId}")
  Future<QueuePositionResponse> getMyQueuePosition(
    @Path("reservationId") String reservationId,
  );

  // Advance queue (barber/admin/cashier)
  @POST("/${ReservationsApiConstants.queueAdvance}/{barberId}")
  Future<dynamic> advanceQueue(@Path("barberId") String barberId);

  // Skip customer (barber/admin/cashier)
  @PATCH("/${ReservationsApiConstants.queueSkip}/{reservationId}")
  Future<dynamic> skipCustomer(@Path("reservationId") String reservationId);

  // Call customer to service (barber/admin/cashier)
  @POST("/${ReservationsApiConstants.queueCall}/{reservationId}")
  Future<ReservationResponseModel> callCustomer(
    @Path("reservationId") String reservationId,
    @Body() Map<String, dynamic> body,
  );

  // Get today's queue history
  @GET("/${ReservationsApiConstants.queueHistory}/{barberId}")
  Future<dynamic> getTodayQueueHistory(@Path("barberId") String barberId);

  // Get queue settings (check if queue mode is enabled)
  @GET("/${ReservationsApiConstants.queueSettings}")
  Future<QueueSettingsResponse> getQueueSettings();
}
