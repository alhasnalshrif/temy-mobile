import 'package:temy_barber/core/networking/api_safe_call.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/category_barbers/data/apis/category_api_services.dart';
import 'package:temy_barber/features/category_barbers/data/models/category_response.dart';

class CategoryBarberRepo {
  final CategoryBarberApiServices _categoryApiServices;

  CategoryBarberRepo(this._categoryApiServices);

  Future<ApiResult<CategoryServicesResponseModel>> getCategoryWithBarbers(
      String categoryId) async {
    return ApiSafeCall.call(
      () => _categoryApiServices.getCategoryWithBarbers(categoryId),
    );
  }
}
