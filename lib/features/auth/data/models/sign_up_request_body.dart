import 'package:json_annotation/json_annotation.dart';
part 'sign_up_request_body.g.dart';

@JsonSerializable()
class SignupRequestBody {
  final String name;
  final String phone;
  final String password;
  @JsonKey(name: 'passwordConfirm')
  final String passwordConfirmation;
  final int? gender;

  SignupRequestBody({
    required this.name,
    required this.phone,
    required this.password,
    required this.passwordConfirmation,
    this.gender,
  });

  Map<String, dynamic> toJson() => _$SignupRequestBodyToJson(this);
}
