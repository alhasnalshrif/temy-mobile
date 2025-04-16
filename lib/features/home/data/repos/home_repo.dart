import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/home/data/apis/home_api_services.dart';
import 'package:temy_barber/features/home/data/models/barber_response.dart';
import 'package:temy_barber/features/home/data/models/category_response.dart';
import 'package:temy_barber/features/home/data/models/banner_response.dart';

class HomeRepo {
  final HomeApiServices _homeApiServices;

  HomeRepo(this._homeApiServices);

  Future<ApiResult<CategoryResponseModel>> getCategorie() async {
    try {
      final response = await _homeApiServices.getCategories();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<BarberResponseModel>> getBarbers() async {
    try {
      final response = await _homeApiServices.getBarbers();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

  Future<ApiResult<BannerResponseModel>> getBanners() async {
    try {
      final response = await _homeApiServices.getBanners();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
