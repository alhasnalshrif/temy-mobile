import 'package:dio/dio.dart';
import 'package:flutter_complete_project/core/networking/api_constants.dart';
import 'package:flutter_complete_project/features/booking/data/apis/home_api_constants.dart';
import 'package:flutter_complete_project/features/booking/data/models/category_response.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class HomeApiServices {
  factory HomeApiServices(Dio dio) = _HomeApiServices;

  @GET(HomeApiConstants.category)
  Future<CategoryResponseModel> getCategories();
}
