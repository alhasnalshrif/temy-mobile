import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/features/barber/data/repos/barber_repo.dart';
import 'barber_state.dart';

class BarberCubit extends Cubit<BarberState> {
  final BarberRepo _barberRepo;
  final String categoryId;
  int _retryCount = 0;
  static const int _maxRetries = 2;

  BarberCubit(this._barberRepo, this.categoryId)
    : super(const BarberState.initial());

  void getBarberDetail() async {
    emit(const BarberState.barberLoading());
    final response = await _barberRepo.getCategory(categoryId);
    response.when(
      success: (barberDetailResponseModel) {
        _retryCount = 0; // Reset retry count on success
        emit(BarberState.barberSuccess(barberDetailResponseModel));
      },
      failure: (error) {
        // Auto-retry on failure up to max retries
        if (_retryCount < _maxRetries) {
          _retryCount++;
          Future.delayed(const Duration(milliseconds: 500), () {
            getBarberDetail();
          });
        } else {
          _retryCount = 0; // Reset for manual retry
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
