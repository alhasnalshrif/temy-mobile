// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$QueueState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueStateCopyWith<$Res> {
  factory $QueueStateCopyWith(
          QueueState value, $Res Function(QueueState) then) =
      _$QueueStateCopyWithImpl<$Res, QueueState>;
}

/// @nodoc
class _$QueueStateCopyWithImpl<$Res, $Val extends QueueState>
    implements $QueueStateCopyWith<$Res> {
  _$QueueStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueState
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
    extends _$QueueStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'QueueState.initial()';
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
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
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
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements QueueState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$JoinQueueLoadingImplCopyWith<$Res> {
  factory _$$JoinQueueLoadingImplCopyWith(_$JoinQueueLoadingImpl value,
          $Res Function(_$JoinQueueLoadingImpl) then) =
      __$$JoinQueueLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$JoinQueueLoadingImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$JoinQueueLoadingImpl>
    implements _$$JoinQueueLoadingImplCopyWith<$Res> {
  __$$JoinQueueLoadingImplCopyWithImpl(_$JoinQueueLoadingImpl _value,
      $Res Function(_$JoinQueueLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$JoinQueueLoadingImpl implements JoinQueueLoading {
  const _$JoinQueueLoadingImpl();

  @override
  String toString() {
    return 'QueueState.joinQueueLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$JoinQueueLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return joinQueueLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return joinQueueLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (joinQueueLoading != null) {
      return joinQueueLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return joinQueueLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return joinQueueLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (joinQueueLoading != null) {
      return joinQueueLoading(this);
    }
    return orElse();
  }
}

abstract class JoinQueueLoading implements QueueState {
  const factory JoinQueueLoading() = _$JoinQueueLoadingImpl;
}

/// @nodoc
abstract class _$$JoinQueueSuccessImplCopyWith<$Res> {
  factory _$$JoinQueueSuccessImplCopyWith(_$JoinQueueSuccessImpl value,
          $Res Function(_$JoinQueueSuccessImpl) then) =
      __$$JoinQueueSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({QueuePositionData data});
}

/// @nodoc
class __$$JoinQueueSuccessImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$JoinQueueSuccessImpl>
    implements _$$JoinQueueSuccessImplCopyWith<$Res> {
  __$$JoinQueueSuccessImplCopyWithImpl(_$JoinQueueSuccessImpl _value,
      $Res Function(_$JoinQueueSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$JoinQueueSuccessImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as QueuePositionData,
    ));
  }
}

/// @nodoc

class _$JoinQueueSuccessImpl implements JoinQueueSuccess {
  const _$JoinQueueSuccessImpl(this.data);

  @override
  final QueuePositionData data;

  @override
  String toString() {
    return 'QueueState.joinQueueSuccess(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinQueueSuccessImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinQueueSuccessImplCopyWith<_$JoinQueueSuccessImpl> get copyWith =>
      __$$JoinQueueSuccessImplCopyWithImpl<_$JoinQueueSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return joinQueueSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return joinQueueSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (joinQueueSuccess != null) {
      return joinQueueSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return joinQueueSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return joinQueueSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (joinQueueSuccess != null) {
      return joinQueueSuccess(this);
    }
    return orElse();
  }
}

abstract class JoinQueueSuccess implements QueueState {
  const factory JoinQueueSuccess(final QueuePositionData data) =
      _$JoinQueueSuccessImpl;

  QueuePositionData get data;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JoinQueueSuccessImplCopyWith<_$JoinQueueSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$JoinQueueErrorImplCopyWith<$Res> {
  factory _$$JoinQueueErrorImplCopyWith(_$JoinQueueErrorImpl value,
          $Res Function(_$JoinQueueErrorImpl) then) =
      __$$JoinQueueErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$JoinQueueErrorImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$JoinQueueErrorImpl>
    implements _$$JoinQueueErrorImplCopyWith<$Res> {
  __$$JoinQueueErrorImplCopyWithImpl(
      _$JoinQueueErrorImpl _value, $Res Function(_$JoinQueueErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$JoinQueueErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$JoinQueueErrorImpl implements JoinQueueError {
  const _$JoinQueueErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'QueueState.joinQueueError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JoinQueueErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$JoinQueueErrorImplCopyWith<_$JoinQueueErrorImpl> get copyWith =>
      __$$JoinQueueErrorImplCopyWithImpl<_$JoinQueueErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return joinQueueError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return joinQueueError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (joinQueueError != null) {
      return joinQueueError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return joinQueueError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return joinQueueError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (joinQueueError != null) {
      return joinQueueError(this);
    }
    return orElse();
  }
}

abstract class JoinQueueError implements QueueState {
  const factory JoinQueueError(final String error) = _$JoinQueueErrorImpl;

  String get error;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$JoinQueueErrorImplCopyWith<_$JoinQueueErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueueStatusLoadingImplCopyWith<$Res> {
  factory _$$QueueStatusLoadingImplCopyWith(_$QueueStatusLoadingImpl value,
          $Res Function(_$QueueStatusLoadingImpl) then) =
      __$$QueueStatusLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QueueStatusLoadingImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$QueueStatusLoadingImpl>
    implements _$$QueueStatusLoadingImplCopyWith<$Res> {
  __$$QueueStatusLoadingImplCopyWithImpl(_$QueueStatusLoadingImpl _value,
      $Res Function(_$QueueStatusLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$QueueStatusLoadingImpl implements QueueStatusLoading {
  const _$QueueStatusLoadingImpl();

  @override
  String toString() {
    return 'QueueState.queueStatusLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QueueStatusLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return queueStatusLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return queueStatusLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueStatusLoading != null) {
      return queueStatusLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return queueStatusLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return queueStatusLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueStatusLoading != null) {
      return queueStatusLoading(this);
    }
    return orElse();
  }
}

abstract class QueueStatusLoading implements QueueState {
  const factory QueueStatusLoading() = _$QueueStatusLoadingImpl;
}

/// @nodoc
abstract class _$$QueueStatusSuccessImplCopyWith<$Res> {
  factory _$$QueueStatusSuccessImplCopyWith(_$QueueStatusSuccessImpl value,
          $Res Function(_$QueueStatusSuccessImpl) then) =
      __$$QueueStatusSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({QueueStatusData data});
}

/// @nodoc
class __$$QueueStatusSuccessImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$QueueStatusSuccessImpl>
    implements _$$QueueStatusSuccessImplCopyWith<$Res> {
  __$$QueueStatusSuccessImplCopyWithImpl(_$QueueStatusSuccessImpl _value,
      $Res Function(_$QueueStatusSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$QueueStatusSuccessImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as QueueStatusData,
    ));
  }
}

/// @nodoc

class _$QueueStatusSuccessImpl implements QueueStatusSuccess {
  const _$QueueStatusSuccessImpl(this.data);

  @override
  final QueueStatusData data;

  @override
  String toString() {
    return 'QueueState.queueStatusSuccess(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueStatusSuccessImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueStatusSuccessImplCopyWith<_$QueueStatusSuccessImpl> get copyWith =>
      __$$QueueStatusSuccessImplCopyWithImpl<_$QueueStatusSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return queueStatusSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return queueStatusSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueStatusSuccess != null) {
      return queueStatusSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return queueStatusSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return queueStatusSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueStatusSuccess != null) {
      return queueStatusSuccess(this);
    }
    return orElse();
  }
}

abstract class QueueStatusSuccess implements QueueState {
  const factory QueueStatusSuccess(final QueueStatusData data) =
      _$QueueStatusSuccessImpl;

  QueueStatusData get data;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueStatusSuccessImplCopyWith<_$QueueStatusSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueueStatusErrorImplCopyWith<$Res> {
  factory _$$QueueStatusErrorImplCopyWith(_$QueueStatusErrorImpl value,
          $Res Function(_$QueueStatusErrorImpl) then) =
      __$$QueueStatusErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$QueueStatusErrorImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$QueueStatusErrorImpl>
    implements _$$QueueStatusErrorImplCopyWith<$Res> {
  __$$QueueStatusErrorImplCopyWithImpl(_$QueueStatusErrorImpl _value,
      $Res Function(_$QueueStatusErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$QueueStatusErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$QueueStatusErrorImpl implements QueueStatusError {
  const _$QueueStatusErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'QueueState.queueStatusError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueStatusErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueStatusErrorImplCopyWith<_$QueueStatusErrorImpl> get copyWith =>
      __$$QueueStatusErrorImplCopyWithImpl<_$QueueStatusErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return queueStatusError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return queueStatusError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueStatusError != null) {
      return queueStatusError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return queueStatusError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return queueStatusError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueStatusError != null) {
      return queueStatusError(this);
    }
    return orElse();
  }
}

abstract class QueueStatusError implements QueueState {
  const factory QueueStatusError(final String error) = _$QueueStatusErrorImpl;

  String get error;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueStatusErrorImplCopyWith<_$QueueStatusErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueuePositionLoadingImplCopyWith<$Res> {
  factory _$$QueuePositionLoadingImplCopyWith(_$QueuePositionLoadingImpl value,
          $Res Function(_$QueuePositionLoadingImpl) then) =
      __$$QueuePositionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QueuePositionLoadingImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$QueuePositionLoadingImpl>
    implements _$$QueuePositionLoadingImplCopyWith<$Res> {
  __$$QueuePositionLoadingImplCopyWithImpl(_$QueuePositionLoadingImpl _value,
      $Res Function(_$QueuePositionLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$QueuePositionLoadingImpl implements QueuePositionLoading {
  const _$QueuePositionLoadingImpl();

  @override
  String toString() {
    return 'QueueState.queuePositionLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueuePositionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return queuePositionLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return queuePositionLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (queuePositionLoading != null) {
      return queuePositionLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return queuePositionLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return queuePositionLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (queuePositionLoading != null) {
      return queuePositionLoading(this);
    }
    return orElse();
  }
}

abstract class QueuePositionLoading implements QueueState {
  const factory QueuePositionLoading() = _$QueuePositionLoadingImpl;
}

/// @nodoc
abstract class _$$QueuePositionSuccessImplCopyWith<$Res> {
  factory _$$QueuePositionSuccessImplCopyWith(_$QueuePositionSuccessImpl value,
          $Res Function(_$QueuePositionSuccessImpl) then) =
      __$$QueuePositionSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({QueuePositionData data});
}

/// @nodoc
class __$$QueuePositionSuccessImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$QueuePositionSuccessImpl>
    implements _$$QueuePositionSuccessImplCopyWith<$Res> {
  __$$QueuePositionSuccessImplCopyWithImpl(_$QueuePositionSuccessImpl _value,
      $Res Function(_$QueuePositionSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$QueuePositionSuccessImpl(
      null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as QueuePositionData,
    ));
  }
}

/// @nodoc

class _$QueuePositionSuccessImpl implements QueuePositionSuccess {
  const _$QueuePositionSuccessImpl(this.data);

  @override
  final QueuePositionData data;

  @override
  String toString() {
    return 'QueueState.queuePositionSuccess(data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueuePositionSuccessImpl &&
            (identical(other.data, data) || other.data == data));
  }

  @override
  int get hashCode => Object.hash(runtimeType, data);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueuePositionSuccessImplCopyWith<_$QueuePositionSuccessImpl>
      get copyWith =>
          __$$QueuePositionSuccessImplCopyWithImpl<_$QueuePositionSuccessImpl>(
              this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return queuePositionSuccess(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return queuePositionSuccess?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (queuePositionSuccess != null) {
      return queuePositionSuccess(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return queuePositionSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return queuePositionSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (queuePositionSuccess != null) {
      return queuePositionSuccess(this);
    }
    return orElse();
  }
}

abstract class QueuePositionSuccess implements QueueState {
  const factory QueuePositionSuccess(final QueuePositionData data) =
      _$QueuePositionSuccessImpl;

  QueuePositionData get data;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueuePositionSuccessImplCopyWith<_$QueuePositionSuccessImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueuePositionErrorImplCopyWith<$Res> {
  factory _$$QueuePositionErrorImplCopyWith(_$QueuePositionErrorImpl value,
          $Res Function(_$QueuePositionErrorImpl) then) =
      __$$QueuePositionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$QueuePositionErrorImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$QueuePositionErrorImpl>
    implements _$$QueuePositionErrorImplCopyWith<$Res> {
  __$$QueuePositionErrorImplCopyWithImpl(_$QueuePositionErrorImpl _value,
      $Res Function(_$QueuePositionErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$QueuePositionErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$QueuePositionErrorImpl implements QueuePositionError {
  const _$QueuePositionErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'QueueState.queuePositionError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueuePositionErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueuePositionErrorImplCopyWith<_$QueuePositionErrorImpl> get copyWith =>
      __$$QueuePositionErrorImplCopyWithImpl<_$QueuePositionErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return queuePositionError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return queuePositionError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (queuePositionError != null) {
      return queuePositionError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return queuePositionError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return queuePositionError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (queuePositionError != null) {
      return queuePositionError(this);
    }
    return orElse();
  }
}

abstract class QueuePositionError implements QueueState {
  const factory QueuePositionError(final String error) =
      _$QueuePositionErrorImpl;

  String get error;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueuePositionErrorImplCopyWith<_$QueuePositionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueueActionLoadingImplCopyWith<$Res> {
  factory _$$QueueActionLoadingImplCopyWith(_$QueueActionLoadingImpl value,
          $Res Function(_$QueueActionLoadingImpl) then) =
      __$$QueueActionLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$QueueActionLoadingImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$QueueActionLoadingImpl>
    implements _$$QueueActionLoadingImplCopyWith<$Res> {
  __$$QueueActionLoadingImplCopyWithImpl(_$QueueActionLoadingImpl _value,
      $Res Function(_$QueueActionLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$QueueActionLoadingImpl implements QueueActionLoading {
  const _$QueueActionLoadingImpl();

  @override
  String toString() {
    return 'QueueState.queueActionLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$QueueActionLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return queueActionLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return queueActionLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueActionLoading != null) {
      return queueActionLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return queueActionLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return queueActionLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueActionLoading != null) {
      return queueActionLoading(this);
    }
    return orElse();
  }
}

abstract class QueueActionLoading implements QueueState {
  const factory QueueActionLoading() = _$QueueActionLoadingImpl;
}

/// @nodoc
abstract class _$$QueueActionSuccessImplCopyWith<$Res> {
  factory _$$QueueActionSuccessImplCopyWith(_$QueueActionSuccessImpl value,
          $Res Function(_$QueueActionSuccessImpl) then) =
      __$$QueueActionSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$QueueActionSuccessImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$QueueActionSuccessImpl>
    implements _$$QueueActionSuccessImplCopyWith<$Res> {
  __$$QueueActionSuccessImplCopyWithImpl(_$QueueActionSuccessImpl _value,
      $Res Function(_$QueueActionSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$QueueActionSuccessImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$QueueActionSuccessImpl implements QueueActionSuccess {
  const _$QueueActionSuccessImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'QueueState.queueActionSuccess(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueActionSuccessImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueActionSuccessImplCopyWith<_$QueueActionSuccessImpl> get copyWith =>
      __$$QueueActionSuccessImplCopyWithImpl<_$QueueActionSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return queueActionSuccess(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return queueActionSuccess?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueActionSuccess != null) {
      return queueActionSuccess(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return queueActionSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return queueActionSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueActionSuccess != null) {
      return queueActionSuccess(this);
    }
    return orElse();
  }
}

abstract class QueueActionSuccess implements QueueState {
  const factory QueueActionSuccess(final String message) =
      _$QueueActionSuccessImpl;

  String get message;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueActionSuccessImplCopyWith<_$QueueActionSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$QueueActionErrorImplCopyWith<$Res> {
  factory _$$QueueActionErrorImplCopyWith(_$QueueActionErrorImpl value,
          $Res Function(_$QueueActionErrorImpl) then) =
      __$$QueueActionErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String error});
}

/// @nodoc
class __$$QueueActionErrorImplCopyWithImpl<$Res>
    extends _$QueueStateCopyWithImpl<$Res, _$QueueActionErrorImpl>
    implements _$$QueueActionErrorImplCopyWith<$Res> {
  __$$QueueActionErrorImplCopyWithImpl(_$QueueActionErrorImpl _value,
      $Res Function(_$QueueActionErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$QueueActionErrorImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$QueueActionErrorImpl implements QueueActionError {
  const _$QueueActionErrorImpl(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'QueueState.queueActionError(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueActionErrorImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueActionErrorImplCopyWith<_$QueueActionErrorImpl> get copyWith =>
      __$$QueueActionErrorImplCopyWithImpl<_$QueueActionErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() joinQueueLoading,
    required TResult Function(QueuePositionData data) joinQueueSuccess,
    required TResult Function(String error) joinQueueError,
    required TResult Function() queueStatusLoading,
    required TResult Function(QueueStatusData data) queueStatusSuccess,
    required TResult Function(String error) queueStatusError,
    required TResult Function() queuePositionLoading,
    required TResult Function(QueuePositionData data) queuePositionSuccess,
    required TResult Function(String error) queuePositionError,
    required TResult Function() queueActionLoading,
    required TResult Function(String message) queueActionSuccess,
    required TResult Function(String error) queueActionError,
  }) {
    return queueActionError(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? joinQueueLoading,
    TResult? Function(QueuePositionData data)? joinQueueSuccess,
    TResult? Function(String error)? joinQueueError,
    TResult? Function()? queueStatusLoading,
    TResult? Function(QueueStatusData data)? queueStatusSuccess,
    TResult? Function(String error)? queueStatusError,
    TResult? Function()? queuePositionLoading,
    TResult? Function(QueuePositionData data)? queuePositionSuccess,
    TResult? Function(String error)? queuePositionError,
    TResult? Function()? queueActionLoading,
    TResult? Function(String message)? queueActionSuccess,
    TResult? Function(String error)? queueActionError,
  }) {
    return queueActionError?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? joinQueueLoading,
    TResult Function(QueuePositionData data)? joinQueueSuccess,
    TResult Function(String error)? joinQueueError,
    TResult Function()? queueStatusLoading,
    TResult Function(QueueStatusData data)? queueStatusSuccess,
    TResult Function(String error)? queueStatusError,
    TResult Function()? queuePositionLoading,
    TResult Function(QueuePositionData data)? queuePositionSuccess,
    TResult Function(String error)? queuePositionError,
    TResult Function()? queueActionLoading,
    TResult Function(String message)? queueActionSuccess,
    TResult Function(String error)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueActionError != null) {
      return queueActionError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(JoinQueueLoading value) joinQueueLoading,
    required TResult Function(JoinQueueSuccess value) joinQueueSuccess,
    required TResult Function(JoinQueueError value) joinQueueError,
    required TResult Function(QueueStatusLoading value) queueStatusLoading,
    required TResult Function(QueueStatusSuccess value) queueStatusSuccess,
    required TResult Function(QueueStatusError value) queueStatusError,
    required TResult Function(QueuePositionLoading value) queuePositionLoading,
    required TResult Function(QueuePositionSuccess value) queuePositionSuccess,
    required TResult Function(QueuePositionError value) queuePositionError,
    required TResult Function(QueueActionLoading value) queueActionLoading,
    required TResult Function(QueueActionSuccess value) queueActionSuccess,
    required TResult Function(QueueActionError value) queueActionError,
  }) {
    return queueActionError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(JoinQueueLoading value)? joinQueueLoading,
    TResult? Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult? Function(JoinQueueError value)? joinQueueError,
    TResult? Function(QueueStatusLoading value)? queueStatusLoading,
    TResult? Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult? Function(QueueStatusError value)? queueStatusError,
    TResult? Function(QueuePositionLoading value)? queuePositionLoading,
    TResult? Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult? Function(QueuePositionError value)? queuePositionError,
    TResult? Function(QueueActionLoading value)? queueActionLoading,
    TResult? Function(QueueActionSuccess value)? queueActionSuccess,
    TResult? Function(QueueActionError value)? queueActionError,
  }) {
    return queueActionError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(JoinQueueLoading value)? joinQueueLoading,
    TResult Function(JoinQueueSuccess value)? joinQueueSuccess,
    TResult Function(JoinQueueError value)? joinQueueError,
    TResult Function(QueueStatusLoading value)? queueStatusLoading,
    TResult Function(QueueStatusSuccess value)? queueStatusSuccess,
    TResult Function(QueueStatusError value)? queueStatusError,
    TResult Function(QueuePositionLoading value)? queuePositionLoading,
    TResult Function(QueuePositionSuccess value)? queuePositionSuccess,
    TResult Function(QueuePositionError value)? queuePositionError,
    TResult Function(QueueActionLoading value)? queueActionLoading,
    TResult Function(QueueActionSuccess value)? queueActionSuccess,
    TResult Function(QueueActionError value)? queueActionError,
    required TResult orElse(),
  }) {
    if (queueActionError != null) {
      return queueActionError(this);
    }
    return orElse();
  }
}

abstract class QueueActionError implements QueueState {
  const factory QueueActionError(final String error) = _$QueueActionErrorImpl;

  String get error;

  /// Create a copy of QueueState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueActionErrorImplCopyWith<_$QueueActionErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
