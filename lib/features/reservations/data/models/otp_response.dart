import 'package:json_annotation/json_annotation.dart';

part 'otp_response.g.dart';

// Response model for OTP request
@JsonSerializable()
class OtpResponse {
  final String status;
  final String message;

  OtpResponse({required this.status, required this.message});

  factory OtpResponse.fromJson(Map<String, dynamic> json) =>
      _$OtpResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OtpResponseToJson(this);
}
