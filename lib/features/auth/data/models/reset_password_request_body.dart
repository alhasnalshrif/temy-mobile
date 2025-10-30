import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request_body.g.dart';

@JsonSerializable()
class ResetPasswordRequestBody {
  final String phone;
  final String code;
  @JsonKey(name: 'newPassword')
  final String newPassword;
  @JsonKey(name: 'passwordConfirm')
  final String passwordConfirm;

  ResetPasswordRequestBody({
    required this.phone,
    required this.code,
    required this.newPassword,
    required this.passwordConfirm,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordRequestBodyToJson(this);
}