// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verification_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VerificationRequestBody _$VerificationRequestBodyFromJson(
        Map<String, dynamic> json) =>
    VerificationRequestBody(
      phone: json['phone'] as String,
      verificationCode: json['verificationCode'] as String,
    );

Map<String, dynamic> _$VerificationRequestBodyToJson(
        VerificationRequestBody instance) =>
    <String, dynamic>{
      'phone': instance.phone,
      'verificationCode': instance.verificationCode,
    };
