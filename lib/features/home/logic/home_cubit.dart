import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/features/home/data/repos/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  void getCategories() async {
    emit(const HomeState.categoriesLoading());
    final response = await _homeRepo.getCategorie();
    response.when(
      success: (categoriesResponseModel) {
        emit(HomeState.categoriesSuccess(categoriesResponseModel));
      },
      failure: (error) {
        emit(HomeState.categoriesError(error));
      },
    );
  }

  void getBarbers() async {
    emit(const HomeState.barbersLoading());
    final response = await _homeRepo.getBarbers();
    response.when(
      success: (barbersResponseModel) {
        emit(HomeState.barbersSuccess(barbersResponseModel));
      },
      failure: (error) {
        emit(HomeState.barbersError(error));
      },
    );
  }

  void getBanners() async {
    emit(const HomeState.bannersLoading());
    final response = await _homeRepo.getBanners();
    response.when(
      success: (bannersResponseModel) {
        emit(HomeState.bannersSuccess(bannersResponseModel));
      },
      failure: (error) {
        emit(HomeState.bannersError(error));
      },
    );
  }
}
