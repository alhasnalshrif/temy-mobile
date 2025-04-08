// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() categoriesLoading,
    required TResult Function(CategoryResponseModel categoriesResponseModel)
        categoriesSuccess,
    required TResult Function(ErrorHandler errorHandler) categoriesError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? categoriesLoading,
    TResult? Function(CategoryResponseModel categoriesResponseModel)?
        categoriesSuccess,
    TResult? Function(ErrorHandler errorHandler)? categoriesError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? categoriesLoading,
    TResult Function(CategoryResponseModel categoriesResponseModel)?
        categoriesSuccess,
    TResult Function(ErrorHandler errorHandler)? categoriesError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CategoriesLoading value) categoriesLoading,
    required TResult Function(CategoriesSuccess value) categoriesSuccess,
    required TResult Function(CategoriesError value) categoriesError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CategoriesLoading value)? categoriesLoading,
    TResult? Function(CategoriesSuccess value)? categoriesSuccess,
    TResult? Function(CategoriesError value)? categoriesError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CategoriesLoading value)? categoriesLoading,
    TResult Function(CategoriesSuccess value)? categoriesSuccess,
    TResult Function(CategoriesError value)? categoriesError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeStateCopyWith<$Res> {
  factory $HomeStateCopyWith(HomeState value, $Res Function(HomeState) then) =
      _$HomeStateCopyWithImpl<$Res, HomeState>;
}

/// @nodoc
class _$HomeStateCopyWithImpl<$Res, $Val extends HomeState>
    implements $HomeStateCopyWith<$Res> {
  _$HomeStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomeState
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
    extends _$HomeStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'HomeState.initial()';
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
    required TResult Function() categoriesLoading,
    required TResult Function(CategoryResponseModel categoriesResponseModel)
        categoriesSuccess,
    required TResult Function(ErrorHandler errorHandler) categoriesError,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? categoriesLoading,
    TResult? Function(CategoryResponseModel categoriesResponseModel)?
        categoriesSuccess,
    TResult? Function(ErrorHandler errorHandler)? categoriesError,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? categoriesLoading,
    TResult Function(CategoryResponseModel categoriesResponseModel)?
        categoriesSuccess,
    TResult Function(ErrorHandler errorHandler)? categoriesError,
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
    required TResult Function(CategoriesLoading value) categoriesLoading,
    required TResult Function(CategoriesSuccess value) categoriesSuccess,
    required TResult Function(CategoriesError value) categoriesError,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CategoriesLoading value)? categoriesLoading,
    TResult? Function(CategoriesSuccess value)? categoriesSuccess,
    TResult? Function(CategoriesError value)? categoriesError,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CategoriesLoading value)? categoriesLoading,
    TResult Function(CategoriesSuccess value)? categoriesSuccess,
    TResult Function(CategoriesError value)? categoriesError,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements HomeState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$CategoriesLoadingImplCopyWith<$Res> {
  factory _$$CategoriesLoadingImplCopyWith(_$CategoriesLoadingImpl value,
          $Res Function(_$CategoriesLoadingImpl) then) =
      __$$CategoriesLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CategoriesLoadingImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$CategoriesLoadingImpl>
    implements _$$CategoriesLoadingImplCopyWith<$Res> {
  __$$CategoriesLoadingImplCopyWithImpl(_$CategoriesLoadingImpl _value,
      $Res Function(_$CategoriesLoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CategoriesLoadingImpl implements CategoriesLoading {
  const _$CategoriesLoadingImpl();

  @override
  String toString() {
    return 'HomeState.categoriesLoading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$CategoriesLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() categoriesLoading,
    required TResult Function(CategoryResponseModel categoriesResponseModel)
        categoriesSuccess,
    required TResult Function(ErrorHandler errorHandler) categoriesError,
  }) {
    return categoriesLoading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? categoriesLoading,
    TResult? Function(CategoryResponseModel categoriesResponseModel)?
        categoriesSuccess,
    TResult? Function(ErrorHandler errorHandler)? categoriesError,
  }) {
    return categoriesLoading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? categoriesLoading,
    TResult Function(CategoryResponseModel categoriesResponseModel)?
        categoriesSuccess,
    TResult Function(ErrorHandler errorHandler)? categoriesError,
    required TResult orElse(),
  }) {
    if (categoriesLoading != null) {
      return categoriesLoading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CategoriesLoading value) categoriesLoading,
    required TResult Function(CategoriesSuccess value) categoriesSuccess,
    required TResult Function(CategoriesError value) categoriesError,
  }) {
    return categoriesLoading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CategoriesLoading value)? categoriesLoading,
    TResult? Function(CategoriesSuccess value)? categoriesSuccess,
    TResult? Function(CategoriesError value)? categoriesError,
  }) {
    return categoriesLoading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CategoriesLoading value)? categoriesLoading,
    TResult Function(CategoriesSuccess value)? categoriesSuccess,
    TResult Function(CategoriesError value)? categoriesError,
    required TResult orElse(),
  }) {
    if (categoriesLoading != null) {
      return categoriesLoading(this);
    }
    return orElse();
  }
}

abstract class CategoriesLoading implements HomeState {
  const factory CategoriesLoading() = _$CategoriesLoadingImpl;
}

/// @nodoc
abstract class _$$CategoriesSuccessImplCopyWith<$Res> {
  factory _$$CategoriesSuccessImplCopyWith(_$CategoriesSuccessImpl value,
          $Res Function(_$CategoriesSuccessImpl) then) =
      __$$CategoriesSuccessImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CategoryResponseModel categoriesResponseModel});
}

/// @nodoc
class __$$CategoriesSuccessImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$CategoriesSuccessImpl>
    implements _$$CategoriesSuccessImplCopyWith<$Res> {
  __$$CategoriesSuccessImplCopyWithImpl(_$CategoriesSuccessImpl _value,
      $Res Function(_$CategoriesSuccessImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoriesResponseModel = null,
  }) {
    return _then(_$CategoriesSuccessImpl(
      null == categoriesResponseModel
          ? _value.categoriesResponseModel
          : categoriesResponseModel // ignore: cast_nullable_to_non_nullable
              as CategoryResponseModel,
    ));
  }
}

/// @nodoc

class _$CategoriesSuccessImpl implements CategoriesSuccess {
  const _$CategoriesSuccessImpl(this.categoriesResponseModel);

  @override
  final CategoryResponseModel categoriesResponseModel;

  @override
  String toString() {
    return 'HomeState.categoriesSuccess(categoriesResponseModel: $categoriesResponseModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoriesSuccessImpl &&
            (identical(
                    other.categoriesResponseModel, categoriesResponseModel) ||
                other.categoriesResponseModel == categoriesResponseModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, categoriesResponseModel);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoriesSuccessImplCopyWith<_$CategoriesSuccessImpl> get copyWith =>
      __$$CategoriesSuccessImplCopyWithImpl<_$CategoriesSuccessImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() categoriesLoading,
    required TResult Function(CategoryResponseModel categoriesResponseModel)
        categoriesSuccess,
    required TResult Function(ErrorHandler errorHandler) categoriesError,
  }) {
    return categoriesSuccess(categoriesResponseModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? categoriesLoading,
    TResult? Function(CategoryResponseModel categoriesResponseModel)?
        categoriesSuccess,
    TResult? Function(ErrorHandler errorHandler)? categoriesError,
  }) {
    return categoriesSuccess?.call(categoriesResponseModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? categoriesLoading,
    TResult Function(CategoryResponseModel categoriesResponseModel)?
        categoriesSuccess,
    TResult Function(ErrorHandler errorHandler)? categoriesError,
    required TResult orElse(),
  }) {
    if (categoriesSuccess != null) {
      return categoriesSuccess(categoriesResponseModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CategoriesLoading value) categoriesLoading,
    required TResult Function(CategoriesSuccess value) categoriesSuccess,
    required TResult Function(CategoriesError value) categoriesError,
  }) {
    return categoriesSuccess(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CategoriesLoading value)? categoriesLoading,
    TResult? Function(CategoriesSuccess value)? categoriesSuccess,
    TResult? Function(CategoriesError value)? categoriesError,
  }) {
    return categoriesSuccess?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CategoriesLoading value)? categoriesLoading,
    TResult Function(CategoriesSuccess value)? categoriesSuccess,
    TResult Function(CategoriesError value)? categoriesError,
    required TResult orElse(),
  }) {
    if (categoriesSuccess != null) {
      return categoriesSuccess(this);
    }
    return orElse();
  }
}

abstract class CategoriesSuccess implements HomeState {
  const factory CategoriesSuccess(
          final CategoryResponseModel categoriesResponseModel) =
      _$CategoriesSuccessImpl;

  CategoryResponseModel get categoriesResponseModel;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoriesSuccessImplCopyWith<_$CategoriesSuccessImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$CategoriesErrorImplCopyWith<$Res> {
  factory _$$CategoriesErrorImplCopyWith(_$CategoriesErrorImpl value,
          $Res Function(_$CategoriesErrorImpl) then) =
      __$$CategoriesErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ErrorHandler errorHandler});
}

/// @nodoc
class __$$CategoriesErrorImplCopyWithImpl<$Res>
    extends _$HomeStateCopyWithImpl<$Res, _$CategoriesErrorImpl>
    implements _$$CategoriesErrorImplCopyWith<$Res> {
  __$$CategoriesErrorImplCopyWithImpl(
      _$CategoriesErrorImpl _value, $Res Function(_$CategoriesErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorHandler = null,
  }) {
    return _then(_$CategoriesErrorImpl(
      null == errorHandler
          ? _value.errorHandler
          : errorHandler // ignore: cast_nullable_to_non_nullable
              as ErrorHandler,
    ));
  }
}

/// @nodoc

class _$CategoriesErrorImpl implements CategoriesError {
  const _$CategoriesErrorImpl(this.errorHandler);

  @override
  final ErrorHandler errorHandler;

  @override
  String toString() {
    return 'HomeState.categoriesError(errorHandler: $errorHandler)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoriesErrorImpl &&
            (identical(other.errorHandler, errorHandler) ||
                other.errorHandler == errorHandler));
  }

  @override
  int get hashCode => Object.hash(runtimeType, errorHandler);

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoriesErrorImplCopyWith<_$CategoriesErrorImpl> get copyWith =>
      __$$CategoriesErrorImplCopyWithImpl<_$CategoriesErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() categoriesLoading,
    required TResult Function(CategoryResponseModel categoriesResponseModel)
        categoriesSuccess,
    required TResult Function(ErrorHandler errorHandler) categoriesError,
  }) {
    return categoriesError(errorHandler);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? categoriesLoading,
    TResult? Function(CategoryResponseModel categoriesResponseModel)?
        categoriesSuccess,
    TResult? Function(ErrorHandler errorHandler)? categoriesError,
  }) {
    return categoriesError?.call(errorHandler);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? categoriesLoading,
    TResult Function(CategoryResponseModel categoriesResponseModel)?
        categoriesSuccess,
    TResult Function(ErrorHandler errorHandler)? categoriesError,
    required TResult orElse(),
  }) {
    if (categoriesError != null) {
      return categoriesError(errorHandler);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(CategoriesLoading value) categoriesLoading,
    required TResult Function(CategoriesSuccess value) categoriesSuccess,
    required TResult Function(CategoriesError value) categoriesError,
  }) {
    return categoriesError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(CategoriesLoading value)? categoriesLoading,
    TResult? Function(CategoriesSuccess value)? categoriesSuccess,
    TResult? Function(CategoriesError value)? categoriesError,
  }) {
    return categoriesError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(CategoriesLoading value)? categoriesLoading,
    TResult Function(CategoriesSuccess value)? categoriesSuccess,
    TResult Function(CategoriesError value)? categoriesError,
    required TResult orElse(),
  }) {
    if (categoriesError != null) {
      return categoriesError(this);
    }
    return orElse();
  }
}

abstract class CategoriesError implements HomeState {
  const factory CategoriesError(final ErrorHandler errorHandler) =
      _$CategoriesErrorImpl;

  ErrorHandler get errorHandler;

  /// Create a copy of HomeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CategoriesErrorImplCopyWith<_$CategoriesErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
