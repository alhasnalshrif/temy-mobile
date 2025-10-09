import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:temy_barber/features/reservations/data/models/queue_response.dart';

part 'queue_state.freezed.dart';

@freezed
class QueueState with _$QueueState {
  const factory QueueState.initial() = _Initial;

  // Join Queue States
  const factory QueueState.joinQueueLoading() = JoinQueueLoading;
  const factory QueueState.joinQueueSuccess(QueuePositionData data) =
      JoinQueueSuccess;
  const factory QueueState.joinQueueError(String error) = JoinQueueError;

  // Queue Status States
  const factory QueueState.queueStatusLoading() = QueueStatusLoading;
  const factory QueueState.queueStatusSuccess(QueueStatusData data) =
      QueueStatusSuccess;
  const factory QueueState.queueStatusError(String error) = QueueStatusError;

  // Queue Position States
  const factory QueueState.queuePositionLoading() = QueuePositionLoading;
  const factory QueueState.queuePositionSuccess(QueuePositionData data) =
      QueuePositionSuccess;
  const factory QueueState.queuePositionError(String error) =
      QueuePositionError;

  // Queue Action States
  const factory QueueState.queueActionLoading() = QueueActionLoading;
  const factory QueueState.queueActionSuccess(String message) =
      QueueActionSuccess;
  const factory QueueState.queueActionError(String error) = QueueActionError;
}
