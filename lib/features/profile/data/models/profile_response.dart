import 'package:json_annotation/json_annotation.dart';

part 'profile_response.g.dart';

@JsonSerializable()
class UserProfile {
  final String? message; // Add message field

  final User? user; // Wrap existing fields in a User object

  UserProfile({
    this.message,
    this.user,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@JsonSerializable()
class User {
  @JsonKey(name: '_id')
  final String? id;

  final String? name;
  final String? phone;
  final String? countryCode;
  final String? role;
  final bool? verified;
  final String? verificationCode;
  final String? verificationCodeExpires;

  @JsonKey(includeIfNull: true)
  final String? resetPasswordCode;

  final String? avatar;

  @JsonKey(name: '__v')
  final int? version;

  User({
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
    this.version,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
