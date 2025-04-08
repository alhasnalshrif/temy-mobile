// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupResponse _$SignupResponseFromJson(Map<String, dynamic> json) =>
    SignupResponse(
      status: json['status'] as String?,
      data: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
    );

Map<String, dynamic> _$SignupResponseToJson(SignupResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'token': instance.token,
      'data': instance.data,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      name: json['name'] as String?,
      phone: json['phone'] as String?,
      countryCode: json['countryCode'] as String?,
      role: json['role'] as String?,
      verified: json['verified'] as bool?,
      verificationCode: json['verificationCode'] as String?,
      verificationCodeExpires: json['verificationCodeExpires'] as String?,
      resetPasswordCode: json['resetPasswordCode'] as String?,
      avatar: json['avatar'] as String?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'countryCode': instance.countryCode,
      'role': instance.role,
      'verified': instance.verified,
      'verificationCode': instance.verificationCode,
      'verificationCodeExpires': instance.verificationCodeExpires,
      'resetPasswordCode': instance.resetPasswordCode,
      'avatar': instance.avatar,
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
    };
