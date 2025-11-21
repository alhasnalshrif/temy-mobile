// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationTokenRequest {

@JsonKey(name: 'device_token') String get deviceToken;@JsonKey(name: 'player_id') String? get playerId;@JsonKey(name: 'platform') String get platform;
/// Create a copy of NotificationTokenRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationTokenRequestCopyWith<NotificationTokenRequest> get copyWith => _$NotificationTokenRequestCopyWithImpl<NotificationTokenRequest>(this as NotificationTokenRequest, _$identity);

  /// Serializes this NotificationTokenRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationTokenRequest&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceToken,playerId,platform);

@override
String toString() {
  return 'NotificationTokenRequest(deviceToken: $deviceToken, playerId: $playerId, platform: $platform)';
}


}

/// @nodoc
abstract mixin class $NotificationTokenRequestCopyWith<$Res>  {
  factory $NotificationTokenRequestCopyWith(NotificationTokenRequest value, $Res Function(NotificationTokenRequest) _then) = _$NotificationTokenRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'device_token') String deviceToken,@JsonKey(name: 'player_id') String? playerId,@JsonKey(name: 'platform') String platform
});




}
/// @nodoc
class _$NotificationTokenRequestCopyWithImpl<$Res>
    implements $NotificationTokenRequestCopyWith<$Res> {
  _$NotificationTokenRequestCopyWithImpl(this._self, this._then);

  final NotificationTokenRequest _self;
  final $Res Function(NotificationTokenRequest) _then;

/// Create a copy of NotificationTokenRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? deviceToken = null,Object? playerId = freezed,Object? platform = null,}) {
  return _then(_self.copyWith(
deviceToken: null == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String?,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationTokenRequest].
extension NotificationTokenRequestPatterns on NotificationTokenRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationTokenRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationTokenRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationTokenRequest value)  $default,){
final _that = this;
switch (_that) {
case _NotificationTokenRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationTokenRequest value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationTokenRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'device_token')  String deviceToken, @JsonKey(name: 'player_id')  String? playerId, @JsonKey(name: 'platform')  String platform)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationTokenRequest() when $default != null:
return $default(_that.deviceToken,_that.playerId,_that.platform);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'device_token')  String deviceToken, @JsonKey(name: 'player_id')  String? playerId, @JsonKey(name: 'platform')  String platform)  $default,) {final _that = this;
switch (_that) {
case _NotificationTokenRequest():
return $default(_that.deviceToken,_that.playerId,_that.platform);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'device_token')  String deviceToken, @JsonKey(name: 'player_id')  String? playerId, @JsonKey(name: 'platform')  String platform)?  $default,) {final _that = this;
switch (_that) {
case _NotificationTokenRequest() when $default != null:
return $default(_that.deviceToken,_that.playerId,_that.platform);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationTokenRequest implements NotificationTokenRequest {
  const _NotificationTokenRequest({@JsonKey(name: 'device_token') required this.deviceToken, @JsonKey(name: 'player_id') this.playerId, @JsonKey(name: 'platform') required this.platform});
  factory _NotificationTokenRequest.fromJson(Map<String, dynamic> json) => _$NotificationTokenRequestFromJson(json);

@override@JsonKey(name: 'device_token') final  String deviceToken;
@override@JsonKey(name: 'player_id') final  String? playerId;
@override@JsonKey(name: 'platform') final  String platform;

/// Create a copy of NotificationTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationTokenRequestCopyWith<_NotificationTokenRequest> get copyWith => __$NotificationTokenRequestCopyWithImpl<_NotificationTokenRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationTokenRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationTokenRequest&&(identical(other.deviceToken, deviceToken) || other.deviceToken == deviceToken)&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.platform, platform) || other.platform == platform));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,deviceToken,playerId,platform);

@override
String toString() {
  return 'NotificationTokenRequest(deviceToken: $deviceToken, playerId: $playerId, platform: $platform)';
}


}

/// @nodoc
abstract mixin class _$NotificationTokenRequestCopyWith<$Res> implements $NotificationTokenRequestCopyWith<$Res> {
  factory _$NotificationTokenRequestCopyWith(_NotificationTokenRequest value, $Res Function(_NotificationTokenRequest) _then) = __$NotificationTokenRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'device_token') String deviceToken,@JsonKey(name: 'player_id') String? playerId,@JsonKey(name: 'platform') String platform
});




}
/// @nodoc
class __$NotificationTokenRequestCopyWithImpl<$Res>
    implements _$NotificationTokenRequestCopyWith<$Res> {
  __$NotificationTokenRequestCopyWithImpl(this._self, this._then);

  final _NotificationTokenRequest _self;
  final $Res Function(_NotificationTokenRequest) _then;

/// Create a copy of NotificationTokenRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? deviceToken = null,Object? playerId = freezed,Object? platform = null,}) {
  return _then(_NotificationTokenRequest(
deviceToken: null == deviceToken ? _self.deviceToken : deviceToken // ignore: cast_nullable_to_non_nullable
as String,playerId: freezed == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String?,platform: null == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NotificationSettingsRequest {

@JsonKey(name: 'push_notifications') bool get pushNotifications;@JsonKey(name: 'booking_reminders') bool? get bookingReminders;@JsonKey(name: 'promotional_notifications') bool? get promotionalNotifications;
/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsRequestCopyWith<NotificationSettingsRequest> get copyWith => _$NotificationSettingsRequestCopyWithImpl<NotificationSettingsRequest>(this as NotificationSettingsRequest, _$identity);

  /// Serializes this NotificationSettingsRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsRequest&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.bookingReminders, bookingReminders) || other.bookingReminders == bookingReminders)&&(identical(other.promotionalNotifications, promotionalNotifications) || other.promotionalNotifications == promotionalNotifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pushNotifications,bookingReminders,promotionalNotifications);

@override
String toString() {
  return 'NotificationSettingsRequest(pushNotifications: $pushNotifications, bookingReminders: $bookingReminders, promotionalNotifications: $promotionalNotifications)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsRequestCopyWith<$Res>  {
  factory $NotificationSettingsRequestCopyWith(NotificationSettingsRequest value, $Res Function(NotificationSettingsRequest) _then) = _$NotificationSettingsRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'push_notifications') bool pushNotifications,@JsonKey(name: 'booking_reminders') bool? bookingReminders,@JsonKey(name: 'promotional_notifications') bool? promotionalNotifications
});




}
/// @nodoc
class _$NotificationSettingsRequestCopyWithImpl<$Res>
    implements $NotificationSettingsRequestCopyWith<$Res> {
  _$NotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final NotificationSettingsRequest _self;
  final $Res Function(NotificationSettingsRequest) _then;

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pushNotifications = null,Object? bookingReminders = freezed,Object? promotionalNotifications = freezed,}) {
  return _then(_self.copyWith(
pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool,bookingReminders: freezed == bookingReminders ? _self.bookingReminders : bookingReminders // ignore: cast_nullable_to_non_nullable
as bool?,promotionalNotifications: freezed == promotionalNotifications ? _self.promotionalNotifications : promotionalNotifications // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSettingsRequest].
extension NotificationSettingsRequestPatterns on NotificationSettingsRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSettingsRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSettingsRequest value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsRequest():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSettingsRequest value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'push_notifications')  bool pushNotifications, @JsonKey(name: 'booking_reminders')  bool? bookingReminders, @JsonKey(name: 'promotional_notifications')  bool? promotionalNotifications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
return $default(_that.pushNotifications,_that.bookingReminders,_that.promotionalNotifications);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'push_notifications')  bool pushNotifications, @JsonKey(name: 'booking_reminders')  bool? bookingReminders, @JsonKey(name: 'promotional_notifications')  bool? promotionalNotifications)  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsRequest():
return $default(_that.pushNotifications,_that.bookingReminders,_that.promotionalNotifications);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'push_notifications')  bool pushNotifications, @JsonKey(name: 'booking_reminders')  bool? bookingReminders, @JsonKey(name: 'promotional_notifications')  bool? promotionalNotifications)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsRequest() when $default != null:
return $default(_that.pushNotifications,_that.bookingReminders,_that.promotionalNotifications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationSettingsRequest implements NotificationSettingsRequest {
  const _NotificationSettingsRequest({@JsonKey(name: 'push_notifications') required this.pushNotifications, @JsonKey(name: 'booking_reminders') this.bookingReminders, @JsonKey(name: 'promotional_notifications') this.promotionalNotifications});
  factory _NotificationSettingsRequest.fromJson(Map<String, dynamic> json) => _$NotificationSettingsRequestFromJson(json);

@override@JsonKey(name: 'push_notifications') final  bool pushNotifications;
@override@JsonKey(name: 'booking_reminders') final  bool? bookingReminders;
@override@JsonKey(name: 'promotional_notifications') final  bool? promotionalNotifications;

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsRequestCopyWith<_NotificationSettingsRequest> get copyWith => __$NotificationSettingsRequestCopyWithImpl<_NotificationSettingsRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsRequest&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.bookingReminders, bookingReminders) || other.bookingReminders == bookingReminders)&&(identical(other.promotionalNotifications, promotionalNotifications) || other.promotionalNotifications == promotionalNotifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pushNotifications,bookingReminders,promotionalNotifications);

@override
String toString() {
  return 'NotificationSettingsRequest(pushNotifications: $pushNotifications, bookingReminders: $bookingReminders, promotionalNotifications: $promotionalNotifications)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsRequestCopyWith<$Res> implements $NotificationSettingsRequestCopyWith<$Res> {
  factory _$NotificationSettingsRequestCopyWith(_NotificationSettingsRequest value, $Res Function(_NotificationSettingsRequest) _then) = __$NotificationSettingsRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'push_notifications') bool pushNotifications,@JsonKey(name: 'booking_reminders') bool? bookingReminders,@JsonKey(name: 'promotional_notifications') bool? promotionalNotifications
});




}
/// @nodoc
class __$NotificationSettingsRequestCopyWithImpl<$Res>
    implements _$NotificationSettingsRequestCopyWith<$Res> {
  __$NotificationSettingsRequestCopyWithImpl(this._self, this._then);

  final _NotificationSettingsRequest _self;
  final $Res Function(_NotificationSettingsRequest) _then;

/// Create a copy of NotificationSettingsRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pushNotifications = null,Object? bookingReminders = freezed,Object? promotionalNotifications = freezed,}) {
  return _then(_NotificationSettingsRequest(
pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool,bookingReminders: freezed == bookingReminders ? _self.bookingReminders : bookingReminders // ignore: cast_nullable_to_non_nullable
as bool?,promotionalNotifications: freezed == promotionalNotifications ? _self.promotionalNotifications : promotionalNotifications // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
