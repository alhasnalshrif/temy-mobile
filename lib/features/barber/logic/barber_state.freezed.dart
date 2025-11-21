// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'barber_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BarberState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarberState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BarberState()';
}


}

/// @nodoc
class $BarberStateCopyWith<$Res>  {
$BarberStateCopyWith(BarberState _, $Res Function(BarberState) __);
}


/// Adds pattern-matching-related methods to [BarberState].
extension BarberStatePatterns on BarberState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( BarberLoading value)?  barberLoading,TResult Function( BarberSuccess value)?  barberSuccess,TResult Function( BarberError value)?  barberError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case BarberLoading() when barberLoading != null:
return barberLoading(_that);case BarberSuccess() when barberSuccess != null:
return barberSuccess(_that);case BarberError() when barberError != null:
return barberError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( BarberLoading value)  barberLoading,required TResult Function( BarberSuccess value)  barberSuccess,required TResult Function( BarberError value)  barberError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case BarberLoading():
return barberLoading(_that);case BarberSuccess():
return barberSuccess(_that);case BarberError():
return barberError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( BarberLoading value)?  barberLoading,TResult? Function( BarberSuccess value)?  barberSuccess,TResult? Function( BarberError value)?  barberError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case BarberLoading() when barberLoading != null:
return barberLoading(_that);case BarberSuccess() when barberSuccess != null:
return barberSuccess(_that);case BarberError() when barberError != null:
return barberError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  barberLoading,TResult Function( BarberDetailResponseModel barberDetailResponseModel)?  barberSuccess,TResult Function( ErrorHandler errorHandler)?  barberError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case BarberLoading() when barberLoading != null:
return barberLoading();case BarberSuccess() when barberSuccess != null:
return barberSuccess(_that.barberDetailResponseModel);case BarberError() when barberError != null:
return barberError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  barberLoading,required TResult Function( BarberDetailResponseModel barberDetailResponseModel)  barberSuccess,required TResult Function( ErrorHandler errorHandler)  barberError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case BarberLoading():
return barberLoading();case BarberSuccess():
return barberSuccess(_that.barberDetailResponseModel);case BarberError():
return barberError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  barberLoading,TResult? Function( BarberDetailResponseModel barberDetailResponseModel)?  barberSuccess,TResult? Function( ErrorHandler errorHandler)?  barberError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case BarberLoading() when barberLoading != null:
return barberLoading();case BarberSuccess() when barberSuccess != null:
return barberSuccess(_that.barberDetailResponseModel);case BarberError() when barberError != null:
return barberError(_that.errorHandler);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements BarberState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BarberState.initial()';
}


}




/// @nodoc


class BarberLoading implements BarberState {
  const BarberLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarberLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BarberState.barberLoading()';
}


}




/// @nodoc


class BarberSuccess implements BarberState {
  const BarberSuccess(this.barberDetailResponseModel);
  

 final  BarberDetailResponseModel barberDetailResponseModel;

/// Create a copy of BarberState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarberSuccessCopyWith<BarberSuccess> get copyWith => _$BarberSuccessCopyWithImpl<BarberSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarberSuccess&&(identical(other.barberDetailResponseModel, barberDetailResponseModel) || other.barberDetailResponseModel == barberDetailResponseModel));
}


@override
int get hashCode => Object.hash(runtimeType,barberDetailResponseModel);

@override
String toString() {
  return 'BarberState.barberSuccess(barberDetailResponseModel: $barberDetailResponseModel)';
}


}

/// @nodoc
abstract mixin class $BarberSuccessCopyWith<$Res> implements $BarberStateCopyWith<$Res> {
  factory $BarberSuccessCopyWith(BarberSuccess value, $Res Function(BarberSuccess) _then) = _$BarberSuccessCopyWithImpl;
@useResult
$Res call({
 BarberDetailResponseModel barberDetailResponseModel
});




}
/// @nodoc
class _$BarberSuccessCopyWithImpl<$Res>
    implements $BarberSuccessCopyWith<$Res> {
  _$BarberSuccessCopyWithImpl(this._self, this._then);

  final BarberSuccess _self;
  final $Res Function(BarberSuccess) _then;

/// Create a copy of BarberState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? barberDetailResponseModel = null,}) {
  return _then(BarberSuccess(
null == barberDetailResponseModel ? _self.barberDetailResponseModel : barberDetailResponseModel // ignore: cast_nullable_to_non_nullable
as BarberDetailResponseModel,
  ));
}


}

/// @nodoc


class BarberError implements BarberState {
  const BarberError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of BarberState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarberErrorCopyWith<BarberError> get copyWith => _$BarberErrorCopyWithImpl<BarberError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarberError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'BarberState.barberError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $BarberErrorCopyWith<$Res> implements $BarberStateCopyWith<$Res> {
  factory $BarberErrorCopyWith(BarberError value, $Res Function(BarberError) _then) = _$BarberErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$BarberErrorCopyWithImpl<$Res>
    implements $BarberErrorCopyWith<$Res> {
  _$BarberErrorCopyWithImpl(this._self, this._then);

  final BarberError _self;
  final $Res Function(BarberError) _then;

/// Create a copy of BarberState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(BarberError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

// dart format on
