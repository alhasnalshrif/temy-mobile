import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/reservations/data/apis/reservations_api_services.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_detail_request.dart';
import 'package:temy_barber/features/reservations/data/models/reservation_response.dart';
import 'package:temy_barber/features/reservations/data/models/time_slots_response.dart';

class ReservationRepo {
  final ReservationApiServices _reservationApiServices;

  ReservationRepo(this._reservationApiServices);

  Future<ApiResult<ReservationResponseModel>> postReservation({
    required String userId,
    required List<String> serviceIds,
    required String barberId,
    required String date,
    required String startTime,
  }) async {
    try {
      final response = await _reservationApiServices.postReservations(
        ReservationRequestModel(
          user: userId,
          serviceIds: serviceIds,
          barberId: barberId,
          date: date,
          startTime: startTime,
        ),
      );
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
          .map((data) => ReservationRequestModel(
                user: userId,
                serviceIds: data['serviceIds'],
                barberId: data['barberId'],
                date: data['date'],
                startTime: data['startTime'],
              ))
          .toList();

      final response =
          await _reservationApiServices.postMultipleReservations(reservations);
      return ApiResult.success(response);
    } catch (error) {
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
}
