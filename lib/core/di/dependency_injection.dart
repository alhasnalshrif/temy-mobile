import 'package:dio/dio.dart';
import 'package:temy_barber/core/networking/api_service.dart';
import 'package:temy_barber/core/networking/dio_factory.dart';
import 'package:temy_barber/features/barber/data/apis/barber_api_services.dart';
import 'package:temy_barber/features/barber/data/repos/barber_repo.dart';
import 'package:temy_barber/features/booking/data/apis/booking_api_services.dart';
import 'package:temy_barber/features/booking/data/repos/booking_repo.dart';
import 'package:temy_barber/features/category/data/apis/category_api_services.dart';
import 'package:temy_barber/features/category/data/repos/category_repo.dart';
import 'package:temy_barber/features/home/data/apis/home_api_services.dart';
import 'package:temy_barber/features/home/data/repos/home_repo.dart';
import 'package:temy_barber/features/profile/data/apis/profile_api_services.dart';
import 'package:temy_barber/features/profile/data/repos/profile_repo.dart';
import 'package:temy_barber/features/profile/logic/update_profile_cubit.dart';
import 'package:temy_barber/features/reservations/data/apis/reservations_api_services.dart';
import 'package:get_it/get_it.dart';

import '../../features/login/data/repos/login_repo.dart';
import '../../features/login/logic/cubit/login_cubit.dart';
import '../../features/sign_up/data/repos/sign_up_repo.dart';
import '../../features/sign_up/logic/sign_up_cubit.dart';
import '../../features/reservations/data/repos/reservation_repo.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Dio & ApiService
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton<ApiService>(() => ApiService(dio));

  // login
  getIt.registerLazySingleton<LoginRepo>(() => LoginRepo(getIt()));
  getIt.registerFactory<LoginCubit>(() => LoginCubit(getIt()));

  // signup
  getIt.registerLazySingleton<SignupRepo>(() => SignupRepo(getIt()));
  getIt.registerFactory<SignupCubit>(() => SignupCubit(getIt()));

  // reservation
  getIt.registerLazySingleton<ReservationApiServices>(
      () => ReservationApiServices(dio));
  getIt.registerLazySingleton<ReservationRepo>(() => ReservationRepo(getIt()));

  // home
  getIt.registerLazySingleton<HomeApiServices>(() => HomeApiServices(dio));
  getIt.registerLazySingleton<HomeRepo>(() => HomeRepo(getIt()));

  getIt
      .registerLazySingleton<ProfileApiServices>(() => ProfileApiServices(dio));
  getIt.registerLazySingleton<ProfileRepo>(() => ProfileRepo(getIt()));

  getIt.registerLazySingleton<CategoryApiServices>(
      () => CategoryApiServices(dio));
  getIt.registerLazySingleton<CategoryRepo>(() => CategoryRepo(getIt()));

  getIt.registerLazySingleton<BarberApiServices>(() => BarberApiServices(dio));
  getIt.registerLazySingleton<BarberRepo>(() => BarberRepo(getIt()));

  getIt
      .registerLazySingleton<BookingApiServices>(() => BookingApiServices(dio));
  getIt.registerLazySingleton<BookingRepo>(() => BookingRepo(getIt()));
  getIt.registerFactory<UpdateProfileCubit>(
      () => UpdateProfileCubit(getIt())); // Add this line
}
