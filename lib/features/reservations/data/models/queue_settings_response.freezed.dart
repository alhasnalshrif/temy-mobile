// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QueueSettingsResponse {

 String get status; QueueSettingsData get data;
/// Create a copy of QueueSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueSettingsResponseCopyWith<QueueSettingsResponse> get copyWith => _$QueueSettingsResponseCopyWithImpl<QueueSettingsResponse>(this as QueueSettingsResponse, _$identity);

  /// Serializes this QueueSettingsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueSettingsResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data);

@override
String toString() {
  return 'QueueSettingsResponse(status: $status, data: $data)';
}


}

/// @nodoc
abstract mixin class $QueueSettingsResponseCopyWith<$Res>  {
  factory $QueueSettingsResponseCopyWith(QueueSettingsResponse value, $Res Function(QueueSettingsResponse) _then) = _$QueueSettingsResponseCopyWithImpl;
@useResult
$Res call({
 String status, QueueSettingsData data
});


$QueueSettingsDataCopyWith<$Res> get data;

}
/// @nodoc
class _$QueueSettingsResponseCopyWithImpl<$Res>
    implements $QueueSettingsResponseCopyWith<$Res> {
  _$QueueSettingsResponseCopyWithImpl(this._self, this._then);

  final QueueSettingsResponse _self;
  final $Res Function(QueueSettingsResponse) _then;

/// Create a copy of QueueSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? data = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as QueueSettingsData,
  ));
}
/// Create a copy of QueueSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueSettingsDataCopyWith<$Res> get data {
  
  return $QueueSettingsDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [QueueSettingsResponse].
extension QueueSettingsResponsePatterns on QueueSettingsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueSettingsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueSettingsResponse value)  $default,){
final _that = this;
switch (_that) {
case _QueueSettingsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueSettingsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _QueueSettingsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  QueueSettingsData data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueSettingsResponse() when $default != null:
return $default(_that.status,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  QueueSettingsData data)  $default,) {final _that = this;
switch (_that) {
case _QueueSettingsResponse():
return $default(_that.status,_that.data);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  QueueSettingsData data)?  $default,) {final _that = this;
switch (_that) {
case _QueueSettingsResponse() when $default != null:
return $default(_that.status,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueueSettingsResponse implements QueueSettingsResponse {
  const _QueueSettingsResponse({required this.status, required this.data});
  factory _QueueSettingsResponse.fromJson(Map<String, dynamic> json) => _$QueueSettingsResponseFromJson(json);

@override final  String status;
@override final  QueueSettingsData data;

/// Create a copy of QueueSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueSettingsResponseCopyWith<_QueueSettingsResponse> get copyWith => __$QueueSettingsResponseCopyWithImpl<_QueueSettingsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueueSettingsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueSettingsResponse&&(identical(other.status, status) || other.status == status)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,data);

@override
String toString() {
  return 'QueueSettingsResponse(status: $status, data: $data)';
}


}

/// @nodoc
abstract mixin class _$QueueSettingsResponseCopyWith<$Res> implements $QueueSettingsResponseCopyWith<$Res> {
  factory _$QueueSettingsResponseCopyWith(_QueueSettingsResponse value, $Res Function(_QueueSettingsResponse) _then) = __$QueueSettingsResponseCopyWithImpl;
@override @useResult
$Res call({
 String status, QueueSettingsData data
});


@override $QueueSettingsDataCopyWith<$Res> get data;

}
/// @nodoc
class __$QueueSettingsResponseCopyWithImpl<$Res>
    implements _$QueueSettingsResponseCopyWith<$Res> {
  __$QueueSettingsResponseCopyWithImpl(this._self, this._then);

  final _QueueSettingsResponse _self;
  final $Res Function(_QueueSettingsResponse) _then;

/// Create a copy of QueueSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? data = null,}) {
  return _then(_QueueSettingsResponse(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as QueueSettingsData,
  ));
}

/// Create a copy of QueueSettingsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueSettingsDataCopyWith<$Res> get data {
  
  return $QueueSettingsDataCopyWith<$Res>(_self.data, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$QueueSettingsData {

@JsonKey(name: 'is_queue_mode') bool get isQueueMode;@JsonKey(name: 'queue_settings') QueueSettings get queueSettings;
/// Create a copy of QueueSettingsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueSettingsDataCopyWith<QueueSettingsData> get copyWith => _$QueueSettingsDataCopyWithImpl<QueueSettingsData>(this as QueueSettingsData, _$identity);

  /// Serializes this QueueSettingsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueSettingsData&&(identical(other.isQueueMode, isQueueMode) || other.isQueueMode == isQueueMode)&&(identical(other.queueSettings, queueSettings) || other.queueSettings == queueSettings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isQueueMode,queueSettings);

@override
String toString() {
  return 'QueueSettingsData(isQueueMode: $isQueueMode, queueSettings: $queueSettings)';
}


}

/// @nodoc
abstract mixin class $QueueSettingsDataCopyWith<$Res>  {
  factory $QueueSettingsDataCopyWith(QueueSettingsData value, $Res Function(QueueSettingsData) _then) = _$QueueSettingsDataCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'is_queue_mode') bool isQueueMode,@JsonKey(name: 'queue_settings') QueueSettings queueSettings
});


$QueueSettingsCopyWith<$Res> get queueSettings;

}
/// @nodoc
class _$QueueSettingsDataCopyWithImpl<$Res>
    implements $QueueSettingsDataCopyWith<$Res> {
  _$QueueSettingsDataCopyWithImpl(this._self, this._then);

  final QueueSettingsData _self;
  final $Res Function(QueueSettingsData) _then;

/// Create a copy of QueueSettingsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isQueueMode = null,Object? queueSettings = null,}) {
  return _then(_self.copyWith(
isQueueMode: null == isQueueMode ? _self.isQueueMode : isQueueMode // ignore: cast_nullable_to_non_nullable
as bool,queueSettings: null == queueSettings ? _self.queueSettings : queueSettings // ignore: cast_nullable_to_non_nullable
as QueueSettings,
  ));
}
/// Create a copy of QueueSettingsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueSettingsCopyWith<$Res> get queueSettings {
  
  return $QueueSettingsCopyWith<$Res>(_self.queueSettings, (value) {
    return _then(_self.copyWith(queueSettings: value));
  });
}
}


/// Adds pattern-matching-related methods to [QueueSettingsData].
extension QueueSettingsDataPatterns on QueueSettingsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueSettingsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueSettingsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueSettingsData value)  $default,){
final _that = this;
switch (_that) {
case _QueueSettingsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueSettingsData value)?  $default,){
final _that = this;
switch (_that) {
case _QueueSettingsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_queue_mode')  bool isQueueMode, @JsonKey(name: 'queue_settings')  QueueSettings queueSettings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueSettingsData() when $default != null:
return $default(_that.isQueueMode,_that.queueSettings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'is_queue_mode')  bool isQueueMode, @JsonKey(name: 'queue_settings')  QueueSettings queueSettings)  $default,) {final _that = this;
switch (_that) {
case _QueueSettingsData():
return $default(_that.isQueueMode,_that.queueSettings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'is_queue_mode')  bool isQueueMode, @JsonKey(name: 'queue_settings')  QueueSettings queueSettings)?  $default,) {final _that = this;
switch (_that) {
case _QueueSettingsData() when $default != null:
return $default(_that.isQueueMode,_that.queueSettings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueueSettingsData implements QueueSettingsData {
  const _QueueSettingsData({@JsonKey(name: 'is_queue_mode') required this.isQueueMode, @JsonKey(name: 'queue_settings') required this.queueSettings});
  factory _QueueSettingsData.fromJson(Map<String, dynamic> json) => _$QueueSettingsDataFromJson(json);

@override@JsonKey(name: 'is_queue_mode') final  bool isQueueMode;
@override@JsonKey(name: 'queue_settings') final  QueueSettings queueSettings;

/// Create a copy of QueueSettingsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueSettingsDataCopyWith<_QueueSettingsData> get copyWith => __$QueueSettingsDataCopyWithImpl<_QueueSettingsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueueSettingsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueSettingsData&&(identical(other.isQueueMode, isQueueMode) || other.isQueueMode == isQueueMode)&&(identical(other.queueSettings, queueSettings) || other.queueSettings == queueSettings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isQueueMode,queueSettings);

@override
String toString() {
  return 'QueueSettingsData(isQueueMode: $isQueueMode, queueSettings: $queueSettings)';
}


}

/// @nodoc
abstract mixin class _$QueueSettingsDataCopyWith<$Res> implements $QueueSettingsDataCopyWith<$Res> {
  factory _$QueueSettingsDataCopyWith(_QueueSettingsData value, $Res Function(_QueueSettingsData) _then) = __$QueueSettingsDataCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'is_queue_mode') bool isQueueMode,@JsonKey(name: 'queue_settings') QueueSettings queueSettings
});


@override $QueueSettingsCopyWith<$Res> get queueSettings;

}
/// @nodoc
class __$QueueSettingsDataCopyWithImpl<$Res>
    implements _$QueueSettingsDataCopyWith<$Res> {
  __$QueueSettingsDataCopyWithImpl(this._self, this._then);

  final _QueueSettingsData _self;
  final $Res Function(_QueueSettingsData) _then;

/// Create a copy of QueueSettingsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isQueueMode = null,Object? queueSettings = null,}) {
  return _then(_QueueSettingsData(
isQueueMode: null == isQueueMode ? _self.isQueueMode : isQueueMode // ignore: cast_nullable_to_non_nullable
as bool,queueSettings: null == queueSettings ? _self.queueSettings : queueSettings // ignore: cast_nullable_to_non_nullable
as QueueSettings,
  ));
}

/// Create a copy of QueueSettingsData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$QueueSettingsCopyWith<$Res> get queueSettings {
  
  return $QueueSettingsCopyWith<$Res>(_self.queueSettings, (value) {
    return _then(_self.copyWith(queueSettings: value));
  });
}
}


/// @nodoc
mixin _$QueueSettings {

@JsonKey(name: 'max_queue_size') int get maxQueueSize;@JsonKey(name: 'estimated_service_time') int get estimatedServiceTime;@JsonKey(name: 'auto_advance_queue') bool get autoAdvanceQueue;
/// Create a copy of QueueSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueSettingsCopyWith<QueueSettings> get copyWith => _$QueueSettingsCopyWithImpl<QueueSettings>(this as QueueSettings, _$identity);

  /// Serializes this QueueSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueSettings&&(identical(other.maxQueueSize, maxQueueSize) || other.maxQueueSize == maxQueueSize)&&(identical(other.estimatedServiceTime, estimatedServiceTime) || other.estimatedServiceTime == estimatedServiceTime)&&(identical(other.autoAdvanceQueue, autoAdvanceQueue) || other.autoAdvanceQueue == autoAdvanceQueue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxQueueSize,estimatedServiceTime,autoAdvanceQueue);

@override
String toString() {
  return 'QueueSettings(maxQueueSize: $maxQueueSize, estimatedServiceTime: $estimatedServiceTime, autoAdvanceQueue: $autoAdvanceQueue)';
}


}

/// @nodoc
abstract mixin class $QueueSettingsCopyWith<$Res>  {
  factory $QueueSettingsCopyWith(QueueSettings value, $Res Function(QueueSettings) _then) = _$QueueSettingsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'max_queue_size') int maxQueueSize,@JsonKey(name: 'estimated_service_time') int estimatedServiceTime,@JsonKey(name: 'auto_advance_queue') bool autoAdvanceQueue
});




}
/// @nodoc
class _$QueueSettingsCopyWithImpl<$Res>
    implements $QueueSettingsCopyWith<$Res> {
  _$QueueSettingsCopyWithImpl(this._self, this._then);

  final QueueSettings _self;
  final $Res Function(QueueSettings) _then;

/// Create a copy of QueueSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? maxQueueSize = null,Object? estimatedServiceTime = null,Object? autoAdvanceQueue = null,}) {
  return _then(_self.copyWith(
maxQueueSize: null == maxQueueSize ? _self.maxQueueSize : maxQueueSize // ignore: cast_nullable_to_non_nullable
as int,estimatedServiceTime: null == estimatedServiceTime ? _self.estimatedServiceTime : estimatedServiceTime // ignore: cast_nullable_to_non_nullable
as int,autoAdvanceQueue: null == autoAdvanceQueue ? _self.autoAdvanceQueue : autoAdvanceQueue // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [QueueSettings].
extension QueueSettingsPatterns on QueueSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QueueSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QueueSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QueueSettings value)  $default,){
final _that = this;
switch (_that) {
case _QueueSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QueueSettings value)?  $default,){
final _that = this;
switch (_that) {
case _QueueSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'max_queue_size')  int maxQueueSize, @JsonKey(name: 'estimated_service_time')  int estimatedServiceTime, @JsonKey(name: 'auto_advance_queue')  bool autoAdvanceQueue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QueueSettings() when $default != null:
return $default(_that.maxQueueSize,_that.estimatedServiceTime,_that.autoAdvanceQueue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'max_queue_size')  int maxQueueSize, @JsonKey(name: 'estimated_service_time')  int estimatedServiceTime, @JsonKey(name: 'auto_advance_queue')  bool autoAdvanceQueue)  $default,) {final _that = this;
switch (_that) {
case _QueueSettings():
return $default(_that.maxQueueSize,_that.estimatedServiceTime,_that.autoAdvanceQueue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'max_queue_size')  int maxQueueSize, @JsonKey(name: 'estimated_service_time')  int estimatedServiceTime, @JsonKey(name: 'auto_advance_queue')  bool autoAdvanceQueue)?  $default,) {final _that = this;
switch (_that) {
case _QueueSettings() when $default != null:
return $default(_that.maxQueueSize,_that.estimatedServiceTime,_that.autoAdvanceQueue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QueueSettings implements QueueSettings {
  const _QueueSettings({@JsonKey(name: 'max_queue_size') required this.maxQueueSize, @JsonKey(name: 'estimated_service_time') required this.estimatedServiceTime, @JsonKey(name: 'auto_advance_queue') required this.autoAdvanceQueue});
  factory _QueueSettings.fromJson(Map<String, dynamic> json) => _$QueueSettingsFromJson(json);

@override@JsonKey(name: 'max_queue_size') final  int maxQueueSize;
@override@JsonKey(name: 'estimated_service_time') final  int estimatedServiceTime;
@override@JsonKey(name: 'auto_advance_queue') final  bool autoAdvanceQueue;

/// Create a copy of QueueSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QueueSettingsCopyWith<_QueueSettings> get copyWith => __$QueueSettingsCopyWithImpl<_QueueSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QueueSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QueueSettings&&(identical(other.maxQueueSize, maxQueueSize) || other.maxQueueSize == maxQueueSize)&&(identical(other.estimatedServiceTime, estimatedServiceTime) || other.estimatedServiceTime == estimatedServiceTime)&&(identical(other.autoAdvanceQueue, autoAdvanceQueue) || other.autoAdvanceQueue == autoAdvanceQueue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,maxQueueSize,estimatedServiceTime,autoAdvanceQueue);

@override
String toString() {
  return 'QueueSettings(maxQueueSize: $maxQueueSize, estimatedServiceTime: $estimatedServiceTime, autoAdvanceQueue: $autoAdvanceQueue)';
}


}

/// @nodoc
abstract mixin class _$QueueSettingsCopyWith<$Res> implements $QueueSettingsCopyWith<$Res> {
  factory _$QueueSettingsCopyWith(_QueueSettings value, $Res Function(_QueueSettings) _then) = __$QueueSettingsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'max_queue_size') int maxQueueSize,@JsonKey(name: 'estimated_service_time') int estimatedServiceTime,@JsonKey(name: 'auto_advance_queue') bool autoAdvanceQueue
});




}
/// @nodoc
class __$QueueSettingsCopyWithImpl<$Res>
    implements _$QueueSettingsCopyWith<$Res> {
  __$QueueSettingsCopyWithImpl(this._self, this._then);

  final _QueueSettings _self;
  final $Res Function(_QueueSettings) _then;

/// Create a copy of QueueSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? maxQueueSize = null,Object? estimatedServiceTime = null,Object? autoAdvanceQueue = null,}) {
  return _then(_QueueSettings(
maxQueueSize: null == maxQueueSize ? _self.maxQueueSize : maxQueueSize // ignore: cast_nullable_to_non_nullable
as int,estimatedServiceTime: null == estimatedServiceTime ? _self.estimatedServiceTime : estimatedServiceTime // ignore: cast_nullable_to_non_nullable
as int,autoAdvanceQueue: null == autoAdvanceQueue ? _self.autoAdvanceQueue : autoAdvanceQueue // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
