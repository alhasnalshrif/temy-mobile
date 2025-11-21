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
mixin _$CategoryBarberState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryBarberState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryBarberState()';
}


}

/// @nodoc
class $CategoryBarberStateCopyWith<$Res>  {
$CategoryBarberStateCopyWith(CategoryBarberState _, $Res Function(CategoryBarberState) __);
}


/// Adds pattern-matching-related methods to [CategoryBarberState].
extension CategoryBarberStatePatterns on CategoryBarberState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( CategoryWithBarbersLoading value)?  categoryWithBarbersLoading,TResult Function( CategoryWithBarbersSuccess value)?  categoryWithBarbersSuccess,TResult Function( CategoryWithBarbersError value)?  categoryWithBarbersError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CategoryWithBarbersLoading() when categoryWithBarbersLoading != null:
return categoryWithBarbersLoading(_that);case CategoryWithBarbersSuccess() when categoryWithBarbersSuccess != null:
return categoryWithBarbersSuccess(_that);case CategoryWithBarbersError() when categoryWithBarbersError != null:
return categoryWithBarbersError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( CategoryWithBarbersLoading value)  categoryWithBarbersLoading,required TResult Function( CategoryWithBarbersSuccess value)  categoryWithBarbersSuccess,required TResult Function( CategoryWithBarbersError value)  categoryWithBarbersError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case CategoryWithBarbersLoading():
return categoryWithBarbersLoading(_that);case CategoryWithBarbersSuccess():
return categoryWithBarbersSuccess(_that);case CategoryWithBarbersError():
return categoryWithBarbersError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( CategoryWithBarbersLoading value)?  categoryWithBarbersLoading,TResult? Function( CategoryWithBarbersSuccess value)?  categoryWithBarbersSuccess,TResult? Function( CategoryWithBarbersError value)?  categoryWithBarbersError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case CategoryWithBarbersLoading() when categoryWithBarbersLoading != null:
return categoryWithBarbersLoading(_that);case CategoryWithBarbersSuccess() when categoryWithBarbersSuccess != null:
return categoryWithBarbersSuccess(_that);case CategoryWithBarbersError() when categoryWithBarbersError != null:
return categoryWithBarbersError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  categoryWithBarbersLoading,TResult Function( CategoryServicesResponseModel categoryServicesResponse)?  categoryWithBarbersSuccess,TResult Function( ErrorHandler errorHandler)?  categoryWithBarbersError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case CategoryWithBarbersLoading() when categoryWithBarbersLoading != null:
return categoryWithBarbersLoading();case CategoryWithBarbersSuccess() when categoryWithBarbersSuccess != null:
return categoryWithBarbersSuccess(_that.categoryServicesResponse);case CategoryWithBarbersError() when categoryWithBarbersError != null:
return categoryWithBarbersError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  categoryWithBarbersLoading,required TResult Function( CategoryServicesResponseModel categoryServicesResponse)  categoryWithBarbersSuccess,required TResult Function( ErrorHandler errorHandler)  categoryWithBarbersError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case CategoryWithBarbersLoading():
return categoryWithBarbersLoading();case CategoryWithBarbersSuccess():
return categoryWithBarbersSuccess(_that.categoryServicesResponse);case CategoryWithBarbersError():
return categoryWithBarbersError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  categoryWithBarbersLoading,TResult? Function( CategoryServicesResponseModel categoryServicesResponse)?  categoryWithBarbersSuccess,TResult? Function( ErrorHandler errorHandler)?  categoryWithBarbersError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case CategoryWithBarbersLoading() when categoryWithBarbersLoading != null:
return categoryWithBarbersLoading();case CategoryWithBarbersSuccess() when categoryWithBarbersSuccess != null:
return categoryWithBarbersSuccess(_that.categoryServicesResponse);case CategoryWithBarbersError() when categoryWithBarbersError != null:
return categoryWithBarbersError(_that.errorHandler);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements CategoryBarberState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryBarberState.initial()';
}


}




/// @nodoc


class CategoryWithBarbersLoading implements CategoryBarberState {
  const CategoryWithBarbersLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryWithBarbersLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CategoryBarberState.categoryWithBarbersLoading()';
}


}




/// @nodoc


class CategoryWithBarbersSuccess implements CategoryBarberState {
  const CategoryWithBarbersSuccess(this.categoryServicesResponse);
  

 final  CategoryServicesResponseModel categoryServicesResponse;

/// Create a copy of CategoryBarberState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryWithBarbersSuccessCopyWith<CategoryWithBarbersSuccess> get copyWith => _$CategoryWithBarbersSuccessCopyWithImpl<CategoryWithBarbersSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryWithBarbersSuccess&&(identical(other.categoryServicesResponse, categoryServicesResponse) || other.categoryServicesResponse == categoryServicesResponse));
}


@override
int get hashCode => Object.hash(runtimeType,categoryServicesResponse);

@override
String toString() {
  return 'CategoryBarberState.categoryWithBarbersSuccess(categoryServicesResponse: $categoryServicesResponse)';
}


}

/// @nodoc
abstract mixin class $CategoryWithBarbersSuccessCopyWith<$Res> implements $CategoryBarberStateCopyWith<$Res> {
  factory $CategoryWithBarbersSuccessCopyWith(CategoryWithBarbersSuccess value, $Res Function(CategoryWithBarbersSuccess) _then) = _$CategoryWithBarbersSuccessCopyWithImpl;
@useResult
$Res call({
 CategoryServicesResponseModel categoryServicesResponse
});




}
/// @nodoc
class _$CategoryWithBarbersSuccessCopyWithImpl<$Res>
    implements $CategoryWithBarbersSuccessCopyWith<$Res> {
  _$CategoryWithBarbersSuccessCopyWithImpl(this._self, this._then);

  final CategoryWithBarbersSuccess _self;
  final $Res Function(CategoryWithBarbersSuccess) _then;

/// Create a copy of CategoryBarberState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? categoryServicesResponse = null,}) {
  return _then(CategoryWithBarbersSuccess(
null == categoryServicesResponse ? _self.categoryServicesResponse : categoryServicesResponse // ignore: cast_nullable_to_non_nullable
as CategoryServicesResponseModel,
  ));
}


}

/// @nodoc


class CategoryWithBarbersError implements CategoryBarberState {
  const CategoryWithBarbersError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of CategoryBarberState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryWithBarbersErrorCopyWith<CategoryWithBarbersError> get copyWith => _$CategoryWithBarbersErrorCopyWithImpl<CategoryWithBarbersError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryWithBarbersError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'CategoryBarberState.categoryWithBarbersError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $CategoryWithBarbersErrorCopyWith<$Res> implements $CategoryBarberStateCopyWith<$Res> {
  factory $CategoryWithBarbersErrorCopyWith(CategoryWithBarbersError value, $Res Function(CategoryWithBarbersError) _then) = _$CategoryWithBarbersErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$CategoryWithBarbersErrorCopyWithImpl<$Res>
    implements $CategoryWithBarbersErrorCopyWith<$Res> {
  _$CategoryWithBarbersErrorCopyWithImpl(this._self, this._then);

  final CategoryWithBarbersError _self;
  final $Res Function(CategoryWithBarbersError) _then;

/// Create a copy of CategoryBarberState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(CategoryWithBarbersError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

// dart format on
