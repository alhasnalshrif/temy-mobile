import 'package:dio/dio.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/networking/api_safe_call.dart';
import 'package:temy_barber/features/reservations/data/apis/reservations_api_services.dart';
import 'package:temy_barber/features/reservations/data/apis/queue_api_services.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_detail_request.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'package:temy_barber/features/reservations/data/models/queue_settings_response.dart';
import 'package:temy_barber/features/reservations/data/models/otp_request.dart';
import 'package:temy_barber/features/reservations/data/models/otp_response.dart';

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
    return ApiSafeCall.call(() async {
      final requestModel = ReservationRequestModel(
        user: userId,
        serviceIds: serviceIds,
        barberId: barberId,
        date: date,
        startTime: startTime,
        guest: guest,
        note: note,
      );
      return _reservationApiServices.postReservations(requestModel);
    });
  }

  Future<ApiResult<ReservationResponseModel>> postMultipleReservations({
    required String userId,
    required List<Map<String, dynamic>> reservationsData,
  }) async {
    return ApiSafeCall.call(() async {
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
      return multiResponse.toReservationResponseModel();
    });
  }

  Future<ApiResult<TimeSlotsResponse>> getAvailableTimeSlots({
    required String barberId,
    required String date,
  }) async {
    return ApiSafeCall.call(
      () => _reservationApiServices.getAvailableTimeSlots(barberId, date),
    );
  }

  Future<ApiResult<ReservationResponseModel>> joinQueue({
    required String barberId,
    required List<String> serviceIds,
    String? userId,
    GuestInfo? guest,
    String? note,
  }) async {
    return ApiSafeCall.call(() async {
      final request = JoinQueueRequest(
        barberId: barberId,
        serviceIds: serviceIds,
        userId: userId,
        guest: guest,
        note: note,
      );

      final isGuestBooking = guest != null && userId == null;
      return isGuestBooking
          ? await _queueApiServices.joinQueueGuest(request)
          : await _queueApiServices.joinQueue(request);
    });
  }

  Future<ApiResult<QueueStatusResponse>> getQueueStatus({
    required String barberId,
  }) async {
    return ApiSafeCall.call(
      () => _queueApiServices.getQueueStatus(barberId),
    );
  }

  Future<ApiResult<QueuePositionResponse>> getMyQueuePosition({
    required String reservationId,
  }) async {
    return ApiSafeCall.call(
      () => _queueApiServices.getMyQueuePosition(reservationId),
    );
  }

  Future<ApiResult<void>> advanceQueue({required String barberId}) async {
    return ApiSafeCall.callVoid(
      () => _queueApiServices.advanceQueue(barberId),
    );
  }

  Future<ApiResult<void>> skipCustomer({required String reservationId}) async {
    return ApiSafeCall.callVoid(
      () => _queueApiServices.skipCustomer(reservationId),
    );
  }

  Future<ApiResult<QueueSettingsResponse>> getQueueSettings() async {
    try {
      final response = await _queueApiServices.getQueueSettings();
      return ApiResult.success(response);
    } catch (error) {
      if (error is DioException && error.response?.statusCode == 401) {
        final defaultResponse = QueueSettingsResponse(
          status: 'success',
          data: QueueSettingsData(
            isQueueMode: false,
            queueSettings: QueueSettings(
              maxQueueSize: 0,
              estimatedServiceTime: 0,
              autoAdvanceQueue: false,
            ),
          ),
        );
        return ApiResult.success(defaultResponse);
      }
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<OtpResponse>> requestGuestVerification({
    required String phone,
  }) async {
    return ApiSafeCall.call(
      () => _reservationApiServices.requestGuestVerification(
        OtpRequest(phone: phone),
      ),
    );
  }

  Future<ApiResult<ReservationResponseModel>> verifyAndCreateGuestReservation({
    required String phone,
    required String otp,
    required String userName,
    required String barberId,
    required List<String> serviceIds,
    required String date,
    required String startTime,
    String? note,
  }) async {
    return ApiSafeCall.call(
      () => _reservationApiServices.verifyAndCreateGuestReservation(
        VerifyOtpAndReserveRequest(
          phone: phone,
          otp: otp,
          userName: userName,
          barberId: barberId,
          serviceIds: serviceIds,
          date: date,
          startTime: startTime,
          note: note,
        ),
      ),
    );
  }
}
