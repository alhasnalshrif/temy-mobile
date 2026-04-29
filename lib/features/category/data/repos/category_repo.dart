import 'package:temy_barber/core/networking/api_safe_call.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/category/data/apis/category_api_services.dart';
import 'package:temy_barber/features/category/data/models/categories_list_response.dart';

class CategoryRepo {
  final CategoryApiServices _categoryApiServices;

  CategoryRepo(this._categoryApiServices);

  Future<ApiResult<CategoriesListResponseModel>> getCategory() async {
    return ApiSafeCall.call(() => _categoryApiServices.getCategory());
  }
}
