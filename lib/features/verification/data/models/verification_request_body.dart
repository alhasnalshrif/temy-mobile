import 'package:json_annotation/json_annotation.dart';
part 'verification_request_body.g.dart';

@JsonSerializable()
class VerificationRequestBody {
  final String phone;
  final String verificationCode;

  VerificationRequestBody({
    required this.phone,
    required this.verificationCode,
  });

  Map<String, dynamic> toJson() => _$VerificationRequestBodyToJson(this);
}
