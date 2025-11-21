// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QueueState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueState()';
}


}

/// @nodoc
class $QueueStateCopyWith<$Res>  {
$QueueStateCopyWith(QueueState _, $Res Function(QueueState) __);
}


/// Adds pattern-matching-related methods to [QueueState].
extension QueueStatePatterns on QueueState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( JoinQueueLoading value)?  joinQueueLoading,TResult Function( JoinQueueSuccess value)?  joinQueueSuccess,TResult Function( JoinQueueError value)?  joinQueueError,TResult Function( QueueStatusLoading value)?  queueStatusLoading,TResult Function( QueueStatusSuccess value)?  queueStatusSuccess,TResult Function( QueueStatusError value)?  queueStatusError,TResult Function( QueuePositionLoading value)?  queuePositionLoading,TResult Function( QueuePositionSuccess value)?  queuePositionSuccess,TResult Function( QueuePositionError value)?  queuePositionError,TResult Function( QueueActionLoading value)?  queueActionLoading,TResult Function( QueueActionSuccess value)?  queueActionSuccess,TResult Function( QueueActionError value)?  queueActionError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case JoinQueueLoading() when joinQueueLoading != null:
return joinQueueLoading(_that);case JoinQueueSuccess() when joinQueueSuccess != null:
return joinQueueSuccess(_that);case JoinQueueError() when joinQueueError != null:
return joinQueueError(_that);case QueueStatusLoading() when queueStatusLoading != null:
return queueStatusLoading(_that);case QueueStatusSuccess() when queueStatusSuccess != null:
return queueStatusSuccess(_that);case QueueStatusError() when queueStatusError != null:
return queueStatusError(_that);case QueuePositionLoading() when queuePositionLoading != null:
return queuePositionLoading(_that);case QueuePositionSuccess() when queuePositionSuccess != null:
return queuePositionSuccess(_that);case QueuePositionError() when queuePositionError != null:
return queuePositionError(_that);case QueueActionLoading() when queueActionLoading != null:
return queueActionLoading(_that);case QueueActionSuccess() when queueActionSuccess != null:
return queueActionSuccess(_that);case QueueActionError() when queueActionError != null:
return queueActionError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( JoinQueueLoading value)  joinQueueLoading,required TResult Function( JoinQueueSuccess value)  joinQueueSuccess,required TResult Function( JoinQueueError value)  joinQueueError,required TResult Function( QueueStatusLoading value)  queueStatusLoading,required TResult Function( QueueStatusSuccess value)  queueStatusSuccess,required TResult Function( QueueStatusError value)  queueStatusError,required TResult Function( QueuePositionLoading value)  queuePositionLoading,required TResult Function( QueuePositionSuccess value)  queuePositionSuccess,required TResult Function( QueuePositionError value)  queuePositionError,required TResult Function( QueueActionLoading value)  queueActionLoading,required TResult Function( QueueActionSuccess value)  queueActionSuccess,required TResult Function( QueueActionError value)  queueActionError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case JoinQueueLoading():
return joinQueueLoading(_that);case JoinQueueSuccess():
return joinQueueSuccess(_that);case JoinQueueError():
return joinQueueError(_that);case QueueStatusLoading():
return queueStatusLoading(_that);case QueueStatusSuccess():
return queueStatusSuccess(_that);case QueueStatusError():
return queueStatusError(_that);case QueuePositionLoading():
return queuePositionLoading(_that);case QueuePositionSuccess():
return queuePositionSuccess(_that);case QueuePositionError():
return queuePositionError(_that);case QueueActionLoading():
return queueActionLoading(_that);case QueueActionSuccess():
return queueActionSuccess(_that);case QueueActionError():
return queueActionError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( JoinQueueLoading value)?  joinQueueLoading,TResult? Function( JoinQueueSuccess value)?  joinQueueSuccess,TResult? Function( JoinQueueError value)?  joinQueueError,TResult? Function( QueueStatusLoading value)?  queueStatusLoading,TResult? Function( QueueStatusSuccess value)?  queueStatusSuccess,TResult? Function( QueueStatusError value)?  queueStatusError,TResult? Function( QueuePositionLoading value)?  queuePositionLoading,TResult? Function( QueuePositionSuccess value)?  queuePositionSuccess,TResult? Function( QueuePositionError value)?  queuePositionError,TResult? Function( QueueActionLoading value)?  queueActionLoading,TResult? Function( QueueActionSuccess value)?  queueActionSuccess,TResult? Function( QueueActionError value)?  queueActionError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case JoinQueueLoading() when joinQueueLoading != null:
return joinQueueLoading(_that);case JoinQueueSuccess() when joinQueueSuccess != null:
return joinQueueSuccess(_that);case JoinQueueError() when joinQueueError != null:
return joinQueueError(_that);case QueueStatusLoading() when queueStatusLoading != null:
return queueStatusLoading(_that);case QueueStatusSuccess() when queueStatusSuccess != null:
return queueStatusSuccess(_that);case QueueStatusError() when queueStatusError != null:
return queueStatusError(_that);case QueuePositionLoading() when queuePositionLoading != null:
return queuePositionLoading(_that);case QueuePositionSuccess() when queuePositionSuccess != null:
return queuePositionSuccess(_that);case QueuePositionError() when queuePositionError != null:
return queuePositionError(_that);case QueueActionLoading() when queueActionLoading != null:
return queueActionLoading(_that);case QueueActionSuccess() when queueActionSuccess != null:
return queueActionSuccess(_that);case QueueActionError() when queueActionError != null:
return queueActionError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  joinQueueLoading,TResult Function( QueuePositionData data)?  joinQueueSuccess,TResult Function( String error)?  joinQueueError,TResult Function()?  queueStatusLoading,TResult Function( QueueStatusData data)?  queueStatusSuccess,TResult Function( String error)?  queueStatusError,TResult Function()?  queuePositionLoading,TResult Function( QueuePositionData data)?  queuePositionSuccess,TResult Function( String error)?  queuePositionError,TResult Function()?  queueActionLoading,TResult Function( String message)?  queueActionSuccess,TResult Function( String error)?  queueActionError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case JoinQueueLoading() when joinQueueLoading != null:
return joinQueueLoading();case JoinQueueSuccess() when joinQueueSuccess != null:
return joinQueueSuccess(_that.data);case JoinQueueError() when joinQueueError != null:
return joinQueueError(_that.error);case QueueStatusLoading() when queueStatusLoading != null:
return queueStatusLoading();case QueueStatusSuccess() when queueStatusSuccess != null:
return queueStatusSuccess(_that.data);case QueueStatusError() when queueStatusError != null:
return queueStatusError(_that.error);case QueuePositionLoading() when queuePositionLoading != null:
return queuePositionLoading();case QueuePositionSuccess() when queuePositionSuccess != null:
return queuePositionSuccess(_that.data);case QueuePositionError() when queuePositionError != null:
return queuePositionError(_that.error);case QueueActionLoading() when queueActionLoading != null:
return queueActionLoading();case QueueActionSuccess() when queueActionSuccess != null:
return queueActionSuccess(_that.message);case QueueActionError() when queueActionError != null:
return queueActionError(_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  joinQueueLoading,required TResult Function( QueuePositionData data)  joinQueueSuccess,required TResult Function( String error)  joinQueueError,required TResult Function()  queueStatusLoading,required TResult Function( QueueStatusData data)  queueStatusSuccess,required TResult Function( String error)  queueStatusError,required TResult Function()  queuePositionLoading,required TResult Function( QueuePositionData data)  queuePositionSuccess,required TResult Function( String error)  queuePositionError,required TResult Function()  queueActionLoading,required TResult Function( String message)  queueActionSuccess,required TResult Function( String error)  queueActionError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case JoinQueueLoading():
return joinQueueLoading();case JoinQueueSuccess():
return joinQueueSuccess(_that.data);case JoinQueueError():
return joinQueueError(_that.error);case QueueStatusLoading():
return queueStatusLoading();case QueueStatusSuccess():
return queueStatusSuccess(_that.data);case QueueStatusError():
return queueStatusError(_that.error);case QueuePositionLoading():
return queuePositionLoading();case QueuePositionSuccess():
return queuePositionSuccess(_that.data);case QueuePositionError():
return queuePositionError(_that.error);case QueueActionLoading():
return queueActionLoading();case QueueActionSuccess():
return queueActionSuccess(_that.message);case QueueActionError():
return queueActionError(_that.error);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  joinQueueLoading,TResult? Function( QueuePositionData data)?  joinQueueSuccess,TResult? Function( String error)?  joinQueueError,TResult? Function()?  queueStatusLoading,TResult? Function( QueueStatusData data)?  queueStatusSuccess,TResult? Function( String error)?  queueStatusError,TResult? Function()?  queuePositionLoading,TResult? Function( QueuePositionData data)?  queuePositionSuccess,TResult? Function( String error)?  queuePositionError,TResult? Function()?  queueActionLoading,TResult? Function( String message)?  queueActionSuccess,TResult? Function( String error)?  queueActionError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case JoinQueueLoading() when joinQueueLoading != null:
return joinQueueLoading();case JoinQueueSuccess() when joinQueueSuccess != null:
return joinQueueSuccess(_that.data);case JoinQueueError() when joinQueueError != null:
return joinQueueError(_that.error);case QueueStatusLoading() when queueStatusLoading != null:
return queueStatusLoading();case QueueStatusSuccess() when queueStatusSuccess != null:
return queueStatusSuccess(_that.data);case QueueStatusError() when queueStatusError != null:
return queueStatusError(_that.error);case QueuePositionLoading() when queuePositionLoading != null:
return queuePositionLoading();case QueuePositionSuccess() when queuePositionSuccess != null:
return queuePositionSuccess(_that.data);case QueuePositionError() when queuePositionError != null:
return queuePositionError(_that.error);case QueueActionLoading() when queueActionLoading != null:
return queueActionLoading();case QueueActionSuccess() when queueActionSuccess != null:
return queueActionSuccess(_that.message);case QueueActionError() when queueActionError != null:
return queueActionError(_that.error);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements QueueState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueState.initial()';
}


}




/// @nodoc


class JoinQueueLoading implements QueueState {
  const JoinQueueLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinQueueLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueState.joinQueueLoading()';
}


}




/// @nodoc


class JoinQueueSuccess implements QueueState {
  const JoinQueueSuccess(this.data);
  

 final  QueuePositionData data;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinQueueSuccessCopyWith<JoinQueueSuccess> get copyWith => _$JoinQueueSuccessCopyWithImpl<JoinQueueSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinQueueSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'QueueState.joinQueueSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $JoinQueueSuccessCopyWith<$Res> implements $QueueStateCopyWith<$Res> {
  factory $JoinQueueSuccessCopyWith(JoinQueueSuccess value, $Res Function(JoinQueueSuccess) _then) = _$JoinQueueSuccessCopyWithImpl;
@useResult
$Res call({
 QueuePositionData data
});




}
/// @nodoc
class _$JoinQueueSuccessCopyWithImpl<$Res>
    implements $JoinQueueSuccessCopyWith<$Res> {
  _$JoinQueueSuccessCopyWithImpl(this._self, this._then);

  final JoinQueueSuccess _self;
  final $Res Function(JoinQueueSuccess) _then;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(JoinQueueSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as QueuePositionData,
  ));
}


}

/// @nodoc


class JoinQueueError implements QueueState {
  const JoinQueueError(this.error);
  

 final  String error;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JoinQueueErrorCopyWith<JoinQueueError> get copyWith => _$JoinQueueErrorCopyWithImpl<JoinQueueError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JoinQueueError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'QueueState.joinQueueError(error: $error)';
}


}

/// @nodoc
abstract mixin class $JoinQueueErrorCopyWith<$Res> implements $QueueStateCopyWith<$Res> {
  factory $JoinQueueErrorCopyWith(JoinQueueError value, $Res Function(JoinQueueError) _then) = _$JoinQueueErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$JoinQueueErrorCopyWithImpl<$Res>
    implements $JoinQueueErrorCopyWith<$Res> {
  _$JoinQueueErrorCopyWithImpl(this._self, this._then);

  final JoinQueueError _self;
  final $Res Function(JoinQueueError) _then;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(JoinQueueError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class QueueStatusLoading implements QueueState {
  const QueueStatusLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueStatusLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueState.queueStatusLoading()';
}


}




/// @nodoc


class QueueStatusSuccess implements QueueState {
  const QueueStatusSuccess(this.data);
  

 final  QueueStatusData data;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueStatusSuccessCopyWith<QueueStatusSuccess> get copyWith => _$QueueStatusSuccessCopyWithImpl<QueueStatusSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueStatusSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'QueueState.queueStatusSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $QueueStatusSuccessCopyWith<$Res> implements $QueueStateCopyWith<$Res> {
  factory $QueueStatusSuccessCopyWith(QueueStatusSuccess value, $Res Function(QueueStatusSuccess) _then) = _$QueueStatusSuccessCopyWithImpl;
@useResult
$Res call({
 QueueStatusData data
});




}
/// @nodoc
class _$QueueStatusSuccessCopyWithImpl<$Res>
    implements $QueueStatusSuccessCopyWith<$Res> {
  _$QueueStatusSuccessCopyWithImpl(this._self, this._then);

  final QueueStatusSuccess _self;
  final $Res Function(QueueStatusSuccess) _then;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(QueueStatusSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as QueueStatusData,
  ));
}


}

/// @nodoc


class QueueStatusError implements QueueState {
  const QueueStatusError(this.error);
  

 final  String error;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueStatusErrorCopyWith<QueueStatusError> get copyWith => _$QueueStatusErrorCopyWithImpl<QueueStatusError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueStatusError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'QueueState.queueStatusError(error: $error)';
}


}

/// @nodoc
abstract mixin class $QueueStatusErrorCopyWith<$Res> implements $QueueStateCopyWith<$Res> {
  factory $QueueStatusErrorCopyWith(QueueStatusError value, $Res Function(QueueStatusError) _then) = _$QueueStatusErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$QueueStatusErrorCopyWithImpl<$Res>
    implements $QueueStatusErrorCopyWith<$Res> {
  _$QueueStatusErrorCopyWithImpl(this._self, this._then);

  final QueueStatusError _self;
  final $Res Function(QueueStatusError) _then;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(QueueStatusError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class QueuePositionLoading implements QueueState {
  const QueuePositionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueuePositionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueState.queuePositionLoading()';
}


}




/// @nodoc


class QueuePositionSuccess implements QueueState {
  const QueuePositionSuccess(this.data);
  

 final  QueuePositionData data;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueuePositionSuccessCopyWith<QueuePositionSuccess> get copyWith => _$QueuePositionSuccessCopyWithImpl<QueuePositionSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueuePositionSuccess&&(identical(other.data, data) || other.data == data));
}


@override
int get hashCode => Object.hash(runtimeType,data);

@override
String toString() {
  return 'QueueState.queuePositionSuccess(data: $data)';
}


}

/// @nodoc
abstract mixin class $QueuePositionSuccessCopyWith<$Res> implements $QueueStateCopyWith<$Res> {
  factory $QueuePositionSuccessCopyWith(QueuePositionSuccess value, $Res Function(QueuePositionSuccess) _then) = _$QueuePositionSuccessCopyWithImpl;
@useResult
$Res call({
 QueuePositionData data
});




}
/// @nodoc
class _$QueuePositionSuccessCopyWithImpl<$Res>
    implements $QueuePositionSuccessCopyWith<$Res> {
  _$QueuePositionSuccessCopyWithImpl(this._self, this._then);

  final QueuePositionSuccess _self;
  final $Res Function(QueuePositionSuccess) _then;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? data = null,}) {
  return _then(QueuePositionSuccess(
null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as QueuePositionData,
  ));
}


}

/// @nodoc


class QueuePositionError implements QueueState {
  const QueuePositionError(this.error);
  

 final  String error;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueuePositionErrorCopyWith<QueuePositionError> get copyWith => _$QueuePositionErrorCopyWithImpl<QueuePositionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueuePositionError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'QueueState.queuePositionError(error: $error)';
}


}

/// @nodoc
abstract mixin class $QueuePositionErrorCopyWith<$Res> implements $QueueStateCopyWith<$Res> {
  factory $QueuePositionErrorCopyWith(QueuePositionError value, $Res Function(QueuePositionError) _then) = _$QueuePositionErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$QueuePositionErrorCopyWithImpl<$Res>
    implements $QueuePositionErrorCopyWith<$Res> {
  _$QueuePositionErrorCopyWithImpl(this._self, this._then);

  final QueuePositionError _self;
  final $Res Function(QueuePositionError) _then;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(QueuePositionError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class QueueActionLoading implements QueueState {
  const QueueActionLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueActionLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QueueState.queueActionLoading()';
}


}




/// @nodoc


class QueueActionSuccess implements QueueState {
  const QueueActionSuccess(this.message);
  

 final  String message;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueActionSuccessCopyWith<QueueActionSuccess> get copyWith => _$QueueActionSuccessCopyWithImpl<QueueActionSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueActionSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'QueueState.queueActionSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class $QueueActionSuccessCopyWith<$Res> implements $QueueStateCopyWith<$Res> {
  factory $QueueActionSuccessCopyWith(QueueActionSuccess value, $Res Function(QueueActionSuccess) _then) = _$QueueActionSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$QueueActionSuccessCopyWithImpl<$Res>
    implements $QueueActionSuccessCopyWith<$Res> {
  _$QueueActionSuccessCopyWithImpl(this._self, this._then);

  final QueueActionSuccess _self;
  final $Res Function(QueueActionSuccess) _then;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(QueueActionSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class QueueActionError implements QueueState {
  const QueueActionError(this.error);
  

 final  String error;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueActionErrorCopyWith<QueueActionError> get copyWith => _$QueueActionErrorCopyWithImpl<QueueActionError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueActionError&&(identical(other.error, error) || other.error == error));
}


@override
int get hashCode => Object.hash(runtimeType,error);

@override
String toString() {
  return 'QueueState.queueActionError(error: $error)';
}


}

/// @nodoc
abstract mixin class $QueueActionErrorCopyWith<$Res> implements $QueueStateCopyWith<$Res> {
  factory $QueueActionErrorCopyWith(QueueActionError value, $Res Function(QueueActionError) _then) = _$QueueActionErrorCopyWithImpl;
@useResult
$Res call({
 String error
});




}
/// @nodoc
class _$QueueActionErrorCopyWithImpl<$Res>
    implements $QueueActionErrorCopyWith<$Res> {
  _$QueueActionErrorCopyWithImpl(this._self, this._then);

  final QueueActionError _self;
  final $Res Function(QueueActionError) _then;

/// Create a copy of QueueState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? error = null,}) {
  return _then(QueueActionError(
null == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
