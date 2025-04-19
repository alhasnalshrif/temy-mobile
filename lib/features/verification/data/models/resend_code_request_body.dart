import 'package:json_annotation/json_annotation.dart';
part 'resend_code_request_body.g.dart';

@JsonSerializable()
class ResendCodeRequestBody {
  final String phone;

  ResendCodeRequestBody({
    required this.phone,
  });

  Map<String, dynamic> toJson() => _$ResendCodeRequestBodyToJson(this);
}
