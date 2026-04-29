import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/home/data/repos/home_repo.dart';
import 'home_state.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  void getCategories() async {
    emit(const HomeState.categoriesLoading());

    executeApi(
      apiCall: () => _homeRepo.getCategorie(),
      onSuccess: (categoriesResponseModel) {
        emit(HomeState.categoriesSuccess(categoriesResponseModel));
      },
      onError: (error) {
        emit(HomeState.categoriesError(error));
      },
    );
  }

  void getBarbers() async {
    emit(const HomeState.barbersLoading());

    executeApi(
      apiCall: () => _homeRepo.getBarbers(),
      onSuccess: (barbersResponseModel) {
        emit(HomeState.barbersSuccess(barbersResponseModel));
      },
      onError: (error) {
        emit(HomeState.barbersError(error));
      },
    );
  }

  void getBanners() async {
    emit(const HomeState.bannersLoading());

    executeApi(
      apiCall: () => _homeRepo.getBanners(),
      onSuccess: (bannersResponseModel) {
        emit(HomeState.bannersSuccess(bannersResponseModel));
      },
      onError: (error) {
        emit(HomeState.bannersError(error));
      },
    );
  }

  Future<void> refreshHomeData() async {
    await Future.wait([
      _refreshCategories(),
      _refreshBarbers(),
      _refreshBanners(),
    ]);
  }

  Future<void> _refreshCategories() async {
    executeApi(
      apiCall: () => _homeRepo.getCategorie(),
      onSuccess: (categoriesResponseModel) {
        emit(HomeState.categoriesSuccess(categoriesResponseModel));
      },
      onError: (error) {
        emit(HomeState.categoriesError(error));
      },
    );
  }

  Future<void> _refreshBarbers() async {
    executeApi(
      apiCall: () => _homeRepo.getBarbers(),
      onSuccess: (barbersResponseModel) {
        emit(HomeState.barbersSuccess(barbersResponseModel));
      },
      onError: (error) {
        emit(HomeState.barbersError(error));
      },
    );
  }

  Future<void> _refreshBanners() async {
    executeApi(
      apiCall: () => _homeRepo.getBanners(),
      onSuccess: (bannersResponseModel) {
        emit(HomeState.bannersSuccess(bannersResponseModel));
      },
      onError: (error) {
        emit(HomeState.bannersError(error));
      },
    );
  }
}
