import 'package:dio/dio.dart';
import 'package:temy_barber/core/networking/api_constants.dart';
import 'package:temy_barber/features/category/data/apis/category_api_constants.dart';
import 'package:temy_barber/features/category/data/models/categories_list_response.dart';

import 'package:retrofit/retrofit.dart';

part 'category_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class CategoryApiServices {
  factory CategoryApiServices(Dio dio, {ParseErrorLogger? errorLogger}) =
      _CategoryApiServices;

  @GET(CategoryApiConstants.category)
  Future<CategoriesListResponseModel> getCategory();


}
