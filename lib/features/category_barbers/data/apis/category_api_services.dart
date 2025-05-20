import 'package:dio/dio.dart';
import 'package:temy_barber/core/networking/api_constants.dart';
import 'package:temy_barber/features/category_barbers/data/models/category_response.dart';

import 'package:retrofit/retrofit.dart';

part 'category_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class CategoryBarberApiServices {
  factory CategoryBarberApiServices(Dio dio, {ParseErrorLogger? errorLogger}) =
      _CategoryBarberApiServices;

  // @GET(CategoryApiConstants.category)
  // Future<CategoryResponseModel> getCategory();

  @GET("category/{id}/services")
  Future<CategoryServicesResponseModel> getCategoryWithBarbers(
      @Path("id") String categoryId);
}
