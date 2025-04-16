import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_complete_project/features/reservations/data/repos/reservation_repo.dart';
import 'reservation_state.dart';

class ReservationCubit extends Cubit<ReservationState> {
  final ReservationRepo _reservationRepo;
  final String categoryId;

  ReservationCubit(this._reservationRepo, this.categoryId)
      : super(const ReservationState.initial());

  void postReservation() async {
    emit(const ReservationState.reservationLoading());
    final response = await _reservationRepo.postReservation();
    response.when(
      success: (barberDetailResponseModel) {
        emit(ReservationState.reservationSuccess(barberDetailResponseModel));
      },
      failure: (error) {
        emit(ReservationState.reservationError(error));
      },
    );
  }
}
