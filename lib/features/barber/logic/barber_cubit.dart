import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/features/barber/data/repos/barber_repo.dart';
import 'barber_state.dart';

class BarberCubit extends Cubit<BarberState> {
  final BarberRepo _barberRepo;
  final String categoryId;

  BarberCubit(this._barberRepo, this.categoryId)
      : super(const BarberState.initial());



  void getBarberDetail() async {
    emit(const BarberState.barberLoading());
    final response = await _barberRepo.getCategory(categoryId);
    response.when(
      success: (barberDetailResponseModel) {
        emit(BarberState.barberSuccess(barberDetailResponseModel));
      },
      failure: (error) {
        emit(BarberState.barberError(error));
      },
    );
  }
}
