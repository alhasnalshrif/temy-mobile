import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/barber/data/apis/barber_api_services.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';

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
