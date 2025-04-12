import 'package:dio/dio.dart';
import 'package:flutter_complete_project/core/networking/api_constants.dart';
import 'package:flutter_complete_project/features/category/data/apis/category_api_constants.dart';
import 'package:flutter_complete_project/features/category/data/models/category_response.dart';
import 'package:retrofit/retrofit.dart';

part 'category_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class CategoryApiServices {
  factory CategoryApiServices(Dio dio) = _CategoryApiServices;

  @GET("${CategoryApiConstants.category}/{id}")
  Future<CategoryResponseModel> getCategory(@Path("id") String categoryId);
}
