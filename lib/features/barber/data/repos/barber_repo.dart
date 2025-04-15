import 'package:flutter_complete_project/core/networking/api_error_handler.dart';
import 'package:flutter_complete_project/core/networking/api_result.dart';
import 'package:flutter_complete_project/features/barber/data/apis/barber_api_services.dart';
import 'package:flutter_complete_project/features/barber/data/models/barber_detail_response.dart';

class BarberRepo {
  final BarberApiServices _barberApiServices;

  BarberRepo(this._barberApiServices);

  Future<ApiResult<BarberDetailResponseModel>> getCategory(
      String categoryId) async {
    try {
      final response = await _barberApiServices.getBarberDetail(categoryId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
