import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temy_barber/features/reservations/data/repos/reservation_repo.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';
import 'queue_state.dart';

class QueueCubit extends Cubit<QueueState> {
  final ReservationRepo _reservationRepo;
  Timer? _pollingTimer;

  QueueCubit(this._reservationRepo) : super(const QueueState.initial());

  // Join the queue
  void joinQueue({
    required String barberId,
    required List<String> serviceIds,
    String? userId,
    GuestInfo? guest,
    String? note,
  }) async {
    emit(const QueueState.joinQueueLoading());

    final response = await _reservationRepo.joinQueue(
      barberId: barberId,
      serviceIds: serviceIds,
      userId: userId,
      guest: guest,
      note: note,
    );

    response.when(
      success: (reservationResponse) {
        // After joining, get the position
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
  }

  // Get queue status for a barber
  void getQueueStatus({required String barberId}) async {
    emit(const QueueState.queueStatusLoading());

    final response = await _reservationRepo.getQueueStatus(barberId: barberId);

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
  }

  // Get my queue position
  void getMyQueuePosition(String reservationId) async {
    emit(const QueueState.queuePositionLoading());

    final response = await _reservationRepo.getMyQueuePosition(
      reservationId: reservationId,
    );

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

    final response = await _reservationRepo.advanceQueue(barberId: barberId);

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
  }

  // Skip customer (for barber/admin/cashier)
  void skipCustomer(String reservationId, String barberId) async {
    emit(const QueueState.queueActionLoading());

    final response = await _reservationRepo.skipCustomer(
      reservationId: reservationId,
    );

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
  }

  @override
  Future<void> close() {
    stopPolling();
    return super.close();
  }
}
