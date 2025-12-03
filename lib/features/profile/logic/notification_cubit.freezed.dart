// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState()';
}


}

/// @nodoc
class $NotificationStateCopyWith<$Res>  {
$NotificationStateCopyWith(NotificationState _, $Res Function(NotificationState) __);
}


/// Adds pattern-matching-related methods to [NotificationState].
extension NotificationStatePatterns on NotificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _SettingsLoaded value)?  settingsLoaded,TResult Function( _SettingsUpdated value)?  settingsUpdated,TResult Function( _HistoryLoaded value)?  historyLoaded,TResult Function( _PermissionGranted value)?  permissionGranted,TResult Function( _PermissionDenied value)?  permissionDenied,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _SettingsLoaded() when settingsLoaded != null:
return settingsLoaded(_that);case _SettingsUpdated() when settingsUpdated != null:
return settingsUpdated(_that);case _HistoryLoaded() when historyLoaded != null:
return historyLoaded(_that);case _PermissionGranted() when permissionGranted != null:
return permissionGranted(_that);case _PermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _SettingsLoaded value)  settingsLoaded,required TResult Function( _SettingsUpdated value)  settingsUpdated,required TResult Function( _HistoryLoaded value)  historyLoaded,required TResult Function( _PermissionGranted value)  permissionGranted,required TResult Function( _PermissionDenied value)  permissionDenied,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _SettingsLoaded():
return settingsLoaded(_that);case _SettingsUpdated():
return settingsUpdated(_that);case _HistoryLoaded():
return historyLoaded(_that);case _PermissionGranted():
return permissionGranted(_that);case _PermissionDenied():
return permissionDenied(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _SettingsLoaded value)?  settingsLoaded,TResult? Function( _SettingsUpdated value)?  settingsUpdated,TResult? Function( _HistoryLoaded value)?  historyLoaded,TResult? Function( _PermissionGranted value)?  permissionGranted,TResult? Function( _PermissionDenied value)?  permissionDenied,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _SettingsLoaded() when settingsLoaded != null:
return settingsLoaded(_that);case _SettingsUpdated() when settingsUpdated != null:
return settingsUpdated(_that);case _HistoryLoaded() when historyLoaded != null:
return historyLoaded(_that);case _PermissionGranted() when permissionGranted != null:
return permissionGranted(_that);case _PermissionDenied() when permissionDenied != null:
return permissionDenied(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( NotificationSettingsResponse settings)?  settingsLoaded,TResult Function( NotificationResponse response)?  settingsUpdated,TResult Function( NotificationHistoryResponse history)?  historyLoaded,TResult Function()?  permissionGranted,TResult Function()?  permissionDenied,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _SettingsLoaded() when settingsLoaded != null:
return settingsLoaded(_that.settings);case _SettingsUpdated() when settingsUpdated != null:
return settingsUpdated(_that.response);case _HistoryLoaded() when historyLoaded != null:
return historyLoaded(_that.history);case _PermissionGranted() when permissionGranted != null:
return permissionGranted();case _PermissionDenied() when permissionDenied != null:
return permissionDenied();case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( NotificationSettingsResponse settings)  settingsLoaded,required TResult Function( NotificationResponse response)  settingsUpdated,required TResult Function( NotificationHistoryResponse history)  historyLoaded,required TResult Function()  permissionGranted,required TResult Function()  permissionDenied,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _SettingsLoaded():
return settingsLoaded(_that.settings);case _SettingsUpdated():
return settingsUpdated(_that.response);case _HistoryLoaded():
return historyLoaded(_that.history);case _PermissionGranted():
return permissionGranted();case _PermissionDenied():
return permissionDenied();case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( NotificationSettingsResponse settings)?  settingsLoaded,TResult? Function( NotificationResponse response)?  settingsUpdated,TResult? Function( NotificationHistoryResponse history)?  historyLoaded,TResult? Function()?  permissionGranted,TResult? Function()?  permissionDenied,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _SettingsLoaded() when settingsLoaded != null:
return settingsLoaded(_that.settings);case _SettingsUpdated() when settingsUpdated != null:
return settingsUpdated(_that.response);case _HistoryLoaded() when historyLoaded != null:
return historyLoaded(_that.history);case _PermissionGranted() when permissionGranted != null:
return permissionGranted();case _PermissionDenied() when permissionDenied != null:
return permissionDenied();case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements NotificationState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState.initial()';
}


}




/// @nodoc


class _Loading implements NotificationState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState.loading()';
}


}




/// @nodoc


class _SettingsLoaded implements NotificationState {
  const _SettingsLoaded(this.settings);
  

 final  NotificationSettingsResponse settings;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsLoadedCopyWith<_SettingsLoaded> get copyWith => __$SettingsLoadedCopyWithImpl<_SettingsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsLoaded&&(identical(other.settings, settings) || other.settings == settings));
}


@override
int get hashCode => Object.hash(runtimeType,settings);

@override
String toString() {
  return 'NotificationState.settingsLoaded(settings: $settings)';
}


}

/// @nodoc
abstract mixin class _$SettingsLoadedCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory _$SettingsLoadedCopyWith(_SettingsLoaded value, $Res Function(_SettingsLoaded) _then) = __$SettingsLoadedCopyWithImpl;
@useResult
$Res call({
 NotificationSettingsResponse settings
});




}
/// @nodoc
class __$SettingsLoadedCopyWithImpl<$Res>
    implements _$SettingsLoadedCopyWith<$Res> {
  __$SettingsLoadedCopyWithImpl(this._self, this._then);

  final _SettingsLoaded _self;
  final $Res Function(_SettingsLoaded) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? settings = null,}) {
  return _then(_SettingsLoaded(
null == settings ? _self.settings : settings // ignore: cast_nullable_to_non_nullable
as NotificationSettingsResponse,
  ));
}


}

/// @nodoc


class _SettingsUpdated implements NotificationState {
  const _SettingsUpdated(this.response);
  

 final  NotificationResponse response;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsUpdatedCopyWith<_SettingsUpdated> get copyWith => __$SettingsUpdatedCopyWithImpl<_SettingsUpdated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsUpdated&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'NotificationState.settingsUpdated(response: $response)';
}


}

/// @nodoc
abstract mixin class _$SettingsUpdatedCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory _$SettingsUpdatedCopyWith(_SettingsUpdated value, $Res Function(_SettingsUpdated) _then) = __$SettingsUpdatedCopyWithImpl;
@useResult
$Res call({
 NotificationResponse response
});




}
/// @nodoc
class __$SettingsUpdatedCopyWithImpl<$Res>
    implements _$SettingsUpdatedCopyWith<$Res> {
  __$SettingsUpdatedCopyWithImpl(this._self, this._then);

  final _SettingsUpdated _self;
  final $Res Function(_SettingsUpdated) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_SettingsUpdated(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as NotificationResponse,
  ));
}


}

/// @nodoc


class _HistoryLoaded implements NotificationState {
  const _HistoryLoaded(this.history);
  

 final  NotificationHistoryResponse history;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryLoadedCopyWith<_HistoryLoaded> get copyWith => __$HistoryLoadedCopyWithImpl<_HistoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryLoaded&&(identical(other.history, history) || other.history == history));
}


@override
int get hashCode => Object.hash(runtimeType,history);

@override
String toString() {
  return 'NotificationState.historyLoaded(history: $history)';
}


}

/// @nodoc
abstract mixin class _$HistoryLoadedCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory _$HistoryLoadedCopyWith(_HistoryLoaded value, $Res Function(_HistoryLoaded) _then) = __$HistoryLoadedCopyWithImpl;
@useResult
$Res call({
 NotificationHistoryResponse history
});




}
/// @nodoc
class __$HistoryLoadedCopyWithImpl<$Res>
    implements _$HistoryLoadedCopyWith<$Res> {
  __$HistoryLoadedCopyWithImpl(this._self, this._then);

  final _HistoryLoaded _self;
  final $Res Function(_HistoryLoaded) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? history = null,}) {
  return _then(_HistoryLoaded(
null == history ? _self.history : history // ignore: cast_nullable_to_non_nullable
as NotificationHistoryResponse,
  ));
}


}

/// @nodoc


class _PermissionGranted implements NotificationState {
  const _PermissionGranted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PermissionGranted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState.permissionGranted()';
}


}




/// @nodoc


class _PermissionDenied implements NotificationState {
  const _PermissionDenied();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PermissionDenied);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationState.permissionDenied()';
}


}




/// @nodoc


class _Error implements NotificationState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'NotificationState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $NotificationStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of NotificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
