import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/networking/api_result.dart';
import 'package:temy_barber/core/networking/api_error_handler.dart';
import 'package:temy_barber/features/reservations/data/repos/reservation_repo.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'queue_state.dart';

class QueueCubit extends Cubit<QueueState> {
  final ReservationRepo _reservationRepo;
  Timer? _pollingTimer;
  static const _timeout = Duration(seconds: 20);

  QueueCubit(this._reservationRepo) : super(const QueueState.initial());

  // Join queue
  void joinQueue({
    required String barberId,
    required List<String> serviceIds,
    String? userId,
    GuestInfo? guest,
    String? note,
  }) async {
    emit(const QueueState.joinQueueLoading());

    try {
      final response = await _reservationRepo
          .joinQueue(
            barberId: barberId,
            serviceIds: serviceIds,
            userId: userId,
            guest: guest,
            note: note,
          )
          .timeout(_timeout);

      response.when(
        success: (reservationResponse) {
          // After joining, get to position
          getMyQueuePosition(reservationResponse.data.id);
        },
        failure: (error) {
          emit(
            QueueState.joinQueueError(
              error.apiErrorModel.message ?? 'Failed to join queue',
            ),
          );
        },
      );
    } on TimeoutException catch (e) {
      emit(
        QueueState.joinQueueError(ErrorHandler.handle(e).toString()),
      );
    } catch (e) {
      emit(QueueState.joinQueueError(ErrorHandler.handle(e).toString()));
    }
  }

  // Get queue status for a barber
  void getQueueStatus({required String barberId}) async {
    emit(const QueueState.queueStatusLoading());

    try {
      final response =
          await _reservationRepo.getQueueStatus(barberId: barberId).timeout(_timeout);

      response.when(
        success: (queueStatusResponse) {
          emit(QueueState.queueStatusSuccess(queueStatusResponse.data));
        },
        failure: (error) {
          emit(
            QueueState.queueStatusError(
              error.apiErrorModel.message ?? 'Failed to get queue status',
            ),
          );
        },
      );
    } on TimeoutException catch (e) {
      emit(
        QueueState.queueStatusError(ErrorHandler.handle(e).toString()),
      );
    } catch (e) {
      emit(QueueState.queueStatusError(ErrorHandler.handle(e).toString()));
    }
  }

  // Get my queue position
  void getMyQueuePosition(String reservationId) async {
    emit(const QueueState.queuePositionLoading());

    try {
      final response = await _reservationRepo
          .getMyQueuePosition(
            reservationId: reservationId,
          )
          .timeout(_timeout);

      response.when(
        success: (queuePositionResponse) {
          emit(QueueState.queuePositionSuccess(queuePositionResponse.data));
        },
        failure: (error) {
          emit(
            QueueState.queuePositionError(
              error.apiErrorModel.message ?? 'Failed to get queue position',
            ),
          );
        },
      );
    } on TimeoutException catch (e) {
      emit(
        QueueState.queuePositionError(ErrorHandler.handle(e).toString()),
      );
    } catch (e) {
      emit(QueueState.queuePositionError(ErrorHandler.handle(e).toString()));
    }
  }

  // Start polling queue position (for real-time updates)
  void startPollingQueuePosition(
    String reservationId, {
    int intervalSeconds = 10,
  }) {
    stopPolling();

    _pollingTimer = Timer.periodic(Duration(seconds: intervalSeconds), (timer) {
      getMyQueuePosition(reservationId);
    });

    // Get initial position
    getMyQueuePosition(reservationId);
  }

  // Start polling queue status (for barber view)
  void startPollingQueueStatus(String barberId, {int intervalSeconds = 5}) {
    stopPolling();

    _pollingTimer = Timer.periodic(Duration(seconds: intervalSeconds), (timer) {
      getQueueStatus(barberId: barberId);
    });

    // Get initial status
    getQueueStatus(barberId: barberId);
  }

  // Stop polling
  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  // Advance queue (for barber/admin/cashier)
  void advanceQueue(String barberId) async {
    emit(const QueueState.queueActionLoading());

    try {
      final response =
          await _reservationRepo.advanceQueue(barberId: barberId).timeout(_timeout);

      response.when(
        success: (_) {
          emit(
            const QueueState.queueActionSuccess('Queue advanced successfully'),
          );
          // Refresh queue status after action
          getQueueStatus(barberId: barberId);
        },
        failure: (error) {
          emit(
            QueueState.queueActionError(
              error.apiErrorModel.message ?? 'Failed to advance queue',
            ),
          );
        },
      );
    } on TimeoutException catch (e) {
      emit(
        QueueState.queueActionError(ErrorHandler.handle(e).toString()),
      );
    } catch (e) {
      emit(QueueState.queueActionError(ErrorHandler.handle(e).toString()));
    }
  }

  // Skip customer (for barber/admin/cashier)
  void skipCustomer(String reservationId, String barberId) async {
    emit(const QueueState.queueActionLoading());

    try {
      final response = await _reservationRepo
          .skipCustomer(
            reservationId: reservationId,
          )
          .timeout(_timeout);

      response.when(
        success: (_) {
          emit(const QueueState.queueActionSuccess('Customer skipped'));
          // Refresh queue status after action
          getQueueStatus(barberId: barberId);
        },
        failure: (error) {
          emit(
            QueueState.queueActionError(
              error.apiErrorModel.message ?? 'Failed to skip customer',
            ),
          );
        },
      );
    } on TimeoutException catch (e) {
      emit(
        QueueState.queueActionError(ErrorHandler.handle(e).toString()),
      );
    } catch (e) {
      emit(QueueState.queueActionError(ErrorHandler.handle(e).toString()));
    }
  }

  @override
  Future<void> close() {
    stopPolling();
    return super.close();
  }
}
