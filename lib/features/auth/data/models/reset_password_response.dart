import 'package:json_annotation/json_annotation.dart';

part 'reset_password_response.g.dart';

@JsonSerializable()
class ResetPasswordResponse {
  String? status;
  String? token;
  @JsonKey(name: 'data')
  ResponseData? data;

  ResetPasswordResponse({this.status, this.token, this.data});

  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}

@JsonSerializable()
class ResponseData {
  @JsonKey(name: 'user')
  UserData? user;

  ResponseData({this.user});

  factory ResponseData.fromJson(Map<String, dynamic> json) =>
      _$ResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseDataToJson(this);
}

@JsonSerializable()
class UserData {
  @JsonKey(name: '_id')
  String? id;
  String? name;
  String? phone;
  String? countryCode;
  String? role;
  bool? verified;
  String? verificationCode;
  String? verificationCodeExpires;
  String? resetPasswordCode;
  String? avatar;
  String? createdAt;
  String? updatedAt;
  @JsonKey(name: '__v')
  int? version;

  UserData({
    this.id,
    this.name,
    this.phone,
    this.countryCode,
    this.role,
    this.verified,
    this.verificationCode,
    this.verificationCodeExpires,
    this.resetPasswordCode,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}