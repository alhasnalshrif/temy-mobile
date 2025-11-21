// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationResponse {

@JsonKey(name: 'status') String get status;@JsonKey(name: 'message') String get message;
/// Create a copy of NotificationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationResponseCopyWith<NotificationResponse> get copyWith => _$NotificationResponseCopyWithImpl<NotificationResponse>(this as NotificationResponse, _$identity);

  /// Serializes this NotificationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message);

@override
String toString() {
  return 'NotificationResponse(status: $status, message: $message)';
}


}

/// @nodoc
abstract mixin class $NotificationResponseCopyWith<$Res>  {
  factory $NotificationResponseCopyWith(NotificationResponse value, $Res Function(NotificationResponse) _then) = _$NotificationResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'status') String status,@JsonKey(name: 'message') String message
});




}
/// @nodoc
class _$NotificationResponseCopyWithImpl<$Res>
    implements $NotificationResponseCopyWith<$Res> {
  _$NotificationResponseCopyWithImpl(this._self, this._then);

  final NotificationResponse _self;
  final $Res Function(NotificationResponse) _then;

/// Create a copy of NotificationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? message = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationResponse].
extension NotificationResponsePatterns on NotificationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'status')  String status, @JsonKey(name: 'message')  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationResponse() when $default != null:
return $default(_that.status,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'status')  String status, @JsonKey(name: 'message')  String message)  $default,) {final _that = this;
switch (_that) {
case _NotificationResponse():
return $default(_that.status,_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'status')  String status, @JsonKey(name: 'message')  String message)?  $default,) {final _that = this;
switch (_that) {
case _NotificationResponse() when $default != null:
return $default(_that.status,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationResponse implements NotificationResponse {
  const _NotificationResponse({@JsonKey(name: 'status') required this.status, @JsonKey(name: 'message') required this.message});
  factory _NotificationResponse.fromJson(Map<String, dynamic> json) => _$NotificationResponseFromJson(json);

@override@JsonKey(name: 'status') final  String status;
@override@JsonKey(name: 'message') final  String message;

/// Create a copy of NotificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationResponseCopyWith<_NotificationResponse> get copyWith => __$NotificationResponseCopyWithImpl<_NotificationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,message);

@override
String toString() {
  return 'NotificationResponse(status: $status, message: $message)';
}


}

/// @nodoc
abstract mixin class _$NotificationResponseCopyWith<$Res> implements $NotificationResponseCopyWith<$Res> {
  factory _$NotificationResponseCopyWith(_NotificationResponse value, $Res Function(_NotificationResponse) _then) = __$NotificationResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'status') String status,@JsonKey(name: 'message') String message
});




}
/// @nodoc
class __$NotificationResponseCopyWithImpl<$Res>
    implements _$NotificationResponseCopyWith<$Res> {
  __$NotificationResponseCopyWithImpl(this._self, this._then);

  final _NotificationResponse _self;
  final $Res Function(_NotificationResponse) _then;

/// Create a copy of NotificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? message = null,}) {
  return _then(_NotificationResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NotificationSettingsResponse {

@JsonKey(name: 'push_notifications') bool get pushNotifications;@JsonKey(name: 'booking_reminders') bool get bookingReminders;@JsonKey(name: 'promotional_notifications') bool get promotionalNotifications;
/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationSettingsResponseCopyWith<NotificationSettingsResponse> get copyWith => _$NotificationSettingsResponseCopyWithImpl<NotificationSettingsResponse>(this as NotificationSettingsResponse, _$identity);

  /// Serializes this NotificationSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationSettingsResponse&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.bookingReminders, bookingReminders) || other.bookingReminders == bookingReminders)&&(identical(other.promotionalNotifications, promotionalNotifications) || other.promotionalNotifications == promotionalNotifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pushNotifications,bookingReminders,promotionalNotifications);

@override
String toString() {
  return 'NotificationSettingsResponse(pushNotifications: $pushNotifications, bookingReminders: $bookingReminders, promotionalNotifications: $promotionalNotifications)';
}


}

/// @nodoc
abstract mixin class $NotificationSettingsResponseCopyWith<$Res>  {
  factory $NotificationSettingsResponseCopyWith(NotificationSettingsResponse value, $Res Function(NotificationSettingsResponse) _then) = _$NotificationSettingsResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'push_notifications') bool pushNotifications,@JsonKey(name: 'booking_reminders') bool bookingReminders,@JsonKey(name: 'promotional_notifications') bool promotionalNotifications
});




}
/// @nodoc
class _$NotificationSettingsResponseCopyWithImpl<$Res>
    implements $NotificationSettingsResponseCopyWith<$Res> {
  _$NotificationSettingsResponseCopyWithImpl(this._self, this._then);

  final NotificationSettingsResponse _self;
  final $Res Function(NotificationSettingsResponse) _then;

/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pushNotifications = null,Object? bookingReminders = null,Object? promotionalNotifications = null,}) {
  return _then(_self.copyWith(
pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool,bookingReminders: null == bookingReminders ? _self.bookingReminders : bookingReminders // ignore: cast_nullable_to_non_nullable
as bool,promotionalNotifications: null == promotionalNotifications ? _self.promotionalNotifications : promotionalNotifications // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationSettingsResponse].
extension NotificationSettingsResponsePatterns on NotificationSettingsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationSettingsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationSettingsResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationSettingsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'push_notifications')  bool pushNotifications, @JsonKey(name: 'booking_reminders')  bool bookingReminders, @JsonKey(name: 'promotional_notifications')  bool promotionalNotifications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'push_notifications')  bool pushNotifications, @JsonKey(name: 'booking_reminders')  bool bookingReminders, @JsonKey(name: 'promotional_notifications')  bool promotionalNotifications)  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'push_notifications')  bool pushNotifications, @JsonKey(name: 'booking_reminders')  bool bookingReminders, @JsonKey(name: 'promotional_notifications')  bool promotionalNotifications)?  $default,) {final _that = this;
switch (_that) {
case _NotificationSettingsResponse() when $default != null:
return $default(_that.pushNotifications,_that.bookingReminders,_that.promotionalNotifications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationSettingsResponse implements NotificationSettingsResponse {
  const _NotificationSettingsResponse({@JsonKey(name: 'push_notifications') required this.pushNotifications, @JsonKey(name: 'booking_reminders') required this.bookingReminders, @JsonKey(name: 'promotional_notifications') required this.promotionalNotifications});
  factory _NotificationSettingsResponse.fromJson(Map<String, dynamic> json) => _$NotificationSettingsResponseFromJson(json);

@override@JsonKey(name: 'push_notifications') final  bool pushNotifications;
@override@JsonKey(name: 'booking_reminders') final  bool bookingReminders;
@override@JsonKey(name: 'promotional_notifications') final  bool promotionalNotifications;

/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationSettingsResponseCopyWith<_NotificationSettingsResponse> get copyWith => __$NotificationSettingsResponseCopyWithImpl<_NotificationSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationSettingsResponse&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.bookingReminders, bookingReminders) || other.bookingReminders == bookingReminders)&&(identical(other.promotionalNotifications, promotionalNotifications) || other.promotionalNotifications == promotionalNotifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pushNotifications,bookingReminders,promotionalNotifications);

@override
String toString() {
  return 'NotificationSettingsResponse(pushNotifications: $pushNotifications, bookingReminders: $bookingReminders, promotionalNotifications: $promotionalNotifications)';
}


}

/// @nodoc
abstract mixin class _$NotificationSettingsResponseCopyWith<$Res> implements $NotificationSettingsResponseCopyWith<$Res> {
  factory _$NotificationSettingsResponseCopyWith(_NotificationSettingsResponse value, $Res Function(_NotificationSettingsResponse) _then) = __$NotificationSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'push_notifications') bool pushNotifications,@JsonKey(name: 'booking_reminders') bool bookingReminders,@JsonKey(name: 'promotional_notifications') bool promotionalNotifications
});




}
/// @nodoc
class __$NotificationSettingsResponseCopyWithImpl<$Res>
    implements _$NotificationSettingsResponseCopyWith<$Res> {
  __$NotificationSettingsResponseCopyWithImpl(this._self, this._then);

  final _NotificationSettingsResponse _self;
  final $Res Function(_NotificationSettingsResponse) _then;

/// Create a copy of NotificationSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pushNotifications = null,Object? bookingReminders = null,Object? promotionalNotifications = null,}) {
  return _then(_NotificationSettingsResponse(
pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool,bookingReminders: null == bookingReminders ? _self.bookingReminders : bookingReminders // ignore: cast_nullable_to_non_nullable
as bool,promotionalNotifications: null == promotionalNotifications ? _self.promotionalNotifications : promotionalNotifications // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$NotificationHistoryItem {

@JsonKey(name: 'id') int get id;@JsonKey(name: 'title') String get title;@JsonKey(name: 'body') String get body;@JsonKey(name: 'type') String get type;@JsonKey(name: 'data') Map<String, dynamic>? get data;@JsonKey(name: 'read_at') String? get readAt;@JsonKey(name: 'created_at') String get createdAt;
/// Create a copy of NotificationHistoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationHistoryItemCopyWith<NotificationHistoryItem> get copyWith => _$NotificationHistoryItemCopyWithImpl<NotificationHistoryItem>(this as NotificationHistoryItem, _$identity);

  /// Serializes this NotificationHistoryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationHistoryItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.data, data)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,type,const DeepCollectionEquality().hash(data),readAt,createdAt);

@override
String toString() {
  return 'NotificationHistoryItem(id: $id, title: $title, body: $body, type: $type, data: $data, readAt: $readAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $NotificationHistoryItemCopyWith<$Res>  {
  factory $NotificationHistoryItemCopyWith(NotificationHistoryItem value, $Res Function(NotificationHistoryItem) _then) = _$NotificationHistoryItemCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'title') String title,@JsonKey(name: 'body') String body,@JsonKey(name: 'type') String type,@JsonKey(name: 'data') Map<String, dynamic>? data,@JsonKey(name: 'read_at') String? readAt,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class _$NotificationHistoryItemCopyWithImpl<$Res>
    implements $NotificationHistoryItemCopyWith<$Res> {
  _$NotificationHistoryItemCopyWithImpl(this._self, this._then);

  final NotificationHistoryItem _self;
  final $Res Function(NotificationHistoryItem) _then;

/// Create a copy of NotificationHistoryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? body = null,Object? type = null,Object? data = freezed,Object? readAt = freezed,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationHistoryItem].
extension NotificationHistoryItemPatterns on NotificationHistoryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationHistoryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationHistoryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationHistoryItem value)  $default,){
final _that = this;
switch (_that) {
case _NotificationHistoryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationHistoryItem value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationHistoryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'body')  String body, @JsonKey(name: 'type')  String type, @JsonKey(name: 'data')  Map<String, dynamic>? data, @JsonKey(name: 'read_at')  String? readAt, @JsonKey(name: 'created_at')  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationHistoryItem() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.type,_that.data,_that.readAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'body')  String body, @JsonKey(name: 'type')  String type, @JsonKey(name: 'data')  Map<String, dynamic>? data, @JsonKey(name: 'read_at')  String? readAt, @JsonKey(name: 'created_at')  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _NotificationHistoryItem():
return $default(_that.id,_that.title,_that.body,_that.type,_that.data,_that.readAt,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id')  int id, @JsonKey(name: 'title')  String title, @JsonKey(name: 'body')  String body, @JsonKey(name: 'type')  String type, @JsonKey(name: 'data')  Map<String, dynamic>? data, @JsonKey(name: 'read_at')  String? readAt, @JsonKey(name: 'created_at')  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _NotificationHistoryItem() when $default != null:
return $default(_that.id,_that.title,_that.body,_that.type,_that.data,_that.readAt,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationHistoryItem implements NotificationHistoryItem {
  const _NotificationHistoryItem({@JsonKey(name: 'id') required this.id, @JsonKey(name: 'title') required this.title, @JsonKey(name: 'body') required this.body, @JsonKey(name: 'type') required this.type, @JsonKey(name: 'data') final  Map<String, dynamic>? data, @JsonKey(name: 'read_at') this.readAt, @JsonKey(name: 'created_at') required this.createdAt}): _data = data;
  factory _NotificationHistoryItem.fromJson(Map<String, dynamic> json) => _$NotificationHistoryItemFromJson(json);

@override@JsonKey(name: 'id') final  int id;
@override@JsonKey(name: 'title') final  String title;
@override@JsonKey(name: 'body') final  String body;
@override@JsonKey(name: 'type') final  String type;
 final  Map<String, dynamic>? _data;
@override@JsonKey(name: 'data') Map<String, dynamic>? get data {
  final value = _data;
  if (value == null) return null;
  if (_data is EqualUnmodifiableMapView) return _data;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override@JsonKey(name: 'read_at') final  String? readAt;
@override@JsonKey(name: 'created_at') final  String createdAt;

/// Create a copy of NotificationHistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationHistoryItemCopyWith<_NotificationHistoryItem> get copyWith => __$NotificationHistoryItemCopyWithImpl<_NotificationHistoryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationHistoryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationHistoryItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.body, body) || other.body == body)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._data, _data)&&(identical(other.readAt, readAt) || other.readAt == readAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,body,type,const DeepCollectionEquality().hash(_data),readAt,createdAt);

@override
String toString() {
  return 'NotificationHistoryItem(id: $id, title: $title, body: $body, type: $type, data: $data, readAt: $readAt, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$NotificationHistoryItemCopyWith<$Res> implements $NotificationHistoryItemCopyWith<$Res> {
  factory _$NotificationHistoryItemCopyWith(_NotificationHistoryItem value, $Res Function(_NotificationHistoryItem) _then) = __$NotificationHistoryItemCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id') int id,@JsonKey(name: 'title') String title,@JsonKey(name: 'body') String body,@JsonKey(name: 'type') String type,@JsonKey(name: 'data') Map<String, dynamic>? data,@JsonKey(name: 'read_at') String? readAt,@JsonKey(name: 'created_at') String createdAt
});




}
/// @nodoc
class __$NotificationHistoryItemCopyWithImpl<$Res>
    implements _$NotificationHistoryItemCopyWith<$Res> {
  __$NotificationHistoryItemCopyWithImpl(this._self, this._then);

  final _NotificationHistoryItem _self;
  final $Res Function(_NotificationHistoryItem) _then;

/// Create a copy of NotificationHistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? body = null,Object? type = null,Object? data = freezed,Object? readAt = freezed,Object? createdAt = null,}) {
  return _then(_NotificationHistoryItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,data: freezed == data ? _self._data : data // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,readAt: freezed == readAt ? _self.readAt : readAt // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$NotificationHistoryResponse {

@JsonKey(name: 'notifications') List<NotificationHistoryItem> get notifications;
/// Create a copy of NotificationHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationHistoryResponseCopyWith<NotificationHistoryResponse> get copyWith => _$NotificationHistoryResponseCopyWithImpl<NotificationHistoryResponse>(this as NotificationHistoryResponse, _$identity);

  /// Serializes this NotificationHistoryResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationHistoryResponse&&const DeepCollectionEquality().equals(other.notifications, notifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(notifications));

@override
String toString() {
  return 'NotificationHistoryResponse(notifications: $notifications)';
}


}

/// @nodoc
abstract mixin class $NotificationHistoryResponseCopyWith<$Res>  {
  factory $NotificationHistoryResponseCopyWith(NotificationHistoryResponse value, $Res Function(NotificationHistoryResponse) _then) = _$NotificationHistoryResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'notifications') List<NotificationHistoryItem> notifications
});




}
/// @nodoc
class _$NotificationHistoryResponseCopyWithImpl<$Res>
    implements $NotificationHistoryResponseCopyWith<$Res> {
  _$NotificationHistoryResponseCopyWithImpl(this._self, this._then);

  final NotificationHistoryResponse _self;
  final $Res Function(NotificationHistoryResponse) _then;

/// Create a copy of NotificationHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? notifications = null,}) {
  return _then(_self.copyWith(
notifications: null == notifications ? _self.notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationHistoryItem>,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationHistoryResponse].
extension NotificationHistoryResponsePatterns on NotificationHistoryResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationHistoryResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationHistoryResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationHistoryResponse value)  $default,){
final _that = this;
switch (_that) {
case _NotificationHistoryResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationHistoryResponse value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationHistoryResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'notifications')  List<NotificationHistoryItem> notifications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationHistoryResponse() when $default != null:
return $default(_that.notifications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'notifications')  List<NotificationHistoryItem> notifications)  $default,) {final _that = this;
switch (_that) {
case _NotificationHistoryResponse():
return $default(_that.notifications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'notifications')  List<NotificationHistoryItem> notifications)?  $default,) {final _that = this;
switch (_that) {
case _NotificationHistoryResponse() when $default != null:
return $default(_that.notifications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationHistoryResponse implements NotificationHistoryResponse {
  const _NotificationHistoryResponse({@JsonKey(name: 'notifications') required final  List<NotificationHistoryItem> notifications}): _notifications = notifications;
  factory _NotificationHistoryResponse.fromJson(Map<String, dynamic> json) => _$NotificationHistoryResponseFromJson(json);

 final  List<NotificationHistoryItem> _notifications;
@override@JsonKey(name: 'notifications') List<NotificationHistoryItem> get notifications {
  if (_notifications is EqualUnmodifiableListView) return _notifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notifications);
}


/// Create a copy of NotificationHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationHistoryResponseCopyWith<_NotificationHistoryResponse> get copyWith => __$NotificationHistoryResponseCopyWithImpl<_NotificationHistoryResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationHistoryResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationHistoryResponse&&const DeepCollectionEquality().equals(other._notifications, _notifications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_notifications));

@override
String toString() {
  return 'NotificationHistoryResponse(notifications: $notifications)';
}


}

/// @nodoc
abstract mixin class _$NotificationHistoryResponseCopyWith<$Res> implements $NotificationHistoryResponseCopyWith<$Res> {
  factory _$NotificationHistoryResponseCopyWith(_NotificationHistoryResponse value, $Res Function(_NotificationHistoryResponse) _then) = __$NotificationHistoryResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'notifications') List<NotificationHistoryItem> notifications
});




}
/// @nodoc
class __$NotificationHistoryResponseCopyWithImpl<$Res>
    implements _$NotificationHistoryResponseCopyWith<$Res> {
  __$NotificationHistoryResponseCopyWithImpl(this._self, this._then);

  final _NotificationHistoryResponse _self;
  final $Res Function(_NotificationHistoryResponse) _then;

/// Create a copy of NotificationHistoryResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? notifications = null,}) {
  return _then(_NotificationHistoryResponse(
notifications: null == notifications ? _self._notifications : notifications // ignore: cast_nullable_to_non_nullable
as List<NotificationHistoryItem>,
  ));
}


}

// dart format on
