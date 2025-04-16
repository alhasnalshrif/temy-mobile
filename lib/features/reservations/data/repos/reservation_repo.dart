import 'package:flutter_complete_project/core/networking/api_error_handler.dart';
import 'package:flutter_complete_project/core/networking/api_result.dart';
import 'package:flutter_complete_project/features/reservations/data/apis/reservations_api_services.dart';

import 'package:flutter_complete_project/features/reservations/data/models/reservation_detail_request.dart';

class ReservationRepo {
  final ReservationApiServices _reservationApiServices;

  ReservationRepo(this._reservationApiServices);

  Future<ApiResult<ReservationRequestModel>> postReservation() async {
    try {
      final response = await _reservationApiServices.postReservations(
        ReservationRequestModel(
          user: '', // Add your user ID here
          service: [], // Add your service list here
          barber: '', // Add your barber ID here
          date: '', // Add your date here
          status: 'pending', // Set the initial status
        ),
      );
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
