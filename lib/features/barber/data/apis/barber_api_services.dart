import 'package:dio/dio.dart';
import 'package:temy_barber/core/networking/api_constants.dart';
import 'package:temy_barber/features/barber/data/apis/barber_api_constants.dart';
import 'package:temy_barber/features/barber/data/models/barber_detail_response.dart';
import 'package:retrofit/retrofit.dart';

part 'barber_api_services.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class BarberApiServices {
  factory BarberApiServices(Dio dio) = _BarberApiServices;

  // @GET(BarberApiConstants.barbers)
  // Future<ServiceResponseModel> getBarber();

  @GET('${BarberApiConstants.barbers}/{barberId}')
  Future<BarberDetailResponseModel> getBarberDetail(
      @Path('barberId') String barberId);
}
