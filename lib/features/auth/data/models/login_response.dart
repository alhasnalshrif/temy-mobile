import 'package:json_annotation/json_annotation.dart';
part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  String? status;
  String? token;
  @JsonKey(name: 'data')
  ResponseData? data;

  LoginResponse({this.status, this.token, this.data});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
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
