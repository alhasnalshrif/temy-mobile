// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barber_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarberDetailResponseModel _$BarberDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    BarberDetailResponseModel(
      status: json['status'] as String,
      data: BarberDetailData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BarberDetailResponseModelToJson(
        BarberDetailResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

BarberDetailData _$BarberDetailDataFromJson(Map<String, dynamic> json) =>
    BarberDetailData(
      id: json['_id'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String,
      countryCode: json['countryCode'] as String,
      role: json['role'] as String,
      verified: json['verified'] as bool,
      verificationCode: json['verificationCode'] as String,
      verificationCodeExpires: json['verificationCodeExpires'] as String,
      resetPasswordCode: json['resetPasswordCode'] as String?,
      avatar: json['avatar'] as String,
      about: json['about'] as String?,
      portfolioImages: (json['portfolioImages'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      averageRating: (json['averageRating'] as num).toDouble(),
      numberOfReviews: (json['numberOfReviews'] as num).toInt(),
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => BarberReview.fromJson(e as Map<String, dynamic>))
          .toList(),
      services: (json['services'] as List<dynamic>)
          .map((e) => BarberService.fromJson(e as Map<String, dynamic>))
          .toList(),
      schedule:
          BarberSchedule.fromJson(json['schedule'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BarberDetailDataToJson(BarberDetailData instance) =>
    <String, dynamic>{
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
      'about': instance.about,
      'portfolioImages': instance.portfolioImages,
      'averageRating': instance.averageRating,
      'numberOfReviews': instance.numberOfReviews,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'reviews': instance.reviews,
      'services': instance.services,
      'schedule': instance.schedule,
    };

BarberService _$BarberServiceFromJson(Map<String, dynamic> json) =>
    BarberService(
      id: json['_id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      duration: (json['duration'] as num).toInt(),
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      imageCover: json['imageCover'] as String,
      category: json['category'] as String,
      available: json['available'] as bool,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: (json['__v'] as num).toInt(),
      barbers:
          (json['barbers'] as List<dynamic>).map((e) => e as String).toList(),
      description: json['description'] as String,
    );

Map<String, dynamic> _$BarberServiceToJson(BarberService instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'duration': instance.duration,
      'images': instance.images,
      'imageCover': instance.imageCover,
      'category': instance.category,
      'available': instance.available,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      '__v': instance.v,
      'barbers': instance.barbers,
      'description': instance.description,
    };

BarberSchedule _$BarberScheduleFromJson(Map<String, dynamic> json) =>
    BarberSchedule(
      date: json['date'] as String,
      businessHours:
          BusinessHours.fromJson(json['businessHours'] as Map<String, dynamic>),
      timeSlots: (json['timeSlots'] as List<dynamic>)
          .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BarberScheduleToJson(BarberSchedule instance) =>
    <String, dynamic>{
      'date': instance.date,
      'businessHours': instance.businessHours,
      'timeSlots': instance.timeSlots,
    };

BusinessHours _$BusinessHoursFromJson(Map<String, dynamic> json) =>
    BusinessHours(
      start: json['start'] as String,
      end: json['end'] as String,
    );

Map<String, dynamic> _$BusinessHoursToJson(BusinessHours instance) =>
    <String, dynamic>{
      'start': instance.start,
      'end': instance.end,
    };

TimeSlot _$TimeSlotFromJson(Map<String, dynamic> json) => TimeSlot(
      startTime: json['startTime'] as String,
      formattedTime: json['formattedTime'] as String,
      available: json['available'] as bool,
      booked: json['booked'] as bool,
    );

Map<String, dynamic> _$TimeSlotToJson(TimeSlot instance) => <String, dynamic>{
      'startTime': instance.startTime,
      'formattedTime': instance.formattedTime,
      'available': instance.available,
      'booked': instance.booked,
    };

BarberReview _$BarberReviewFromJson(Map<String, dynamic> json) =>
    BarberReview();

Map<String, dynamic> _$BarberReviewToJson(BarberReview instance) =>
    <String, dynamic>{};
