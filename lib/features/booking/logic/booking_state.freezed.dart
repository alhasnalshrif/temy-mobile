// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$BookingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() bookingLoading,
    required TResult Function(
            List<BookingData> activeBookings, List<BookingData> historyBookings)
        bookingSuccess,
    required TResult Function(ErrorHandler errorHandler) bookingError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? bookingLoading,
    TResult? Function(List<BookingData> activeBookings,
            List<BookingData> historyBookings)?
        bookingSuccess,
    TResult? Function(ErrorHandler errorHandler)? bookingError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? bookingLoading,
    TResult Function(List<BookingData> activeBookings,
            List<BookingData> historyBookings)?
        bookingSuccess,
    TResult Function(ErrorHandler errorHandler)? bookingError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(BookingLoading value) bookingLoading,
    required TResult Function(BookingSuccess value) bookingSuccess,
    required TResult Function(BookingError value) bookingError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(BookingLoading value)? bookingLoading,
    TResult? Function(BookingSuccess value)? bookingSuccess,
    TResult? Function(BookingError value)? bookingError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(BookingLoading value)? bookingLoading,
    TResult Function(BookingSuccess value)? bookingSuccess,
    TResult Function(BookingError value)? bookingError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BookingStateCopyWith<$Res> {
  factory $BookingStateCopyWith(
          BookingState value, $Res Function(BookingState) then) =
      _$BookingStateCopyWithImpl<$Res, BookingState>;
}

/// @nodoc
class _$BookingStateCopyWithImpl<$Res, $Val extends BookingState>
    implements $BookingStateCopyWith<$Res> {
  _$BookingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'BookingState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() bookingLoading,
    required TResult Function(
            List<BookingData> activeBookings, List<BookingData> historyBookings)
        bookingSuccess,
    required TResult Function(ErrorHandler errorHandler) bookingError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? bookingLoading,
    TResult? Function(List<BookingData> activeBookings,
            List<BookingData> historyBookings)?
        bookingSuccess,
    TResult? Function(ErrorHandler errorHandler)? bookingError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? bookingLoading,
    TResult Function(List<BookingData> activeBookings,
            List<BookingData> historyBookings)?
        bookingSuccess,
    TResult Function(ErrorHandler errorHandler)? bookingError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(BookingLoading value) bookingLoading,
    required TResult Function(BookingSuccess value) bookingSuccess,
    required TResult Function(BookingError value) bookingError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(BookingLoading value)? bookingLoading,
    TResult? Function(BookingSuccess value)? bookingSuccess,
    TResult? Function(BookingError value)? bookingError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(BookingLoading value)? bookingLoading,
    TResult Function(BookingSuccess value)? bookingSuccess,
    TResult Function(BookingError value)? bookingError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements BookingState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$BookingLoadingImplCopyWith<$Res> {
  factory _$$BookingLoadingImplCopyWith(_$BookingLoadingImpl value,
          $Res Function(_$BookingLoadingImpl) then) =
      __$$BookingLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BookingLoadingImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingLoadingImpl>
    implements _$$BookingLoadingImplCopyWith<$Res> {
  __$$BookingLoadingImplCopyWithImpl(
      _$BookingLoadingImpl _value, $Res Function(_$BookingLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$BookingLoadingImpl implements BookingLoading {
  const _$BookingLoadingImpl();

  @override
  String toString() {
    return 'BookingState.bookingLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BookingLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() bookingLoading,
    required TResult Function(
            List<BookingData> activeBookings, List<BookingData> historyBookings)
        bookingSuccess,
    required TResult Function(ErrorHandler errorHandler) bookingError,
  }) {
    return bookingLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? bookingLoading,
    TResult? Function(List<BookingData> activeBookings,
            List<BookingData> historyBookings)?
        bookingSuccess,
    TResult? Function(ErrorHandler errorHandler)? bookingError,
  }) {
    return bookingLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? bookingLoading,
    TResult Function(List<BookingData> activeBookings,
            List<BookingData> historyBookings)?
        bookingSuccess,
    TResult Function(ErrorHandler errorHandler)? bookingError,
    required TResult orElse(),
  }) {
    if (bookingLoading != null) {
      return bookingLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(BookingLoading value) bookingLoading,
    required TResult Function(BookingSuccess value) bookingSuccess,
    required TResult Function(BookingError value) bookingError,
  }) {
    return bookingLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(BookingLoading value)? bookingLoading,
    TResult? Function(BookingSuccess value)? bookingSuccess,
    TResult? Function(BookingError value)? bookingError,
  }) {
    return bookingLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(BookingLoading value)? bookingLoading,
    TResult Function(BookingSuccess value)? bookingSuccess,
    TResult Function(BookingError value)? bookingError,
    required TResult orElse(),
  }) {
    if (bookingLoading != null) {
      return bookingLoading(this);
    }
    return orElse();
  }
}

abstract class BookingLoading implements BookingState {
  const factory BookingLoading() = _$BookingLoadingImpl;
}

/// @nodoc
abstract class _$$BookingSuccessImplCopyWith<$Res> {
  factory _$$BookingSuccessImplCopyWith(_$BookingSuccessImpl value,
          $Res Function(_$BookingSuccessImpl) then) =
      __$$BookingSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<BookingData> activeBookings, List<BookingData> historyBookings});
}

/// @nodoc
class __$$BookingSuccessImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingSuccessImpl>
    implements _$$BookingSuccessImplCopyWith<$Res> {
  __$$BookingSuccessImplCopyWithImpl(
      _$BookingSuccessImpl _value, $Res Function(_$BookingSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? activeBookings = null,
    Object? historyBookings = null,
  }) {
    return _then(_$BookingSuccessImpl(
      activeBookings: null == activeBookings
          ? _value._activeBookings
          : activeBookings // ignore: cast_nullable_to_non_nullable
              as List<BookingData>,
      historyBookings: null == historyBookings
          ? _value._historyBookings
          : historyBookings // ignore: cast_nullable_to_non_nullable
              as List<BookingData>,
    ));
  }
}

/// @nodoc

class _$BookingSuccessImpl implements BookingSuccess {
  const _$BookingSuccessImpl(
      {required final List<BookingData> activeBookings,
      required final List<BookingData> historyBookings})
      : _activeBookings = activeBookings,
        _historyBookings = historyBookings;

  final List<BookingData> _activeBookings;
  @override
  List<BookingData> get activeBookings {
    if (_activeBookings is EqualUnmodifiableListView) return _activeBookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeBookings);
  }

  final List<BookingData> _historyBookings;
  @override
  List<BookingData> get historyBookings {
    if (_historyBookings is EqualUnmodifiableListView) return _historyBookings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historyBookings);
  }

  @override
  String toString() {
    return 'BookingState.bookingSuccess(activeBookings: $activeBookings, historyBookings: $historyBookings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingSuccessImpl &&
            const DeepCollectionEquality()
                .equals(other._activeBookings, _activeBookings) &&
            const DeepCollectionEquality()
                .equals(other._historyBookings, _historyBookings));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_activeBookings),
      const DeepCollectionEquality().hash(_historyBookings));

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingSuccessImplCopyWith<_$BookingSuccessImpl> get copyWith =>
      __$$BookingSuccessImplCopyWithImpl<_$BookingSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() bookingLoading,
    required TResult Function(
            List<BookingData> activeBookings, List<BookingData> historyBookings)
        bookingSuccess,
    required TResult Function(ErrorHandler errorHandler) bookingError,
  }) {
    return bookingSuccess(activeBookings, historyBookings);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? bookingLoading,
    TResult? Function(List<BookingData> activeBookings,
            List<BookingData> historyBookings)?
        bookingSuccess,
    TResult? Function(ErrorHandler errorHandler)? bookingError,
  }) {
    return bookingSuccess?.call(activeBookings, historyBookings);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? bookingLoading,
    TResult Function(List<BookingData> activeBookings,
            List<BookingData> historyBookings)?
        bookingSuccess,
    TResult Function(ErrorHandler errorHandler)? bookingError,
    required TResult orElse(),
  }) {
    if (bookingSuccess != null) {
      return bookingSuccess(activeBookings, historyBookings);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(BookingLoading value) bookingLoading,
    required TResult Function(BookingSuccess value) bookingSuccess,
    required TResult Function(BookingError value) bookingError,
  }) {
    return bookingSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(BookingLoading value)? bookingLoading,
    TResult? Function(BookingSuccess value)? bookingSuccess,
    TResult? Function(BookingError value)? bookingError,
  }) {
    return bookingSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(BookingLoading value)? bookingLoading,
    TResult Function(BookingSuccess value)? bookingSuccess,
    TResult Function(BookingError value)? bookingError,
    required TResult orElse(),
  }) {
    if (bookingSuccess != null) {
      return bookingSuccess(this);
    }
    return orElse();
  }
}

abstract class BookingSuccess implements BookingState {
  const factory BookingSuccess(
      {required final List<BookingData> activeBookings,
      required final List<BookingData> historyBookings}) = _$BookingSuccessImpl;

  List<BookingData> get activeBookings;
  List<BookingData> get historyBookings;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingSuccessImplCopyWith<_$BookingSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$BookingErrorImplCopyWith<$Res> {
  factory _$$BookingErrorImplCopyWith(
          _$BookingErrorImpl value, $Res Function(_$BookingErrorImpl) then) =
      __$$BookingErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ErrorHandler errorHandler});
}

/// @nodoc
class __$$BookingErrorImplCopyWithImpl<$Res>
    extends _$BookingStateCopyWithImpl<$Res, _$BookingErrorImpl>
    implements _$$BookingErrorImplCopyWith<$Res> {
  __$$BookingErrorImplCopyWithImpl(
      _$BookingErrorImpl _value, $Res Function(_$BookingErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorHandler = null,
  }) {
    return _then(_$BookingErrorImpl(
      null == errorHandler
          ? _value.errorHandler
          : errorHandler // ignore: cast_nullable_to_non_nullable
              as ErrorHandler,
    ));
  }
}

/// @nodoc

class _$BookingErrorImpl implements BookingError {
  const _$BookingErrorImpl(this.errorHandler);

  @override
  final ErrorHandler errorHandler;

  @override
  String toString() {
    return 'BookingState.bookingError(errorHandler: $errorHandler)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BookingErrorImpl &&
            (identical(other.errorHandler, errorHandler) ||
                other.errorHandler == errorHandler));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorHandler);

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BookingErrorImplCopyWith<_$BookingErrorImpl> get copyWith =>
      __$$BookingErrorImplCopyWithImpl<_$BookingErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() bookingLoading,
    required TResult Function(
            List<BookingData> activeBookings, List<BookingData> historyBookings)
        bookingSuccess,
    required TResult Function(ErrorHandler errorHandler) bookingError,
  }) {
    return bookingError(errorHandler);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? bookingLoading,
    TResult? Function(List<BookingData> activeBookings,
            List<BookingData> historyBookings)?
        bookingSuccess,
    TResult? Function(ErrorHandler errorHandler)? bookingError,
  }) {
    return bookingError?.call(errorHandler);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? bookingLoading,
    TResult Function(List<BookingData> activeBookings,
            List<BookingData> historyBookings)?
        bookingSuccess,
    TResult Function(ErrorHandler errorHandler)? bookingError,
    required TResult orElse(),
  }) {
    if (bookingError != null) {
      return bookingError(errorHandler);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(BookingLoading value) bookingLoading,
    required TResult Function(BookingSuccess value) bookingSuccess,
    required TResult Function(BookingError value) bookingError,
  }) {
    return bookingError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(BookingLoading value)? bookingLoading,
    TResult? Function(BookingSuccess value)? bookingSuccess,
    TResult? Function(BookingError value)? bookingError,
  }) {
    return bookingError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(BookingLoading value)? bookingLoading,
    TResult Function(BookingSuccess value)? bookingSuccess,
    TResult Function(BookingError value)? bookingError,
    required TResult orElse(),
  }) {
    if (bookingError != null) {
      return bookingError(this);
    }
    return orElse();
  }
}

abstract class BookingError implements BookingState {
  const factory BookingError(final ErrorHandler errorHandler) =
      _$BookingErrorImpl;

  ErrorHandler get errorHandler;

  /// Create a copy of BookingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BookingErrorImplCopyWith<_$BookingErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
