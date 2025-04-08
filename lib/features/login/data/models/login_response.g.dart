// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      status: json['status'] as String?,
      token: json['token'] as String?,
      data: json['data'] == null
          ? null
          : ResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'token': instance.token,
      'data': instance.data,
    };

ResponseData _$ResponseDataFromJson(Map<String, dynamic> json) => ResponseData(
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ResponseDataToJson(ResponseData instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

UserData _$UserDataFromJson(Map<String, dynamic> json) => UserData(
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
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      version: (json['__v'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
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
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.version,
    };
