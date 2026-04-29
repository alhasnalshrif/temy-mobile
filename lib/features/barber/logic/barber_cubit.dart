import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/barber/data/repos/barber_repo.dart';
import 'barber_state.dart';

class BarberCubit extends BaseCubit<BarberState> {
  final BarberRepo _barberRepo;
  final String categoryId;
  int _retryCount = 0;
  static const int _maxRetries = 2;

  BarberCubit(this._barberRepo, this.categoryId)
    : super(const BarberState.initial());

  void getBarberDetail() async {
    emit(const BarberState.barberLoading());

    executeApi(
      apiCall: () => _barberRepo.getCategory(categoryId),
      onSuccess: (barberDetailResponseModel) {
        _retryCount = 0;
        emit(BarberState.barberSuccess(barberDetailResponseModel));
      },
      onError: (error) {
        if (_retryCount < _maxRetries) {
          _retryCount++;
          Future.delayed(const Duration(milliseconds: 500), () {
            getBarberDetail();
          });
        } else {
          _retryCount = 0;
          emit(BarberState.barberError(error));
        }
      },
    );
  }

  void retry() {
    _retryCount = 0;
    getBarberDetail();
  }
}
