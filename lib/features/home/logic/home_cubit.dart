import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/home/data/repos/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  static const _timeout = Duration(seconds: 20);

  void getCategories() async {
    emit(const HomeState.categoriesLoading());

    try {
      final response = await _homeRepo.getCategorie().timeout(_timeout);
      response.when(
        success: (categoriesResponseModel) {
          emit(HomeState.categoriesSuccess(categoriesResponseModel));
        },
        failure: (error) {
          emit(HomeState.categoriesError(error));
        },
      );
    } on TimeoutException catch (e) {
      emit(HomeState.categoriesError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(HomeState.categoriesError(ErrorHandler.handle(e)));
    }
  }

  void getBarbers() async {
    emit(const HomeState.barbersLoading());

    try {
      final response = await _homeRepo.getBarbers().timeout(_timeout);
      response.when(
        success: (barbersResponseModel) {
          emit(HomeState.barbersSuccess(barbersResponseModel));
        },
        failure: (error) {
          emit(HomeState.barbersError(error));
        },
      );
    } on TimeoutException catch (e) {
      emit(HomeState.barbersError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(HomeState.barbersError(ErrorHandler.handle(e)));
    }
  }

  void getBanners() async {
    emit(const HomeState.bannersLoading());

    try {
      final response = await _homeRepo.getBanners().timeout(_timeout);
      response.when(
        success: (bannersResponseModel) {
          emit(HomeState.bannersSuccess(bannersResponseModel));
        },
        failure: (error) {
          emit(HomeState.bannersError(error));
        },
      );
    } on TimeoutException catch (e) {
      emit(HomeState.bannersError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(HomeState.bannersError(ErrorHandler.handle(e)));
    }
  }

  /// Refreshes all home screen data
  /// Returns a Future that completes when all data is refreshed
  Future<void> refreshHomeData() async {
    // Fetch barbers and banners data in parallel
    await Future.wait([
      _refreshCategories(),
      _refreshBarbers(),
      _refreshBanners(),
    ]);
  }

  // refresh categories
  Future<void> _refreshCategories() async {
    try {
      final response = await _homeRepo.getCategorie().timeout(_timeout);
      response.when(
        success: (categoriesResponseModel) {
          emit(HomeState.categoriesSuccess(categoriesResponseModel));
        },
        failure: (error) {
          emit(HomeState.categoriesError(error));
        },
      );
    } on TimeoutException catch (e) {
      emit(HomeState.categoriesError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(HomeState.categoriesError(ErrorHandler.handle(e)));
    }
  }

  Future<void> _refreshBarbers() async {
    try {
      final response = await _homeRepo.getBarbers().timeout(_timeout);
      response.when(
        success: (barbersResponseModel) {
          emit(HomeState.barbersSuccess(barbersResponseModel));
        },
        failure: (error) {
          emit(HomeState.barbersError(error));
        },
      );
    } on TimeoutException catch (e) {
      emit(HomeState.barbersError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(HomeState.barbersError(ErrorHandler.handle(e)));
    }
  }

  Future<void> _refreshBanners() async {
    try {
      final response = await _homeRepo.getBanners().timeout(_timeout);
      response.when(
        success: (bannersResponseModel) {
          emit(HomeState.bannersSuccess(bannersResponseModel));
        },
        failure: (error) {
          emit(HomeState.bannersError(error));
        },
      );
    } on TimeoutException catch (e) {
      emit(HomeState.bannersError(ErrorHandler.handle(e)));
    } catch (e) {
      emit(HomeState.bannersError(ErrorHandler.handle(e)));
    }
  }
}
