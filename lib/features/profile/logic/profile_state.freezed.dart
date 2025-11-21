// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState()';
}


}

/// @nodoc
class $ProfileStateCopyWith<$Res>  {
$ProfileStateCopyWith(ProfileState _, $Res Function(ProfileState) __);
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( ProfileLoading value)?  profileLoading,TResult Function( ProfileSuccess value)?  profileSuccess,TResult Function( ProfileError value)?  profileError,TResult Function( DeleteLoading value)?  deleteLoading,TResult Function( DeleteSuccess value)?  deleteSuccess,TResult Function( DeleteError value)?  deleteError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ProfileLoading() when profileLoading != null:
return profileLoading(_that);case ProfileSuccess() when profileSuccess != null:
return profileSuccess(_that);case ProfileError() when profileError != null:
return profileError(_that);case DeleteLoading() when deleteLoading != null:
return deleteLoading(_that);case DeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that);case DeleteError() when deleteError != null:
return deleteError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( ProfileLoading value)  profileLoading,required TResult Function( ProfileSuccess value)  profileSuccess,required TResult Function( ProfileError value)  profileError,required TResult Function( DeleteLoading value)  deleteLoading,required TResult Function( DeleteSuccess value)  deleteSuccess,required TResult Function( DeleteError value)  deleteError,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case ProfileLoading():
return profileLoading(_that);case ProfileSuccess():
return profileSuccess(_that);case ProfileError():
return profileError(_that);case DeleteLoading():
return deleteLoading(_that);case DeleteSuccess():
return deleteSuccess(_that);case DeleteError():
return deleteError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( ProfileLoading value)?  profileLoading,TResult? Function( ProfileSuccess value)?  profileSuccess,TResult? Function( ProfileError value)?  profileError,TResult? Function( DeleteLoading value)?  deleteLoading,TResult? Function( DeleteSuccess value)?  deleteSuccess,TResult? Function( DeleteError value)?  deleteError,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case ProfileLoading() when profileLoading != null:
return profileLoading(_that);case ProfileSuccess() when profileSuccess != null:
return profileSuccess(_that);case ProfileError() when profileError != null:
return profileError(_that);case DeleteLoading() when deleteLoading != null:
return deleteLoading(_that);case DeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that);case DeleteError() when deleteError != null:
return deleteError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  profileLoading,TResult Function( UserProfile userProfile)?  profileSuccess,TResult Function( ErrorHandler errorHandler)?  profileError,TResult Function()?  deleteLoading,TResult Function( String message)?  deleteSuccess,TResult Function( ErrorHandler errorHandler)?  deleteError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ProfileLoading() when profileLoading != null:
return profileLoading();case ProfileSuccess() when profileSuccess != null:
return profileSuccess(_that.userProfile);case ProfileError() when profileError != null:
return profileError(_that.errorHandler);case DeleteLoading() when deleteLoading != null:
return deleteLoading();case DeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that.message);case DeleteError() when deleteError != null:
return deleteError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  profileLoading,required TResult Function( UserProfile userProfile)  profileSuccess,required TResult Function( ErrorHandler errorHandler)  profileError,required TResult Function()  deleteLoading,required TResult Function( String message)  deleteSuccess,required TResult Function( ErrorHandler errorHandler)  deleteError,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case ProfileLoading():
return profileLoading();case ProfileSuccess():
return profileSuccess(_that.userProfile);case ProfileError():
return profileError(_that.errorHandler);case DeleteLoading():
return deleteLoading();case DeleteSuccess():
return deleteSuccess(_that.message);case DeleteError():
return deleteError(_that.errorHandler);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  profileLoading,TResult? Function( UserProfile userProfile)?  profileSuccess,TResult? Function( ErrorHandler errorHandler)?  profileError,TResult? Function()?  deleteLoading,TResult? Function( String message)?  deleteSuccess,TResult? Function( ErrorHandler errorHandler)?  deleteError,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case ProfileLoading() when profileLoading != null:
return profileLoading();case ProfileSuccess() when profileSuccess != null:
return profileSuccess(_that.userProfile);case ProfileError() when profileError != null:
return profileError(_that.errorHandler);case DeleteLoading() when deleteLoading != null:
return deleteLoading();case DeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that.message);case DeleteError() when deleteError != null:
return deleteError(_that.errorHandler);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ProfileState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.initial()';
}


}




/// @nodoc


class ProfileLoading implements ProfileState {
  const ProfileLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.profileLoading()';
}


}




/// @nodoc


class ProfileSuccess implements ProfileState {
  const ProfileSuccess(this.userProfile);
  

 final  UserProfile userProfile;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSuccessCopyWith<ProfileSuccess> get copyWith => _$ProfileSuccessCopyWithImpl<ProfileSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSuccess&&(identical(other.userProfile, userProfile) || other.userProfile == userProfile));
}


@override
int get hashCode => Object.hash(runtimeType,userProfile);

@override
String toString() {
  return 'ProfileState.profileSuccess(userProfile: $userProfile)';
}


}

/// @nodoc
abstract mixin class $ProfileSuccessCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileSuccessCopyWith(ProfileSuccess value, $Res Function(ProfileSuccess) _then) = _$ProfileSuccessCopyWithImpl;
@useResult
$Res call({
 UserProfile userProfile
});




}
/// @nodoc
class _$ProfileSuccessCopyWithImpl<$Res>
    implements $ProfileSuccessCopyWith<$Res> {
  _$ProfileSuccessCopyWithImpl(this._self, this._then);

  final ProfileSuccess _self;
  final $Res Function(ProfileSuccess) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userProfile = null,}) {
  return _then(ProfileSuccess(
null == userProfile ? _self.userProfile : userProfile // ignore: cast_nullable_to_non_nullable
as UserProfile,
  ));
}


}

/// @nodoc


class ProfileError implements ProfileState {
  const ProfileError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileErrorCopyWith<ProfileError> get copyWith => _$ProfileErrorCopyWithImpl<ProfileError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'ProfileState.profileError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $ProfileErrorCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileErrorCopyWith(ProfileError value, $Res Function(ProfileError) _then) = _$ProfileErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$ProfileErrorCopyWithImpl<$Res>
    implements $ProfileErrorCopyWith<$Res> {
  _$ProfileErrorCopyWithImpl(this._self, this._then);

  final ProfileError _self;
  final $Res Function(ProfileError) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(ProfileError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

/// @nodoc


class DeleteLoading implements ProfileState {
  const DeleteLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.deleteLoading()';
}


}




/// @nodoc


class DeleteSuccess implements ProfileState {
  const DeleteSuccess(this.message);
  

 final  String message;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteSuccessCopyWith<DeleteSuccess> get copyWith => _$DeleteSuccessCopyWithImpl<DeleteSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ProfileState.deleteSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class $DeleteSuccessCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $DeleteSuccessCopyWith(DeleteSuccess value, $Res Function(DeleteSuccess) _then) = _$DeleteSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$DeleteSuccessCopyWithImpl<$Res>
    implements $DeleteSuccessCopyWith<$Res> {
  _$DeleteSuccessCopyWithImpl(this._self, this._then);

  final DeleteSuccess _self;
  final $Res Function(DeleteSuccess) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(DeleteSuccess(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class DeleteError implements ProfileState {
  const DeleteError(this.errorHandler);
  

 final  ErrorHandler errorHandler;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeleteErrorCopyWith<DeleteError> get copyWith => _$DeleteErrorCopyWithImpl<DeleteError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeleteError&&(identical(other.errorHandler, errorHandler) || other.errorHandler == errorHandler));
}


@override
int get hashCode => Object.hash(runtimeType,errorHandler);

@override
String toString() {
  return 'ProfileState.deleteError(errorHandler: $errorHandler)';
}


}

/// @nodoc
abstract mixin class $DeleteErrorCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $DeleteErrorCopyWith(DeleteError value, $Res Function(DeleteError) _then) = _$DeleteErrorCopyWithImpl;
@useResult
$Res call({
 ErrorHandler errorHandler
});




}
/// @nodoc
class _$DeleteErrorCopyWithImpl<$Res>
    implements $DeleteErrorCopyWith<$Res> {
  _$DeleteErrorCopyWithImpl(this._self, this._then);

  final DeleteError _self;
  final $Res Function(DeleteError) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? errorHandler = null,}) {
  return _then(DeleteError(
null == errorHandler ? _self.errorHandler : errorHandler // ignore: cast_nullable_to_non_nullable
as ErrorHandler,
  ));
}


}

// dart format on
