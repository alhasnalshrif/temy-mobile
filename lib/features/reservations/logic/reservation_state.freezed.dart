// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReservationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReservationState()';
}


}

/// @nodoc
class $ReservationStateCopyWith<$Res>  {
$ReservationStateCopyWith(ReservationState _, $Res Function(ReservationState) __);
}


/// Adds pattern-matching-related methods to [ReservationState].
extension ReservationStatePatterns on ReservationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( ReservationLoading value)?  reservationLoading,TResult Function( ReservationSuccess value)?  reservationSuccess,TResult Function( ReservationError value)?  reservationError,TResult Function( TimeSlotsLoading value)?  timeSlotsLoading,TResult Function( TimeSlotsSuccess value)?  timeSlotsSuccess,TResult Function( TimeSlotsError value)?  timeSlotsError,TResult Function( QueueSettingsLoading value)?  queueSettingsLoading,TResult Function( QueueSettingsSuccess value)?  queueSettingsSuccess,TResult Function( QueueSettingsError value)?  queueSettingsError,TResult Function( OtpRequestLoading value)?  otpRequestLoading,TResult Function( OtpRequestSuccess value)?  otpRequestSuccess,TResult Function( OtpRequestError value)?  otpRequestError,TResult Function( OtpVerificationLoading value)?  otpVerificationLoading,TResult Function( OtpVerificationSuccess value)?  otpVerificationSuccess,TResult Function( OtpVerificationError value)?  otpVerificationError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ReservationLoading() when reservationLoading != null:
return reservationLoading(_that);case ReservationSuccess() when reservationSuccess != null:
return reservationSuccess(_that);case ReservationError() when reservationError != null:
return reservationError(_that);case TimeSlotsLoading() when timeSlotsLoading != null:
return timeSlotsLoading(_that);case TimeSlotsSuccess() when timeSlotsSuccess != null:
return timeSlotsSuccess(_that);case TimeSlotsError() when timeSlotsError != null:
return timeSlotsError(_that);case QueueSettingsLoading() when queueSettingsLoading != null:
return queueSettingsLoading(_that);case QueueSettingsSuccess() when queueSettingsSuccess != null:
return queueSettingsSuccess(_that);case QueueSettingsError() when queueSettingsError != null:
return queueSettingsError(_that);case OtpRequestLoading() when otpRequestLoading != null:
return otpRequestLoading(_that);case OtpRequestSuccess() when otpRequestSuccess != null:
return otpRequestSuccess(_that);case OtpRequestError() when otpRequestError != null:
return otpRequestError(_that);case OtpVerificationLoading() when otpVerificationLoading != null:
return otpVerificationLoading(_that);case OtpVerificationSuccess() when otpVerificationSuccess != null:
return otpVerificationSuccess(_that);case OtpVerificationError() when otpVerificationError != null:
return otpVerificationError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( ReservationLoading value)  reservationLoading,required TResult Function( ReservationSuccess value)  reservationSuccess,required TResult Function( ReservationError value)  reservationError,required TResult Function( TimeSlotsLoading value)  timeSlotsLoading,required TResult Function( TimeSlotsSuccess value)  timeSlotsSuccess,required TResult Function( TimeSlotsError value)  timeSlotsError,required TResult Function( QueueSettingsLoading value)  queueSettingsLoading,required TResult Function( QueueSettingsSuccess value)  queueSettingsSuccess,required TResult Function( QueueSettingsError value)  queueSettingsError,required TResult Function( OtpRequestLoading value)  otpRequestLoading,required TResult Function( OtpRequestSuccess value)  otpRequestSuccess,required TResult Function( OtpRequestError value)  otpRequestError,required TResult Function( OtpVerificationLoading value)  otpVerificationLoading,required TResult Function( OtpVerificationSuccess value)  otpVerificationSuccess,required TResult Function( OtpVerificationError value)  otpVerificationError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case ReservationLoading():
return reservationLoading(_that);case ReservationSuccess():
return reservationSuccess(_that);case ReservationError():
return reservationError(_that);case TimeSlotsLoading():
return timeSlotsLoading(_that);case TimeSlotsSuccess():
return timeSlotsSuccess(_that);case TimeSlotsError():
return timeSlotsError(_that);case QueueSettingsLoading():
return queueSettingsLoading(_that);case QueueSettingsSuccess():
return queueSettingsSuccess(_that);case QueueSettingsError():
return queueSettingsError(_that);case OtpRequestLoading():
return otpRequestLoading(_that);case OtpRequestSuccess():
return otpRequestSuccess(_that);case OtpRequestError():
return otpRequestError(_that);case OtpVerificationLoading():
return otpVerificationLoading(_that);case OtpVerificationSuccess():
return otpVerificationSuccess(_that);case OtpVerificationError():
return otpVerificationError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( ReservationLoading value)?  reservationLoading,TResult? Function( ReservationSuccess value)?  reservationSuccess,TResult? Function( ReservationError value)?  reservationError,TResult? Function( TimeSlotsLoading value)?  timeSlotsLoading,TResult? Function( TimeSlotsSuccess value)?  timeSlotsSuccess,TResult? Function( TimeSlotsError value)?  timeSlotsError,TResult? Function( QueueSettingsLoading value)?  queueSettingsLoading,TResult? Function( QueueSettingsSuccess value)?  queueSettingsSuccess,TResult? Function( QueueSettingsError value)?  queueSettingsError,TResult? Function( OtpRequestLoading value)?  otpRequestLoading,TResult? Function( OtpRequestSuccess value)?  otpRequestSuccess,TResult? Function( OtpRequestError value)?  otpRequestError,TResult? Function( OtpVerificationLoading value)?  otpVerificationLoading,TResult? Function( OtpVerificationSuccess value)?  otpVerificationSuccess,TResult? Function( OtpVerificationError value)?  otpVerificationError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ReservationLoading() when reservationLoading != null:
return reservationLoading(_that);case ReservationSuccess() when reservationSuccess != null:
return reservationSuccess(_that);case ReservationError() when reservationError != null:
return reservationError(_that);case TimeSlotsLoading() when timeSlotsLoading != null:
return timeSlotsLoading(_that);case TimeSlotsSuccess() when timeSlotsSuccess != null:
return timeSlotsSuccess(_that);case TimeSlotsError() when timeSlotsError != null:
return timeSlotsError(_that);case QueueSettingsLoading() when queueSettingsLoading != null:
return queueSettingsLoading(_that);case QueueSettingsSuccess() when queueSettingsSuccess != null:
return queueSettingsSuccess(_that);case QueueSettingsError() when queueSettingsError != null:
return queueSettingsError(_that);case OtpRequestLoading() when otpRequestLoading != null:
return otpRequestLoading(_that);case OtpRequestSuccess() when otpRequestSuccess != null:
return otpRequestSuccess(_that);case OtpRequestError() when otpRequestError != null:
return otpRequestError(_that);case OtpVerificationLoading() when otpVerificationLoading != null:
return otpVerificationLoading(_that);case OtpVerificationSuccess() when otpVerificationSuccess != null:
return otpVerificationSuccess(_that);case OtpVerificationError() when otpVerificationError != null:
return otpVerificationError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  reservationLoading,TResult Function( ReservationResponseModel reservationRequestModel,  ReservationArguments? arguments)?  reservationSuccess,TResult Function( ErrorHandler errorHandler)?  reservationError,TResult Function()?  timeSlotsLoading,TResult Function( TimeSlotsResponse timeSlotsResponse)?  timeSlotsSuccess,TResult Function( ErrorHandler errorHandler)?  timeSlotsError,TResult Function()?  queueSettingsLoading,TResult Function( QueueSettingsResponse settingsResponse)?  queueSettingsSuccess,TResult Function( ErrorHandler errorHandler)?  queueSettingsError,TResult Function()?  otpRequestLoading,TResult Function( OtpResponse otpResponse)?  otpRequestSuccess,TResult Function( ErrorHandler errorHandler)?  otpRequestError,TResult Function()?  otpVerificationLoading,TResult Function( ReservationResponseModel reservationResponse,  ReservationArguments? arguments)?  otpVerificationSuccess,TResult Function( ErrorHandler errorHandler)?  otpVerificationError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ReservationLoading() when reservationLoading != null:
return reservationLoading();case ReservationSuccess() when reservationSuccess != null:
return reservationSuccess(_that.reservationRequestModel,_that.arguments);case ReservationError() when reservationError != null:
return reservationError(_that.errorHandler);case TimeSlotsLoading() when timeSlotsLoading != null:
return timeSlotsLoading();case TimeSlotsSuccess() when timeSlotsSuccess != null:
return timeSlotsSuccess(_that.timeSlotsResponse);case TimeSlotsError() when timeSlotsError != null:
return timeSlotsError(_that.errorHandler);case QueueSettingsLoading() when queueSettingsLoading != null:
return queueSettingsLoading();case QueueSettingsSuccess() when queueSettingsSuccess != null:
return queueSettingsSuccess(_that.settingsResponse);case QueueSettingsError() when queueSettingsError != null:
return queueSettingsError(_that.errorHandler);case OtpRequestLoading() when otpRequestLoading != null:
return otpRequestLoading();case OtpRequestSuccess() when otpRequestSuccess != null:
return otpRequestSuccess(_that.otpResponse);case OtpRequestError() when otpRequestError != null:
return otpRequestError(_that.errorHandler);case OtpVerificationLoading() when otpVerificationLoading != null:
return otpVerificationLoading();case OtpVerificationSuccess() when otpVerificationSuccess != null:
return otpVerificationSuccess(_that.reservationResponse,_that.arguments);case OtpVerificationError() when otpVerificationError != null:
return otpVerificationError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  reservationLoading,required TResult Function( ReservationResponseModel reservationRequestModel,  ReservationArguments? arguments)  reservationSuccess,required TResult Function( ErrorHandler errorHandler)  reservationError,required TResult Function()  timeSlotsLoading,required TResult Function( TimeSlotsResponse timeSlotsResponse)  timeSlotsSuccess,required TResult Function( ErrorHandler errorHandler)  timeSlotsError,required TResult Function()  queueSettingsLoading,required TResult Function( QueueSettingsResponse settingsResponse)  queueSettingsSuccess,required TResult Function( ErrorHandler errorHandler)  queueSettingsError,required TResult Function()  otpRequestLoading,required TResult Function( OtpResponse otpResponse)  otpRequestSuccess,required TResult Function( ErrorHandler errorHandler)  otpRequestError,required TResult Function()  otpVerificationLoading,required TResult Function( ReservationResponseModel reservationResponse,  ReservationArguments? arguments)  otpVerificationSuccess,required TResult Function( ErrorHandler errorHandler)  otpVerificationError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case ReservationLoading():
return reservationLoading();case ReservationSuccess():
return reservationSuccess(_that.reservationRequestModel,_that.arguments);case ReservationError():
return reservationError(_that.errorHandler);case TimeSlotsLoading():
return timeSlotsLoading();case TimeSlotsSuccess():
return timeSlotsSuccess(_that.timeSlotsResponse);case TimeSlotsError():
return timeSlotsError(_that.errorHandler);case QueueSettingsLoading():
return queueSettingsLoading();case QueueSettingsSuccess():
return queueSettingsSuccess(_that.settingsResponse);case QueueSettingsError():
return queueSettingsError(_that.errorHandler);case OtpRequestLoading():
return otpRequestLoading();case OtpRequestSuccess():
return otpRequestSuccess(_that.otpResponse);case OtpRequestError():
return otpRequestError(_that.errorHandler);case OtpVerificationLoading():
return otpVerificationLoading();case OtpVerificationSuccess():
return otpVerificationSuccess(_that.reservationResponse,_that.arguments);case OtpVerificationError():
return otpVerificationError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  reservationLoading,TResult? Function( ReservationResponseModel reservationRequestModel,  ReservationArguments? arguments)?  reservationSuccess,TResult? Function( ErrorHandler errorHandler)?  reservationError,TResult? Function()?  timeSlotsLoading,TResult? Function( TimeSlotsResponse timeSlotsResponse)?  timeSlotsSuccess,TResult? Function( ErrorHandler errorHandler)?  timeSlotsError,TResult? Function()?  queueSettingsLoading,TResult? Function( QueueSettingsResponse settingsResponse)?  queueSettingsSuccess,TResult? Function( ErrorHandler errorHandler)?  queueSettingsError,TResult? Function()?  otpRequestLoading,TResult? Function( OtpResponse otpResponse)?  otpRequestSuccess,TResult? Function( ErrorHandler errorHandler)?  otpRequestError,TResult? Function()?  otpVerificationLoading,TResult? Function( ReservationResponseModel reservationResponse,  ReservationArguments? arguments)?  otpVerificationSuccess,TResult? Function( ErrorHandler errorHandler)?  otpVerificationError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ReservationLoading() when reservationLoading != null:
return reservationLoading();case ReservationSuccess() when reservationSuccess != null:
return reservationSuccess(_that.reservationRequestModel,_that.arguments);case ReservationError() when reservationError != null:
return reservationError(_that.errorHandler);case TimeSlotsLoading() when timeSlotsLoading != null:
return timeSlotsLoading();case TimeSlotsSuccess() when timeSlotsSuccess != null:
return timeSlotsSuccess(_that.timeSlotsResponse);case TimeSlotsError() when timeSlotsError != null:
return timeSlotsError(_that.errorHandler);case QueueSettingsLoading() when queueSettingsLoading != null:
return queueSettingsLoading();case QueueSettingsSuccess() when queueSettingsSuccess != null:
return queueSettingsSuccess(_that.settingsResponse);case QueueSettingsError() when queueSettingsError != null:
return queueSettingsError(_that.errorHandler);case OtpRequestLoading() when otpRequestLoading != null:
return otpRequestLoading();case OtpRequestSuccess() when otpRequestSuccess != null:
return otpRequestSuccess(_that.otpResponse);case OtpRequestError() when otpRequestError != null:
return otpRequestError(_that.errorHandler);case OtpVerificationLoading() when otpVerificationLoading != null:
return otpVerificationLoading();case OtpVerificationSuccess() when otpVerificationSuccess != null:
return otpVerificationSuccess(_that.reservationResponse,_that.arguments);case OtpVerificationError() when otpVerificationError != null:
return otpVerificationError(_that.errorHandler);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ReservationState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReservationState.initial()';
}


}




/// @nodoc


class ReservationLoading implements ReservationState {
  const ReservationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReservationState.reservationLoading()';
}


}




/// @nodoc


class ReservationSuccess implements ReservationState {
  const ReservationSuccess(this.reservationRequestModel, {this.arguments});
  

 final  ReservationResponseModel reservationRequestModel;
 final  ReservationArguments? arguments;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationSuccessCopyWith<ReservationSuccess> get copyWith => _$ReservationSuccessCopyWithImpl<ReservationSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationSuccess&&(identical(other.reservationRequestModel, reservationRequestModel) || other.reservationRequestModel == reservationRequestModel)&&(identical(other.arguments, arguments) || other.arguments == arguments));
}


@override
int get hashCode => Object.hash(runtimeType,reservationRequestModel,arguments);

@override
String toString() {
  return 'ReservationState.reservationSuccess(reservationRequestModel: $reservationRequestModel, arguments: $arguments)';
}


}

/// @nodoc
abstract mixin class $ReservationSuccessCopyWith<$Res> implements $ReservationStateCopyWith<$Res> {
  factory $ReservationSuccessCopyWith(ReservationSuccess value, $Res Function(ReservationSuccess) _then) = _$ReservationSuccessCopyWithImpl;
@useResult
$Res call({
 ReservationResponseModel reservationRequestModel, ReservationArguments? arguments
});




}
/// @nodoc
class _$ReservationSuccessCopyWithImpl<$Res>
    implements $ReservationSuccessCopyWith<$Res> {
  _$ReservationSuccessCopyWithImpl(this._self, this._then);

  final ReservationSuccess _self;
  final $Res Function(ReservationSuccess) _then;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reservationRequestModel = null,Object? arguments = freezed,}) {
  return _then(ReservationSuccess(
null == reservationRequestModel ? _self.reservationRequestModel : reservationRequestModel // ignore: cast_nullable_to_non_nullable
as ReservationResponseModel,arguments: freezed == arguments ? _self.arguments : arguments // ignore: cast_nullable_to_non_nullable
as ReservationArguments?,
  ));
}


}

/// @nodoc


class ReservationError implements ReservationState {
  const ReservationError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationErrorCopyWith<ReservationError> get copyWith => _$ReservationErrorCopyWithImpl<ReservationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'ReservationState.reservationError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $ReservationErrorCopyWith<$Res> implements $ReservationStateCopyWith<$Res> {
  factory $ReservationErrorCopyWith(ReservationError value, $Res Function(ReservationError) _then) = _$ReservationErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$ReservationErrorCopyWithImpl<$Res>
    implements $ReservationErrorCopyWith<$Res> {
  _$ReservationErrorCopyWithImpl(this._self, this._then);

  final ReservationError _self;
  final $Res Function(ReservationError) _then;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(ReservationError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

/// @nodoc


class TimeSlotsLoading implements ReservationState {
  const TimeSlotsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeSlotsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReservationState.timeSlotsLoading()';
}


}




/// @nodoc


class TimeSlotsSuccess implements ReservationState {
  const TimeSlotsSuccess(this.timeSlotsResponse);
  

 final  TimeSlotsResponse timeSlotsResponse;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeSlotsSuccessCopyWith<TimeSlotsSuccess> get copyWith => _$TimeSlotsSuccessCopyWithImpl<TimeSlotsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeSlotsSuccess&&(identical(other.timeSlotsResponse, timeSlotsResponse) || other.timeSlotsResponse == timeSlotsResponse));
}


@override
int get hashCode => Object.hash(runtimeType,timeSlotsResponse);

@override
String toString() {
  return 'ReservationState.timeSlotsSuccess(timeSlotsResponse: $timeSlotsResponse)';
}


}

/// @nodoc
abstract mixin class $TimeSlotsSuccessCopyWith<$Res> implements $ReservationStateCopyWith<$Res> {
  factory $TimeSlotsSuccessCopyWith(TimeSlotsSuccess value, $Res Function(TimeSlotsSuccess) _then) = _$TimeSlotsSuccessCopyWithImpl;
@useResult
$Res call({
 TimeSlotsResponse timeSlotsResponse
});




}
/// @nodoc
class _$TimeSlotsSuccessCopyWithImpl<$Res>
    implements $TimeSlotsSuccessCopyWith<$Res> {
  _$TimeSlotsSuccessCopyWithImpl(this._self, this._then);

  final TimeSlotsSuccess _self;
  final $Res Function(TimeSlotsSuccess) _then;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timeSlotsResponse = null,}) {
  return _then(TimeSlotsSuccess(
null == timeSlotsResponse ? _self.timeSlotsResponse : timeSlotsResponse // ignore: cast_nullable_to_non_nullable
as TimeSlotsResponse,
  ));
}


}

/// @nodoc


class TimeSlotsError implements ReservationState {
  const TimeSlotsError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeSlotsErrorCopyWith<TimeSlotsError> get copyWith => _$TimeSlotsErrorCopyWithImpl<TimeSlotsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeSlotsError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'ReservationState.timeSlotsError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $TimeSlotsErrorCopyWith<$Res> implements $ReservationStateCopyWith<$Res> {
  factory $TimeSlotsErrorCopyWith(TimeSlotsError value, $Res Function(TimeSlotsError) _then) = _$TimeSlotsErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$TimeSlotsErrorCopyWithImpl<$Res>
    implements $TimeSlotsErrorCopyWith<$Res> {
  _$TimeSlotsErrorCopyWithImpl(this._self, this._then);

  final TimeSlotsError _self;
  final $Res Function(TimeSlotsError) _then;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(TimeSlotsError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

/// @nodoc


class QueueSettingsLoading implements ReservationState {
  const QueueSettingsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueSettingsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReservationState.queueSettingsLoading()';
}


}




/// @nodoc


class QueueSettingsSuccess implements ReservationState {
  const QueueSettingsSuccess(this.settingsResponse);
  

 final  QueueSettingsResponse settingsResponse;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueSettingsSuccessCopyWith<QueueSettingsSuccess> get copyWith => _$QueueSettingsSuccessCopyWithImpl<QueueSettingsSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueSettingsSuccess&&(identical(other.settingsResponse, settingsResponse) || other.settingsResponse == settingsResponse));
}


@override
int get hashCode => Object.hash(runtimeType,settingsResponse);

@override
String toString() {
  return 'ReservationState.queueSettingsSuccess(settingsResponse: $settingsResponse)';
}


}

/// @nodoc
abstract mixin class $QueueSettingsSuccessCopyWith<$Res> implements $ReservationStateCopyWith<$Res> {
  factory $QueueSettingsSuccessCopyWith(QueueSettingsSuccess value, $Res Function(QueueSettingsSuccess) _then) = _$QueueSettingsSuccessCopyWithImpl;
@useResult
$Res call({
 QueueSettingsResponse settingsResponse
});




}
/// @nodoc
class _$QueueSettingsSuccessCopyWithImpl<$Res>
    implements $QueueSettingsSuccessCopyWith<$Res> {
  _$QueueSettingsSuccessCopyWithImpl(this._self, this._then);

  final QueueSettingsSuccess _self;
  final $Res Function(QueueSettingsSuccess) _then;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? settingsResponse = null,}) {
  return _then(QueueSettingsSuccess(
null == settingsResponse ? _self.settingsResponse : settingsResponse // ignore: cast_nullable_to_non_nullable
as QueueSettingsResponse,
  ));
}


}

/// @nodoc


class QueueSettingsError implements ReservationState {
  const QueueSettingsError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QueueSettingsErrorCopyWith<QueueSettingsError> get copyWith => _$QueueSettingsErrorCopyWithImpl<QueueSettingsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QueueSettingsError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'ReservationState.queueSettingsError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $QueueSettingsErrorCopyWith<$Res> implements $ReservationStateCopyWith<$Res> {
  factory $QueueSettingsErrorCopyWith(QueueSettingsError value, $Res Function(QueueSettingsError) _then) = _$QueueSettingsErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$QueueSettingsErrorCopyWithImpl<$Res>
    implements $QueueSettingsErrorCopyWith<$Res> {
  _$QueueSettingsErrorCopyWithImpl(this._self, this._then);

  final QueueSettingsError _self;
  final $Res Function(QueueSettingsError) _then;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(QueueSettingsError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

/// @nodoc


class OtpRequestLoading implements ReservationState {
  const OtpRequestLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpRequestLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReservationState.otpRequestLoading()';
}


}




/// @nodoc


class OtpRequestSuccess implements ReservationState {
  const OtpRequestSuccess(this.otpResponse);
  

 final  OtpResponse otpResponse;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpRequestSuccessCopyWith<OtpRequestSuccess> get copyWith => _$OtpRequestSuccessCopyWithImpl<OtpRequestSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpRequestSuccess&&(identical(other.otpResponse, otpResponse) || other.otpResponse == otpResponse));
}


@override
int get hashCode => Object.hash(runtimeType,otpResponse);

@override
String toString() {
  return 'ReservationState.otpRequestSuccess(otpResponse: $otpResponse)';
}


}

/// @nodoc
abstract mixin class $OtpRequestSuccessCopyWith<$Res> implements $ReservationStateCopyWith<$Res> {
  factory $OtpRequestSuccessCopyWith(OtpRequestSuccess value, $Res Function(OtpRequestSuccess) _then) = _$OtpRequestSuccessCopyWithImpl;
@useResult
$Res call({
 OtpResponse otpResponse
});




}
/// @nodoc
class _$OtpRequestSuccessCopyWithImpl<$Res>
    implements $OtpRequestSuccessCopyWith<$Res> {
  _$OtpRequestSuccessCopyWithImpl(this._self, this._then);

  final OtpRequestSuccess _self;
  final $Res Function(OtpRequestSuccess) _then;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? otpResponse = null,}) {
  return _then(OtpRequestSuccess(
null == otpResponse ? _self.otpResponse : otpResponse // ignore: cast_nullable_to_non_nullable
as OtpResponse,
  ));
}


}

/// @nodoc


class OtpRequestError implements ReservationState {
  const OtpRequestError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpRequestErrorCopyWith<OtpRequestError> get copyWith => _$OtpRequestErrorCopyWithImpl<OtpRequestError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpRequestError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'ReservationState.otpRequestError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $OtpRequestErrorCopyWith<$Res> implements $ReservationStateCopyWith<$Res> {
  factory $OtpRequestErrorCopyWith(OtpRequestError value, $Res Function(OtpRequestError) _then) = _$OtpRequestErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$OtpRequestErrorCopyWithImpl<$Res>
    implements $OtpRequestErrorCopyWith<$Res> {
  _$OtpRequestErrorCopyWithImpl(this._self, this._then);

  final OtpRequestError _self;
  final $Res Function(OtpRequestError) _then;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(OtpRequestError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

/// @nodoc


class OtpVerificationLoading implements ReservationState {
  const OtpVerificationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpVerificationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReservationState.otpVerificationLoading()';
}


}




/// @nodoc


class OtpVerificationSuccess implements ReservationState {
  const OtpVerificationSuccess(this.reservationResponse, {this.arguments});
  

 final  ReservationResponseModel reservationResponse;
 final  ReservationArguments? arguments;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpVerificationSuccessCopyWith<OtpVerificationSuccess> get copyWith => _$OtpVerificationSuccessCopyWithImpl<OtpVerificationSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpVerificationSuccess&&(identical(other.reservationResponse, reservationResponse) || other.reservationResponse == reservationResponse)&&(identical(other.arguments, arguments) || other.arguments == arguments));
}


@override
int get hashCode => Object.hash(runtimeType,reservationResponse,arguments);

@override
String toString() {
  return 'ReservationState.otpVerificationSuccess(reservationResponse: $reservationResponse, arguments: $arguments)';
}


}

/// @nodoc
abstract mixin class $OtpVerificationSuccessCopyWith<$Res> implements $ReservationStateCopyWith<$Res> {
  factory $OtpVerificationSuccessCopyWith(OtpVerificationSuccess value, $Res Function(OtpVerificationSuccess) _then) = _$OtpVerificationSuccessCopyWithImpl;
@useResult
$Res call({
 ReservationResponseModel reservationResponse, ReservationArguments? arguments
});




}
/// @nodoc
class _$OtpVerificationSuccessCopyWithImpl<$Res>
    implements $OtpVerificationSuccessCopyWith<$Res> {
  _$OtpVerificationSuccessCopyWithImpl(this._self, this._then);

  final OtpVerificationSuccess _self;
  final $Res Function(OtpVerificationSuccess) _then;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reservationResponse = null,Object? arguments = freezed,}) {
  return _then(OtpVerificationSuccess(
null == reservationResponse ? _self.reservationResponse : reservationResponse // ignore: cast_nullable_to_non_nullable
as ReservationResponseModel,arguments: freezed == arguments ? _self.arguments : arguments // ignore: cast_nullable_to_non_nullable
as ReservationArguments?,
  ));
}


}

/// @nodoc


class OtpVerificationError implements ReservationState {
  const OtpVerificationError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpVerificationErrorCopyWith<OtpVerificationError> get copyWith => _$OtpVerificationErrorCopyWithImpl<OtpVerificationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpVerificationError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'ReservationState.otpVerificationError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $OtpVerificationErrorCopyWith<$Res> implements $ReservationStateCopyWith<$Res> {
  factory $OtpVerificationErrorCopyWith(OtpVerificationError value, $Res Function(OtpVerificationError) _then) = _$OtpVerificationErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$OtpVerificationErrorCopyWithImpl<$Res>
    implements $OtpVerificationErrorCopyWith<$Res> {
  _$OtpVerificationErrorCopyWithImpl(this._self, this._then);

  final OtpVerificationError _self;
  final $Res Function(OtpVerificationError) _then;

/// Create a copy of ReservationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(OtpVerificationError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

// dart format on
