import 'package:json_annotation/json_annotation.dart';

part 'queue_response.g.dart';

@JsonSerializable()
class QueueStatusResponse {
  final String status;
  final QueueStatusData data;

  QueueStatusResponse({required this.status, required this.data});

  factory QueueStatusResponse.fromJson(Map<String, dynamic> json) =>
      _$QueueStatusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QueueStatusResponseToJson(this);
}

@JsonSerializable()
class QueueStatusData {
  final BarberInfo barber;
  final QueueInfo queue;

  QueueStatusData({required this.barber, required this.queue});

  factory QueueStatusData.fromJson(Map<String, dynamic> json) =>
      _$QueueStatusDataFromJson(json);

  Map<String, dynamic> toJson() => _$QueueStatusDataToJson(this);
}

@JsonSerializable()
class BarberInfo {
  final String id;
  final String name;
  final String avatar;

  BarberInfo({required this.id, required this.name, required this.avatar});

  factory BarberInfo.fromJson(Map<String, dynamic> json) =>
      _$BarberInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BarberInfoToJson(this);
}

@JsonSerializable()
class QueueInfo {
  @JsonKey(name: 'total_in_queue')
  final int totalInQueue;

  @JsonKey(name: 'current_customer')
  final QueueCustomer? currentCustomer;

  @JsonKey(name: 'waiting_customers')
  final List<QueueCustomer> waitingCustomers;

  @JsonKey(name: 'estimated_service_time')
  final int estimatedServiceTime;

  QueueInfo({
    required this.totalInQueue,
    this.currentCustomer,
    required this.waitingCustomers,
    required this.estimatedServiceTime,
  });

  factory QueueInfo.fromJson(Map<String, dynamic> json) =>
      _$QueueInfoFromJson(json);

  Map<String, dynamic> toJson() => _$QueueInfoToJson(this);
}

@JsonSerializable()
class QueueCustomer {
  @JsonKey(name: '_id')
  final String id;

  @JsonKey(name: 'userName')
  final String? userName;

  @JsonKey(name: 'userPhone')
  final String? userPhone;

  @JsonKey(name: 'queue_number')
  final int queueNumber;

  @JsonKey(name: 'queue_position')
  final int? queuePosition;

  @JsonKey(name: 'queue_status')
  final String queueStatus;

  @JsonKey(name: 'joined_queue_at')
  final String? joinedQueueAt;

  final List<QueueService> services;

  @JsonKey(name: 'totalDuration')
  final int totalDuration;

  @JsonKey(name: 'totalPrice')
  final double totalPrice;

  QueueCustomer({
    required this.id,
    this.userName,
    this.userPhone,
    required this.queueNumber,
    this.queuePosition,
    required this.queueStatus,
    this.joinedQueueAt,
    required this.services,
    required this.totalDuration,
    required this.totalPrice,
  });

  factory QueueCustomer.fromJson(Map<String, dynamic> json) =>
      _$QueueCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$QueueCustomerToJson(this);
}

@JsonSerializable()
class QueueService {
  @JsonKey(name: '_id')
  final String id;

  final String name;
  final int duration;
  final double price;

  QueueService({
    required this.id,
    required this.name,
    required this.duration,
    required this.price,
  });

  factory QueueService.fromJson(Map<String, dynamic> json) =>
      _$QueueServiceFromJson(json);

  Map<String, dynamic> toJson() => _$QueueServiceToJson(this);
}

@JsonSerializable()
class QueuePositionResponse {
  final String status;
  final QueuePositionData data;

  QueuePositionResponse({required this.status, required this.data});

  factory QueuePositionResponse.fromJson(Map<String, dynamic> json) =>
      _$QueuePositionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$QueuePositionResponseToJson(this);
}

@JsonSerializable()
class QueuePositionData {
  final QueueCustomer reservation;

  @JsonKey(name: 'current_position')
  final int currentPosition;

  @JsonKey(name: 'people_ahead')
  final int peopleAhead;

  @JsonKey(name: 'queue_status')
  final String queueStatus;

  QueuePositionData({
    required this.reservation,
    required this.currentPosition,
    required this.peopleAhead,
    required this.queueStatus,
  });

  factory QueuePositionData.fromJson(Map<String, dynamic> json) =>
      _$QueuePositionDataFromJson(json);

  Map<String, dynamic> toJson() => _$QueuePositionDataToJson(this);
}

@JsonSerializable()
class JoinQueueRequest {
  final String barberId;
  final List<String> serviceIds;
  final String? userId;
  final GuestInfo? guest;
  final String? note;

  JoinQueueRequest({
    required this.barberId,
    required this.serviceIds,
    this.userId,
    this.guest,
    this.note,
  });

  factory JoinQueueRequest.fromJson(Map<String, dynamic> json) =>
      _$JoinQueueRequestFromJson(json);

  Map<String, dynamic> toJson() => _$JoinQueueRequestToJson(this);
}

@JsonSerializable()
class GuestInfo {
  final String name;
  final String phone;

  GuestInfo({required this.name, required this.phone});

  factory GuestInfo.fromJson(Map<String, dynamic> json) =>
      _$GuestInfoFromJson(json);

  Map<String, dynamic> toJson() => _$GuestInfoToJson(this);
}
