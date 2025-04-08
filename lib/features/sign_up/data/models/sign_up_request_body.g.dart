// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignupRequestBody _$SignupRequestBodyFromJson(Map<String, dynamic> json) =>
    SignupRequestBody(
      name: json['name'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['passwordConfirm'] as String,
      gender: (json['gender'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SignupRequestBodyToJson(SignupRequestBody instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'password': instance.password,
      'passwordConfirm': instance.passwordConfirmation,
      'gender': instance.gender,
    };
