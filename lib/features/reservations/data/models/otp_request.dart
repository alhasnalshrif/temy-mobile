import 'package:json_annotation/json_annotation.dart';

part 'otp_request.g.dart';

// Request model for requesting OTP
@JsonSerializable()
class OtpRequest {
  final String phone;

  OtpRequest({required this.phone});

  factory OtpRequest.fromJson(Map<String, dynamic> json) =>
      _$OtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OtpRequestToJson(this);
}

// Request model for verifying OTP and creating guest reservation
@JsonSerializable()
class VerifyOtpAndReserveRequest {
  final String phone;
  final String otp;
  final String userName;
  final String barberId;
  final List<String> serviceIds;
  final String date;
  final String startTime;
  final String? note;

  VerifyOtpAndReserveRequest({
    required this.phone,
    required this.otp,
    required this.userName,
    required this.barberId,
    required this.serviceIds,
    required this.date,
    required this.startTime,
    this.note,
  });

  factory VerifyOtpAndReserveRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpAndReserveRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpAndReserveRequestToJson(this);
}
