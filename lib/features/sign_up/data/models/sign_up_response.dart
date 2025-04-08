import 'package:json_annotation/json_annotation.dart';
part 'sign_up_response.g.dart';

@JsonSerializable()
class SignupResponse {
  String? status;
  String? token;
  @JsonKey(name: 'data')
  UserData? data;

  SignupResponse({this.status, this.data, this.token});

  factory SignupResponse.fromJson(Map<String, dynamic> json) =>
      _$SignupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SignupResponseToJson(this);
}

@JsonSerializable()
class UserData {
  User? user;

  UserData({this.user});

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}

@JsonSerializable()
class User {
  String? name;
  String? phone;
  String? countryCode;
  String? role;
  bool? verified;
  String? verificationCode;
  String? verificationCodeExpires;
  String? resetPasswordCode;
  String? avatar;
  @JsonKey(name: '_id')
  String? id;
  String? createdAt;
  String? updatedAt;
  @JsonKey(name: '__v')
  int? version;

  User({
    this.name,
    this.phone,
    this.countryCode,
    this.role,
    this.verified,
    this.verificationCode,
    this.verificationCodeExpires,
    this.resetPasswordCode,
    this.avatar,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
