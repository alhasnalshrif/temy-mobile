import 'package:dio/dio.dart';
import 'package:temy_barber/core/networking/api_constants.dart';
import 'package:temy_barber/features/category/data/apis/category_api_constants.dart';
import 'package:temy_barber/features/category/data/models/category_services_response.dart';
import 'package:temy_barber/features/category/data/models/service_response.dart';
import 'package:retrofit/retrofit.dart';

part 'category_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class CategoryApiServices {
  factory CategoryApiServices(Dio dio, {ParseErrorLogger? errorLogger}) =
      _CategoryApiServices;

  @GET("${CategoryApiConstants.services}?category={categoryId}")
  Future<ServiceResponseModel> getCategory(
      @Path("categoryId") String categoryId);

  @GET("category/{categoryId}/services")
  Future<CategoryServicesResponse> getCategoryWithBarbers(
      @Path("categoryId") String categoryId);
}
