import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/core/logic/base_cubit.dart';
import 'package:temy_barber/features/reservations/data/repos/reservation_repo.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'queue_state.dart';

class QueueCubit extends BaseCubit<QueueState> {
  final ReservationRepo _reservationRepo;
  Timer? _pollingTimer;

  QueueCubit(this._reservationRepo) : super(const QueueState.initial());

  void joinQueue({
    required String barberId,
    required List<String> serviceIds,
    String? userId,
    GuestInfo? guest,
    String? note,
  }) async {
    emit(const QueueState.joinQueueLoading());

    executeApi(
      apiCall: () => _reservationRepo.joinQueue(
        barberId: barberId,
        serviceIds: serviceIds,
        userId: userId,
        guest: guest,
        note: note,
      ),
      onSuccess: (reservationResponse) {
        getMyQueuePosition(reservationResponse.data.id);
      },
      onError: (error) {
        emit(
          QueueState.joinQueueError(
            error.apiErrorModel.message ?? 'Failed to join queue',
          ),
        );
      },
    );
  }

  void getQueueStatus({required String barberId}) async {
    emit(const QueueState.queueStatusLoading());

    executeApi(
      apiCall: () => _reservationRepo.getQueueStatus(barberId: barberId),
      onSuccess: (queueStatusResponse) {
        emit(QueueState.queueStatusSuccess(queueStatusResponse.data));
      },
      onError: (error) {
        emit(
          QueueState.queueStatusError(
            error.apiErrorModel.message ?? 'Failed to get queue status',
          ),
        );
      },
    );
  }

  void getMyQueuePosition(String reservationId) async {
    emit(const QueueState.queuePositionLoading());

    executeApi(
      apiCall: () => _reservationRepo.getMyQueuePosition(
        reservationId: reservationId,
      ),
      onSuccess: (queuePositionResponse) {
        emit(QueueState.queuePositionSuccess(queuePositionResponse.data));
      },
      onError: (error) {
        emit(
          QueueState.queuePositionError(
            error.apiErrorModel.message ?? 'Failed to get queue position',
          ),
        );
      },
    );
  }

  void startPollingQueuePosition(
    String reservationId, {
    int intervalSeconds = 10,
  }) {
    stopPolling();
    _pollingTimer = Timer.periodic(Duration(seconds: intervalSeconds), (timer) {
      getMyQueuePosition(reservationId);
    });
    getMyQueuePosition(reservationId);
  }

  void startPollingQueueStatus(String barberId, {int intervalSeconds = 5}) {
    stopPolling();
    _pollingTimer = Timer.periodic(Duration(seconds: intervalSeconds), (timer) {
      getQueueStatus(barberId: barberId);
    });
    getQueueStatus(barberId: barberId);
  }

  void stopPolling() {
    _pollingTimer?.cancel();
    _pollingTimer = null;
  }

  void advanceQueue(String barberId) async {
    emit(const QueueState.queueActionLoading());

    executeApi(
      apiCall: () => _reservationRepo.advanceQueue(barberId: barberId),
      onSuccess: (_) {
        emit(const QueueState.queueActionSuccess('Queue advanced successfully'));
        getQueueStatus(barberId: barberId);
      },
      onError: (error) {
        emit(
          QueueState.queueActionError(
            error.apiErrorModel.message ?? 'Failed to advance queue',
          ),
        );
      },
    );
  }

  void skipCustomer(String reservationId, String barberId) async {
    emit(const QueueState.queueActionLoading());

    executeApi(
      apiCall: () => _reservationRepo.skipCustomer(
        reservationId: reservationId,
      ),
      onSuccess: (_) {
        emit(const QueueState.queueActionSuccess('Customer skipped'));
        getQueueStatus(barberId: barberId);
      },
      onError: (error) {
        emit(
          QueueState.queueActionError(
            error.apiErrorModel.message ?? 'Failed to skip customer',
          ),
        );
      },
    );
  }

  @override
  Future<void> close() {
    stopPolling();
    return super.close();
  }
}
