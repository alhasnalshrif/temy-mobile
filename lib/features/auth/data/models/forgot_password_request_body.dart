 import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_request_body.g.dart';

@JsonSerializable()
class ForgotPasswordRequestBody {
  final String phone;

  ForgotPasswordRequestBody({required this.phone});

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestBodyToJson(this);
}