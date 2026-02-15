import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/barber/data/repos/barber_repo.dart';
import 'barber_state.dart';

class BarberCubit extends Cubit<BarberState> {
  final BarberRepo _barberRepo;
  final String categoryId;
  int _retryCount = 0;
  static const int _maxRetries = 2;
  static const _timeout = Duration(seconds: 20);

  BarberCubit(this._barberRepo, this.categoryId)
    : super(const BarberState.initial());

  void getBarberDetail() async {
    emit(const BarberState.barberLoading());

    try {
      final response =
          await _barberRepo.getCategory(categoryId).timeout(_timeout);

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
    } on TimeoutException catch (e) {
      if (_retryCount < _maxRetries) {
        _retryCount++;
        Future.delayed(const Duration(milliseconds: 500), () {
          getBarberDetail();
        });
      } else {
        _retryCount = 0;
        emit(BarberState.barberError(ErrorHandler.handle(e)));
      }
    } catch (e) {
      emit(BarberState.barberError(ErrorHandler.handle(e)));
    }
  }

  void retry() {
    _retryCount = 0;
    getBarberDetail();
  }
}
