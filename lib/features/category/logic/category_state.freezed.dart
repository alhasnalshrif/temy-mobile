// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CategoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState()';
}


}

/// @nodoc
class $CategoryStateCopyWith<$Res>  {
$CategoryStateCopyWith(CategoryState _, $Res Function(CategoryState) __);
}


/// Adds pattern-matching-related methods to [CategoryState].
extension CategoryStatePatterns on CategoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( CategoryLoading value)?  categoryLoading,TResult Function( CategorySuccess value)?  categorySuccess,TResult Function( CategoryError value)?  categoryError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CategoryLoading() when categoryLoading != null:
return categoryLoading(_that);case CategorySuccess() when categorySuccess != null:
return categorySuccess(_that);case CategoryError() when categoryError != null:
return categoryError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( CategoryLoading value)  categoryLoading,required TResult Function( CategorySuccess value)  categorySuccess,required TResult Function( CategoryError value)  categoryError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case CategoryLoading():
return categoryLoading(_that);case CategorySuccess():
return categorySuccess(_that);case CategoryError():
return categoryError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( CategoryLoading value)?  categoryLoading,TResult? Function( CategorySuccess value)?  categorySuccess,TResult? Function( CategoryError value)?  categoryError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CategoryLoading() when categoryLoading != null:
return categoryLoading(_that);case CategorySuccess() when categorySuccess != null:
return categorySuccess(_that);case CategoryError() when categoryError != null:
return categoryError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  categoryLoading,TResult Function( CategoriesListResponseModel serviceResponseModel)?  categorySuccess,TResult Function( ErrorHandler errorHandler)?  categoryError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case CategoryLoading() when categoryLoading != null:
return categoryLoading();case CategorySuccess() when categorySuccess != null:
return categorySuccess(_that.serviceResponseModel);case CategoryError() when categoryError != null:
return categoryError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  categoryLoading,required TResult Function( CategoriesListResponseModel serviceResponseModel)  categorySuccess,required TResult Function( ErrorHandler errorHandler)  categoryError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case CategoryLoading():
return categoryLoading();case CategorySuccess():
return categorySuccess(_that.serviceResponseModel);case CategoryError():
return categoryError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  categoryLoading,TResult? Function( CategoriesListResponseModel serviceResponseModel)?  categorySuccess,TResult? Function( ErrorHandler errorHandler)?  categoryError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case CategoryLoading() when categoryLoading != null:
return categoryLoading();case CategorySuccess() when categorySuccess != null:
return categorySuccess(_that.serviceResponseModel);case CategoryError() when categoryError != null:
return categoryError(_that.errorHandler);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CategoryState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState.initial()';
}


}




/// @nodoc


class CategoryLoading implements CategoryState {
  const CategoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryState.categoryLoading()';
}


}




/// @nodoc


class CategorySuccess implements CategoryState {
  const CategorySuccess(this.serviceResponseModel);
  

 final  CategoriesListResponseModel serviceResponseModel;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategorySuccessCopyWith<CategorySuccess> get copyWith => _$CategorySuccessCopyWithImpl<CategorySuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategorySuccess&&(identical(other.serviceResponseModel, serviceResponseModel) || other.serviceResponseModel == serviceResponseModel));
}


@override
int get hashCode => Object.hash(runtimeType,serviceResponseModel);

@override
String toString() {
  return 'CategoryState.categorySuccess(serviceResponseModel: $serviceResponseModel)';
}


}

/// @nodoc
abstract mixin class $CategorySuccessCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory $CategorySuccessCopyWith(CategorySuccess value, $Res Function(CategorySuccess) _then) = _$CategorySuccessCopyWithImpl;
@useResult
$Res call({
 CategoriesListResponseModel serviceResponseModel
});




}
/// @nodoc
class _$CategorySuccessCopyWithImpl<$Res>
    implements $CategorySuccessCopyWith<$Res> {
  _$CategorySuccessCopyWithImpl(this._self, this._then);

  final CategorySuccess _self;
  final $Res Function(CategorySuccess) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? serviceResponseModel = null,}) {
  return _then(CategorySuccess(
null == serviceResponseModel ? _self.serviceResponseModel : serviceResponseModel // ignore: cast_nullable_to_non_nullable
as CategoriesListResponseModel,
  ));
}


}

/// @nodoc


class CategoryError implements CategoryState {
  const CategoryError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryErrorCopyWith<CategoryError> get copyWith => _$CategoryErrorCopyWithImpl<CategoryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'CategoryState.categoryError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $CategoryErrorCopyWith<$Res> implements $CategoryStateCopyWith<$Res> {
  factory $CategoryErrorCopyWith(CategoryError value, $Res Function(CategoryError) _then) = _$CategoryErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$CategoryErrorCopyWithImpl<$Res>
    implements $CategoryErrorCopyWith<$Res> {
  _$CategoryErrorCopyWithImpl(this._self, this._then);

  final CategoryError _self;
  final $Res Function(CategoryError) _then;

/// Create a copy of CategoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(CategoryError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

// dart format on
