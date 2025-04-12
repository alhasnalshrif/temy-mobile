import 'package:flutter_complete_project/core/networking/api_error_handler.dart';
import 'package:flutter_complete_project/core/networking/api_result.dart';
import 'package:flutter_complete_project/features/category/data/apis/category_api_services.dart';
import 'package:flutter_complete_project/features/category/data/models/service_response.dart';

class CategoryRepo {
  final CategoryApiServices _categoryApiServices;

  CategoryRepo(this._categoryApiServices);

  Future<ApiResult<ServiceResponseModel>> getCategory(String categoryId) async {
    try {
      final response = await _categoryApiServices.getCategory(categoryId);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }
}
