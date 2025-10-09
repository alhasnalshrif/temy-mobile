import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/reservations/data/apis/reservations_api_services.dart';
import 'package:temy_barber/features/reservations/data/apis/queue_api_services.dart';
import 'package:temy_barber/features/reservations/data/models/multiple_reservation_response.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_detail_request.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'package:temy_barber/features/reservations/data/models/queue_settings_response.dart';

class ReservationRepo {
  final ReservationApiServices _reservationApiServices;
  final QueueApiServices _queueApiServices;

  ReservationRepo(this._reservationApiServices, this._queueApiServices);

  Future<ApiResult<ReservationResponseModel>> postReservation({
    String? userId,
    required List<String> serviceIds,
    required String barberId,
    required String date,
    required String startTime,
    GuestInfo? guest,
    String? note,
  }) async {
    try {
      print('🔵 ReservationRepo: Calling postReservation API...');
      print('   userId: $userId');
      print('   guest: $guest');
      print('   Is guest: ${guest != null && userId == null}');

      final requestModel = ReservationRequestModel(
        user: userId,
        serviceIds: serviceIds,
        barberId: barberId,
        date: date,
        startTime: startTime,
        guest: guest,
        note: note,
      );

      // Use guest endpoint if user is not logged in (userId is null AND guest is provided)
      final isGuestBooking = guest != null && userId == null;
      print('   Using guest endpoint: $isGuestBooking');

      final response = isGuestBooking
          ? await _reservationApiServices.postGuestReservation(requestModel)
          : await _reservationApiServices.postReservations(requestModel);

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<ReservationResponseModel>> postMultipleReservations({
    required String userId,
    required List<Map<String, dynamic>> reservationsData,
  }) async {
    try {
      final reservations = reservationsData
          .map(
            (data) => ReservationRequestModel(
              user: userId,
              serviceIds: data['serviceIds'],
              barberId: data['barberId'],
              date: data['date'],
              startTime: data['startTime'],
            ),
          )
          .toList();

      final multiResponse = await _reservationApiServices
          .postMultipleReservations(reservations);

      // Convert the multiple reservation response to a standard reservation response
      final response = multiResponse.toReservationResponseModel();
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      print('Error in postMultipleReservations: $error');
      print('Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<TimeSlotsResponse>> getAvailableTimeSlots({
    required String barberId,
    required String date,
  }) async {
    try {
      final response = await _reservationApiServices.getAvailableTimeSlots(
        barberId,
        date,
      );

      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  // Queue-based reservation methods

  Future<ApiResult<ReservationResponseModel>> joinQueue({
    required String barberId,
    required List<String> serviceIds,
    String? userId,
    GuestInfo? guest,
    String? note,
  }) async {
    try {
      print('🔵 ReservationRepo: Calling joinQueue API...');
      print('   userId: $userId');
      print('   guest: $guest');
      print('   guest != null: ${guest != null}');
      print('   userId == null: ${userId == null}');
      print('   Is guest: ${guest != null && userId == null}');

      final request = JoinQueueRequest(
        barberId: barberId,
        serviceIds: serviceIds,
        userId: userId,
        guest: guest,
        note: note,
      );

      // Use guest endpoint if user is not logged in (userId is null AND guest is provided)
      final isGuestBooking = guest != null && userId == null;
      print('   Using guest endpoint: $isGuestBooking');

      final response = isGuestBooking
          ? await _queueApiServices.joinQueueGuest(request)
          : await _queueApiServices.joinQueue(request);

      print('✅ ReservationRepo: joinQueue API success!');
      print('   Response status: ${response.status}');
      print('   Queue number: ${response.data.queueNumber}');
      print('   Is queue reservation: ${response.data.isQueueReservation}');
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      print('❌ ReservationRepo: joinQueue API error!');
      print('   Error type: ${error.runtimeType}');
      print('   Error: $error');
      print('   Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<QueueStatusResponse>> getQueueStatus({
    required String barberId,
  }) async {
    try {
      final response = await _queueApiServices.getQueueStatus(barberId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<QueuePositionResponse>> getMyQueuePosition({
    required String reservationId,
  }) async {
    try {
      final response = await _queueApiServices.getMyQueuePosition(
        reservationId,
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> advanceQueue({required String barberId}) async {
    try {
      await _queueApiServices.advanceQueue(barberId);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<void>> skipCustomer({required String reservationId}) async {
    try {
      await _queueApiServices.skipCustomer(reservationId);
      return const ApiResult.success(null);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<QueueSettingsResponse>> getQueueSettings() async {
    try {
      print('🔍 ReservationRepo: Calling queue settings API...');
      final response = await _queueApiServices.getQueueSettings();
      print('✅ ReservationRepo: API response received');
      print('   Response data: ${response.data.isQueueMode}');
      return ApiResult.success(response);
    } catch (error, stackTrace) {
      print('❌ ReservationRepo: Error caught!');
      print('   Error type: ${error.runtimeType}');
      print('   Error message: $error');
      print('   Stack trace: $stackTrace');
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
