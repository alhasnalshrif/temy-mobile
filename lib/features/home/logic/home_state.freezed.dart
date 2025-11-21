// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState()';
}


}

/// @nodoc
class $HomeStateCopyWith<$Res>  {
$HomeStateCopyWith(HomeState _, $Res Function(HomeState) __);
}


/// Adds pattern-matching-related methods to [HomeState].
extension HomeStatePatterns on HomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( CategoriesLoading value)?  categoriesLoading,TResult Function( CategoriesSuccess value)?  categoriesSuccess,TResult Function( CategoriesError value)?  categoriesError,TResult Function( BarbersLoading value)?  barbersLoading,TResult Function( BarbersSuccess value)?  barbersSuccess,TResult Function( BarbersError value)?  barbersError,TResult Function( BannersLoading value)?  bannersLoading,TResult Function( BannersSuccess value)?  bannersSuccess,TResult Function( BannersError value)?  bannersError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CategoriesLoading() when categoriesLoading != null:
return categoriesLoading(_that);case CategoriesSuccess() when categoriesSuccess != null:
return categoriesSuccess(_that);case CategoriesError() when categoriesError != null:
return categoriesError(_that);case BarbersLoading() when barbersLoading != null:
return barbersLoading(_that);case BarbersSuccess() when barbersSuccess != null:
return barbersSuccess(_that);case BarbersError() when barbersError != null:
return barbersError(_that);case BannersLoading() when bannersLoading != null:
return bannersLoading(_that);case BannersSuccess() when bannersSuccess != null:
return bannersSuccess(_that);case BannersError() when bannersError != null:
return bannersError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( CategoriesLoading value)  categoriesLoading,required TResult Function( CategoriesSuccess value)  categoriesSuccess,required TResult Function( CategoriesError value)  categoriesError,required TResult Function( BarbersLoading value)  barbersLoading,required TResult Function( BarbersSuccess value)  barbersSuccess,required TResult Function( BarbersError value)  barbersError,required TResult Function( BannersLoading value)  bannersLoading,required TResult Function( BannersSuccess value)  bannersSuccess,required TResult Function( BannersError value)  bannersError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case CategoriesLoading():
return categoriesLoading(_that);case CategoriesSuccess():
return categoriesSuccess(_that);case CategoriesError():
return categoriesError(_that);case BarbersLoading():
return barbersLoading(_that);case BarbersSuccess():
return barbersSuccess(_that);case BarbersError():
return barbersError(_that);case BannersLoading():
return bannersLoading(_that);case BannersSuccess():
return bannersSuccess(_that);case BannersError():
return bannersError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( CategoriesLoading value)?  categoriesLoading,TResult? Function( CategoriesSuccess value)?  categoriesSuccess,TResult? Function( CategoriesError value)?  categoriesError,TResult? Function( BarbersLoading value)?  barbersLoading,TResult? Function( BarbersSuccess value)?  barbersSuccess,TResult? Function( BarbersError value)?  barbersError,TResult? Function( BannersLoading value)?  bannersLoading,TResult? Function( BannersSuccess value)?  bannersSuccess,TResult? Function( BannersError value)?  bannersError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CategoriesLoading() when categoriesLoading != null:
return categoriesLoading(_that);case CategoriesSuccess() when categoriesSuccess != null:
return categoriesSuccess(_that);case CategoriesError() when categoriesError != null:
return categoriesError(_that);case BarbersLoading() when barbersLoading != null:
return barbersLoading(_that);case BarbersSuccess() when barbersSuccess != null:
return barbersSuccess(_that);case BarbersError() when barbersError != null:
return barbersError(_that);case BannersLoading() when bannersLoading != null:
return bannersLoading(_that);case BannersSuccess() when bannersSuccess != null:
return bannersSuccess(_that);case BannersError() when bannersError != null:
return bannersError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  categoriesLoading,TResult Function( CategoryResponseModel categoriesResponseModel)?  categoriesSuccess,TResult Function( ErrorHandler errorHandler)?  categoriesError,TResult Function()?  barbersLoading,TResult Function( BarberResponseModel barbersResponseModel)?  barbersSuccess,TResult Function( ErrorHandler errorHandler)?  barbersError,TResult Function()?  bannersLoading,TResult Function( BannerResponseModel bannersResponseModel)?  bannersSuccess,TResult Function( ErrorHandler errorHandler)?  bannersError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case CategoriesLoading() when categoriesLoading != null:
return categoriesLoading();case CategoriesSuccess() when categoriesSuccess != null:
return categoriesSuccess(_that.categoriesResponseModel);case CategoriesError() when categoriesError != null:
return categoriesError(_that.errorHandler);case BarbersLoading() when barbersLoading != null:
return barbersLoading();case BarbersSuccess() when barbersSuccess != null:
return barbersSuccess(_that.barbersResponseModel);case BarbersError() when barbersError != null:
return barbersError(_that.errorHandler);case BannersLoading() when bannersLoading != null:
return bannersLoading();case BannersSuccess() when bannersSuccess != null:
return bannersSuccess(_that.bannersResponseModel);case BannersError() when bannersError != null:
return bannersError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  categoriesLoading,required TResult Function( CategoryResponseModel categoriesResponseModel)  categoriesSuccess,required TResult Function( ErrorHandler errorHandler)  categoriesError,required TResult Function()  barbersLoading,required TResult Function( BarberResponseModel barbersResponseModel)  barbersSuccess,required TResult Function( ErrorHandler errorHandler)  barbersError,required TResult Function()  bannersLoading,required TResult Function( BannerResponseModel bannersResponseModel)  bannersSuccess,required TResult Function( ErrorHandler errorHandler)  bannersError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case CategoriesLoading():
return categoriesLoading();case CategoriesSuccess():
return categoriesSuccess(_that.categoriesResponseModel);case CategoriesError():
return categoriesError(_that.errorHandler);case BarbersLoading():
return barbersLoading();case BarbersSuccess():
return barbersSuccess(_that.barbersResponseModel);case BarbersError():
return barbersError(_that.errorHandler);case BannersLoading():
return bannersLoading();case BannersSuccess():
return bannersSuccess(_that.bannersResponseModel);case BannersError():
return bannersError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  categoriesLoading,TResult? Function( CategoryResponseModel categoriesResponseModel)?  categoriesSuccess,TResult? Function( ErrorHandler errorHandler)?  categoriesError,TResult? Function()?  barbersLoading,TResult? Function( BarberResponseModel barbersResponseModel)?  barbersSuccess,TResult? Function( ErrorHandler errorHandler)?  barbersError,TResult? Function()?  bannersLoading,TResult? Function( BannerResponseModel bannersResponseModel)?  bannersSuccess,TResult? Function( ErrorHandler errorHandler)?  bannersError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case CategoriesLoading() when categoriesLoading != null:
return categoriesLoading();case CategoriesSuccess() when categoriesSuccess != null:
return categoriesSuccess(_that.categoriesResponseModel);case CategoriesError() when categoriesError != null:
return categoriesError(_that.errorHandler);case BarbersLoading() when barbersLoading != null:
return barbersLoading();case BarbersSuccess() when barbersSuccess != null:
return barbersSuccess(_that.barbersResponseModel);case BarbersError() when barbersError != null:
return barbersError(_that.errorHandler);case BannersLoading() when bannersLoading != null:
return bannersLoading();case BannersSuccess() when bannersSuccess != null:
return bannersSuccess(_that.bannersResponseModel);case BannersError() when bannersError != null:
return bannersError(_that.errorHandler);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements HomeState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.initial()';
}


}




/// @nodoc


class CategoriesLoading implements HomeState {
  const CategoriesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.categoriesLoading()';
}


}




/// @nodoc


class CategoriesSuccess implements HomeState {
  const CategoriesSuccess(this.categoriesResponseModel);
  

 final  CategoryResponseModel categoriesResponseModel;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoriesSuccessCopyWith<CategoriesSuccess> get copyWith => _$CategoriesSuccessCopyWithImpl<CategoriesSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesSuccess&&(identical(other.categoriesResponseModel, categoriesResponseModel) || other.categoriesResponseModel == categoriesResponseModel));
}


@override
int get hashCode => Object.hash(runtimeType,categoriesResponseModel);

@override
String toString() {
  return 'HomeState.categoriesSuccess(categoriesResponseModel: $categoriesResponseModel)';
}


}

/// @nodoc
abstract mixin class $CategoriesSuccessCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $CategoriesSuccessCopyWith(CategoriesSuccess value, $Res Function(CategoriesSuccess) _then) = _$CategoriesSuccessCopyWithImpl;
@useResult
$Res call({
 CategoryResponseModel categoriesResponseModel
});




}
/// @nodoc
class _$CategoriesSuccessCopyWithImpl<$Res>
    implements $CategoriesSuccessCopyWith<$Res> {
  _$CategoriesSuccessCopyWithImpl(this._self, this._then);

  final CategoriesSuccess _self;
  final $Res Function(CategoriesSuccess) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categoriesResponseModel = null,}) {
  return _then(CategoriesSuccess(
null == categoriesResponseModel ? _self.categoriesResponseModel : categoriesResponseModel // ignore: cast_nullable_to_non_nullable
as CategoryResponseModel,
  ));
}


}

/// @nodoc


class CategoriesError implements HomeState {
  const CategoriesError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoriesErrorCopyWith<CategoriesError> get copyWith => _$CategoriesErrorCopyWithImpl<CategoriesError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoriesError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'HomeState.categoriesError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $CategoriesErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $CategoriesErrorCopyWith(CategoriesError value, $Res Function(CategoriesError) _then) = _$CategoriesErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$CategoriesErrorCopyWithImpl<$Res>
    implements $CategoriesErrorCopyWith<$Res> {
  _$CategoriesErrorCopyWithImpl(this._self, this._then);

  final CategoriesError _self;
  final $Res Function(CategoriesError) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(CategoriesError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

/// @nodoc


class BarbersLoading implements HomeState {
  const BarbersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarbersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.barbersLoading()';
}


}




/// @nodoc


class BarbersSuccess implements HomeState {
  const BarbersSuccess(this.barbersResponseModel);
  

 final  BarberResponseModel barbersResponseModel;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarbersSuccessCopyWith<BarbersSuccess> get copyWith => _$BarbersSuccessCopyWithImpl<BarbersSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarbersSuccess&&(identical(other.barbersResponseModel, barbersResponseModel) || other.barbersResponseModel == barbersResponseModel));
}


@override
int get hashCode => Object.hash(runtimeType,barbersResponseModel);

@override
String toString() {
  return 'HomeState.barbersSuccess(barbersResponseModel: $barbersResponseModel)';
}


}

/// @nodoc
abstract mixin class $BarbersSuccessCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $BarbersSuccessCopyWith(BarbersSuccess value, $Res Function(BarbersSuccess) _then) = _$BarbersSuccessCopyWithImpl;
@useResult
$Res call({
 BarberResponseModel barbersResponseModel
});




}
/// @nodoc
class _$BarbersSuccessCopyWithImpl<$Res>
    implements $BarbersSuccessCopyWith<$Res> {
  _$BarbersSuccessCopyWithImpl(this._self, this._then);

  final BarbersSuccess _self;
  final $Res Function(BarbersSuccess) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? barbersResponseModel = null,}) {
  return _then(BarbersSuccess(
null == barbersResponseModel ? _self.barbersResponseModel : barbersResponseModel // ignore: cast_nullable_to_non_nullable
as BarberResponseModel,
  ));
}


}

/// @nodoc


class BarbersError implements HomeState {
  const BarbersError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BarbersErrorCopyWith<BarbersError> get copyWith => _$BarbersErrorCopyWithImpl<BarbersError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BarbersError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'HomeState.barbersError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $BarbersErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $BarbersErrorCopyWith(BarbersError value, $Res Function(BarbersError) _then) = _$BarbersErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$BarbersErrorCopyWithImpl<$Res>
    implements $BarbersErrorCopyWith<$Res> {
  _$BarbersErrorCopyWithImpl(this._self, this._then);

  final BarbersError _self;
  final $Res Function(BarbersError) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(BarbersError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

/// @nodoc


class BannersLoading implements HomeState {
  const BannersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BannersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeState.bannersLoading()';
}


}




/// @nodoc


class BannersSuccess implements HomeState {
  const BannersSuccess(this.bannersResponseModel);
  

 final  BannerResponseModel bannersResponseModel;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BannersSuccessCopyWith<BannersSuccess> get copyWith => _$BannersSuccessCopyWithImpl<BannersSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BannersSuccess&&(identical(other.bannersResponseModel, bannersResponseModel) || other.bannersResponseModel == bannersResponseModel));
}


@override
int get hashCode => Object.hash(runtimeType,bannersResponseModel);

@override
String toString() {
  return 'HomeState.bannersSuccess(bannersResponseModel: $bannersResponseModel)';
}


}

/// @nodoc
abstract mixin class $BannersSuccessCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $BannersSuccessCopyWith(BannersSuccess value, $Res Function(BannersSuccess) _then) = _$BannersSuccessCopyWithImpl;
@useResult
$Res call({
 BannerResponseModel bannersResponseModel
});




}
/// @nodoc
class _$BannersSuccessCopyWithImpl<$Res>
    implements $BannersSuccessCopyWith<$Res> {
  _$BannersSuccessCopyWithImpl(this._self, this._then);

  final BannersSuccess _self;
  final $Res Function(BannersSuccess) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? bannersResponseModel = null,}) {
  return _then(BannersSuccess(
null == bannersResponseModel ? _self.bannersResponseModel : bannersResponseModel // ignore: cast_nullable_to_non_nullable
as BannerResponseModel,
  ));
}


}

/// @nodoc


class BannersError implements HomeState {
  const BannersError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BannersErrorCopyWith<BannersError> get copyWith => _$BannersErrorCopyWithImpl<BannersError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BannersError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'HomeState.bannersError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $BannersErrorCopyWith<$Res> implements $HomeStateCopyWith<$Res> {
  factory $BannersErrorCopyWith(BannersError value, $Res Function(BannersError) _then) = _$BannersErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$BannersErrorCopyWithImpl<$Res>
    implements $BannersErrorCopyWith<$Res> {
  _$BannersErrorCopyWithImpl(this._self, this._then);

  final BannersError _self;
  final $Res Function(BannersError) _then;

/// Create a copy of HomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(BannersError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

// dart format on
