// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingState()';
}


}

/// @nodoc
class $BookingStateCopyWith<$Res>  {
$BookingStateCopyWith(BookingState _, $Res Function(BookingState) __);
}


/// Adds pattern-matching-related methods to [BookingState].
extension BookingStatePatterns on BookingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( BookingLoading value)?  bookingLoading,TResult Function( BookingSuccess value)?  bookingSuccess,TResult Function( BookingError value)?  bookingError,TResult Function( CancelBookingLoading value)?  cancelBookingLoading,TResult Function( CancelBookingSuccess value)?  cancelBookingSuccess,TResult Function( CancelBookingError value)?  cancelBookingError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case BookingLoading() when bookingLoading != null:
return bookingLoading(_that);case BookingSuccess() when bookingSuccess != null:
return bookingSuccess(_that);case BookingError() when bookingError != null:
return bookingError(_that);case CancelBookingLoading() when cancelBookingLoading != null:
return cancelBookingLoading(_that);case CancelBookingSuccess() when cancelBookingSuccess != null:
return cancelBookingSuccess(_that);case CancelBookingError() when cancelBookingError != null:
return cancelBookingError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( BookingLoading value)  bookingLoading,required TResult Function( BookingSuccess value)  bookingSuccess,required TResult Function( BookingError value)  bookingError,required TResult Function( CancelBookingLoading value)  cancelBookingLoading,required TResult Function( CancelBookingSuccess value)  cancelBookingSuccess,required TResult Function( CancelBookingError value)  cancelBookingError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case BookingLoading():
return bookingLoading(_that);case BookingSuccess():
return bookingSuccess(_that);case BookingError():
return bookingError(_that);case CancelBookingLoading():
return cancelBookingLoading(_that);case CancelBookingSuccess():
return cancelBookingSuccess(_that);case CancelBookingError():
return cancelBookingError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( BookingLoading value)?  bookingLoading,TResult? Function( BookingSuccess value)?  bookingSuccess,TResult? Function( BookingError value)?  bookingError,TResult? Function( CancelBookingLoading value)?  cancelBookingLoading,TResult? Function( CancelBookingSuccess value)?  cancelBookingSuccess,TResult? Function( CancelBookingError value)?  cancelBookingError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case BookingLoading() when bookingLoading != null:
return bookingLoading(_that);case BookingSuccess() when bookingSuccess != null:
return bookingSuccess(_that);case BookingError() when bookingError != null:
return bookingError(_that);case CancelBookingLoading() when cancelBookingLoading != null:
return cancelBookingLoading(_that);case CancelBookingSuccess() when cancelBookingSuccess != null:
return cancelBookingSuccess(_that);case CancelBookingError() when cancelBookingError != null:
return cancelBookingError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  bookingLoading,TResult Function( List<BookingData> activeBookings,  List<BookingData> historyBookings)?  bookingSuccess,TResult Function( ErrorHandler errorHandler)?  bookingError,TResult Function()?  cancelBookingLoading,TResult Function()?  cancelBookingSuccess,TResult Function( ErrorHandler errorHandler)?  cancelBookingError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case BookingLoading() when bookingLoading != null:
return bookingLoading();case BookingSuccess() when bookingSuccess != null:
return bookingSuccess(_that.activeBookings,_that.historyBookings);case BookingError() when bookingError != null:
return bookingError(_that.errorHandler);case CancelBookingLoading() when cancelBookingLoading != null:
return cancelBookingLoading();case CancelBookingSuccess() when cancelBookingSuccess != null:
return cancelBookingSuccess();case CancelBookingError() when cancelBookingError != null:
return cancelBookingError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  bookingLoading,required TResult Function( List<BookingData> activeBookings,  List<BookingData> historyBookings)  bookingSuccess,required TResult Function( ErrorHandler errorHandler)  bookingError,required TResult Function()  cancelBookingLoading,required TResult Function()  cancelBookingSuccess,required TResult Function( ErrorHandler errorHandler)  cancelBookingError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case BookingLoading():
return bookingLoading();case BookingSuccess():
return bookingSuccess(_that.activeBookings,_that.historyBookings);case BookingError():
return bookingError(_that.errorHandler);case CancelBookingLoading():
return cancelBookingLoading();case CancelBookingSuccess():
return cancelBookingSuccess();case CancelBookingError():
return cancelBookingError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  bookingLoading,TResult? Function( List<BookingData> activeBookings,  List<BookingData> historyBookings)?  bookingSuccess,TResult? Function( ErrorHandler errorHandler)?  bookingError,TResult? Function()?  cancelBookingLoading,TResult? Function()?  cancelBookingSuccess,TResult? Function( ErrorHandler errorHandler)?  cancelBookingError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case BookingLoading() when bookingLoading != null:
return bookingLoading();case BookingSuccess() when bookingSuccess != null:
return bookingSuccess(_that.activeBookings,_that.historyBookings);case BookingError() when bookingError != null:
return bookingError(_that.errorHandler);case CancelBookingLoading() when cancelBookingLoading != null:
return cancelBookingLoading();case CancelBookingSuccess() when cancelBookingSuccess != null:
return cancelBookingSuccess();case CancelBookingError() when cancelBookingError != null:
return cancelBookingError(_that.errorHandler);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements BookingState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingState.initial()';
}


}




/// @nodoc


class BookingLoading implements BookingState {
  const BookingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingState.bookingLoading()';
}


}




/// @nodoc


class BookingSuccess implements BookingState {
  const BookingSuccess({required final  List<BookingData> activeBookings, required final  List<BookingData> historyBookings}): _activeBookings = activeBookings,_historyBookings = historyBookings;
  

 final  List<BookingData> _activeBookings;
 List<BookingData> get activeBookings {
  if (_activeBookings is EqualUnmodifiableListView) return _activeBookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_activeBookings);
}

 final  List<BookingData> _historyBookings;
 List<BookingData> get historyBookings {
  if (_historyBookings is EqualUnmodifiableListView) return _historyBookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_historyBookings);
}


/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingSuccessCopyWith<BookingSuccess> get copyWith => _$BookingSuccessCopyWithImpl<BookingSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingSuccess&&const DeepCollectionEquality().equals(other._activeBookings, _activeBookings)&&const DeepCollectionEquality().equals(other._historyBookings, _historyBookings));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_activeBookings),const DeepCollectionEquality().hash(_historyBookings));

@override
String toString() {
  return 'BookingState.bookingSuccess(activeBookings: $activeBookings, historyBookings: $historyBookings)';
}


}

/// @nodoc
abstract mixin class $BookingSuccessCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingSuccessCopyWith(BookingSuccess value, $Res Function(BookingSuccess) _then) = _$BookingSuccessCopyWithImpl;
@useResult
$Res call({
 List<BookingData> activeBookings, List<BookingData> historyBookings
});




}
/// @nodoc
class _$BookingSuccessCopyWithImpl<$Res>
    implements $BookingSuccessCopyWith<$Res> {
  _$BookingSuccessCopyWithImpl(this._self, this._then);

  final BookingSuccess _self;
  final $Res Function(BookingSuccess) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? activeBookings = null,Object? historyBookings = null,}) {
  return _then(BookingSuccess(
activeBookings: null == activeBookings ? _self._activeBookings : activeBookings // ignore: cast_nullable_to_non_nullable
as List<BookingData>,historyBookings: null == historyBookings ? _self._historyBookings : historyBookings // ignore: cast_nullable_to_non_nullable
as List<BookingData>,
  ));
}


}

/// @nodoc


class BookingError implements BookingState {
  const BookingError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingErrorCopyWith<BookingError> get copyWith => _$BookingErrorCopyWithImpl<BookingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'BookingState.bookingError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $BookingErrorCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingErrorCopyWith(BookingError value, $Res Function(BookingError) _then) = _$BookingErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$BookingErrorCopyWithImpl<$Res>
    implements $BookingErrorCopyWith<$Res> {
  _$BookingErrorCopyWithImpl(this._self, this._then);

  final BookingError _self;
  final $Res Function(BookingError) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(BookingError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

/// @nodoc


class CancelBookingLoading implements BookingState {
  const CancelBookingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelBookingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingState.cancelBookingLoading()';
}


}




/// @nodoc


class CancelBookingSuccess implements BookingState {
  const CancelBookingSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelBookingSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingState.cancelBookingSuccess()';
}


}




/// @nodoc


class CancelBookingError implements BookingState {
  const CancelBookingError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CancelBookingErrorCopyWith<CancelBookingError> get copyWith => _$CancelBookingErrorCopyWithImpl<CancelBookingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CancelBookingError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'BookingState.cancelBookingError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $CancelBookingErrorCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $CancelBookingErrorCopyWith(CancelBookingError value, $Res Function(CancelBookingError) _then) = _$CancelBookingErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$CancelBookingErrorCopyWithImpl<$Res>
    implements $CancelBookingErrorCopyWith<$Res> {
  _$CancelBookingErrorCopyWithImpl(this._self, this._then);

  final CancelBookingError _self;
  final $Res Function(CancelBookingError) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(CancelBookingError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

// dart format on
