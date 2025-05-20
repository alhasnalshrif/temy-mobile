import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/category/data/apis/category_api_services.dart';
import 'package:temy_barber/features/category/data/models/categories_list_response.dart';


class CategoryRepo {
  final CategoryApiServices _categoryApiServices;

  CategoryRepo(this._categoryApiServices);

  Future<ApiResult<CategoriesListResponseModel>> getCategory( ) async {
    try {
      final response = await _categoryApiServices.getCategory();
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ErrorHandler.handle(error));
    }
  }

 
}
