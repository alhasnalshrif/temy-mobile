import 'package:flutter_complete_project/core/networking/api_error_handler.dart';
import 'package:flutter_complete_project/core/networking/api_result.dart';
import 'package:flutter_complete_project/features/home/data/apis/home_api_services.dart';
import 'package:flutter_complete_project/features/home/data/models/barber_response.dart';
import 'package:flutter_complete_project/features/home/data/models/category_response.dart';
import 'package:flutter_complete_project/features/home/data/models/banner_response.dart';

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
