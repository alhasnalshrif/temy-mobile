// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) => UserProfile(
      message: json['message'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserProfileToJson(UserProfile instance) =>
    <String, dynamic>{
      'message': instance.message,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      countryCode: json['countryCode'] as String?,
      role: json['role'] as String?,
      verified: json['verified'] as bool?,
      verificationCode: json['verificationCode'] as String?,
      verificationCodeExpires: json['verificationCodeExpires'] as String?,
      resetPasswordCode: json['resetPasswordCode'] as String?,
      avatar: json['avatar'] as String?,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
      'countryCode': instance.countryCode,
      'role': instance.role,
      'verified': instance.verified,
      'verificationCode': instance.verificationCode,
      'verificationCodeExpires': instance.verificationCodeExpires,
      'resetPasswordCode': instance.resetPasswordCode,
      'avatar': instance.avatar,
      '__v': instance.version,
    };
