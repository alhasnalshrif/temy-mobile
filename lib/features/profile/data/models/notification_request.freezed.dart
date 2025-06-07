// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationTokenRequest _$NotificationTokenRequestFromJson(
    Map<String, dynamic> json) {
  return _NotificationTokenRequest.fromJson(json);
}

/// @nodoc
mixin _$NotificationTokenRequest {
  @JsonKey(name: 'device_token')
  String get deviceToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'player_id')
  String? get playerId => throw _privateConstructorUsedError;
  @JsonKey(name: 'platform')
  String get platform => throw _privateConstructorUsedError;

  /// Serializes this NotificationTokenRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationTokenRequestCopyWith<NotificationTokenRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationTokenRequestCopyWith<$Res> {
  factory $NotificationTokenRequestCopyWith(NotificationTokenRequest value,
          $Res Function(NotificationTokenRequest) then) =
      _$NotificationTokenRequestCopyWithImpl<$Res, NotificationTokenRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'device_token') String deviceToken,
      @JsonKey(name: 'player_id') String? playerId,
      @JsonKey(name: 'platform') String platform});
}

/// @nodoc
class _$NotificationTokenRequestCopyWithImpl<$Res,
        $Val extends NotificationTokenRequest>
    implements $NotificationTokenRequestCopyWith<$Res> {
  _$NotificationTokenRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceToken = null,
    Object? playerId = freezed,
    Object? platform = null,
  }) {
    return _then(_value.copyWith(
      deviceToken: null == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: freezed == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String?,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationTokenRequestImplCopyWith<$Res>
    implements $NotificationTokenRequestCopyWith<$Res> {
  factory _$$NotificationTokenRequestImplCopyWith(
          _$NotificationTokenRequestImpl value,
          $Res Function(_$NotificationTokenRequestImpl) then) =
      __$$NotificationTokenRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'device_token') String deviceToken,
      @JsonKey(name: 'player_id') String? playerId,
      @JsonKey(name: 'platform') String platform});
}

/// @nodoc
class __$$NotificationTokenRequestImplCopyWithImpl<$Res>
    extends _$NotificationTokenRequestCopyWithImpl<$Res,
        _$NotificationTokenRequestImpl>
    implements _$$NotificationTokenRequestImplCopyWith<$Res> {
  __$$NotificationTokenRequestImplCopyWithImpl(
      _$NotificationTokenRequestImpl _value,
      $Res Function(_$NotificationTokenRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deviceToken = null,
    Object? playerId = freezed,
    Object? platform = null,
  }) {
    return _then(_$NotificationTokenRequestImpl(
      deviceToken: null == deviceToken
          ? _value.deviceToken
          : deviceToken // ignore: cast_nullable_to_non_nullable
              as String,
      playerId: freezed == playerId
          ? _value.playerId
          : playerId // ignore: cast_nullable_to_non_nullable
              as String?,
      platform: null == platform
          ? _value.platform
          : platform // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationTokenRequestImpl implements _NotificationTokenRequest {
  const _$NotificationTokenRequestImpl(
      {@JsonKey(name: 'device_token') required this.deviceToken,
      @JsonKey(name: 'player_id') this.playerId,
      @JsonKey(name: 'platform') required this.platform});

  factory _$NotificationTokenRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationTokenRequestImplFromJson(json);

  @override
  @JsonKey(name: 'device_token')
  final String deviceToken;
  @override
  @JsonKey(name: 'player_id')
  final String? playerId;
  @override
  @JsonKey(name: 'platform')
  final String platform;

  @override
  String toString() {
    return 'NotificationTokenRequest(deviceToken: $deviceToken, playerId: $playerId, platform: $platform)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationTokenRequestImpl &&
            (identical(other.deviceToken, deviceToken) ||
                other.deviceToken == deviceToken) &&
            (identical(other.playerId, playerId) ||
                other.playerId == playerId) &&
            (identical(other.platform, platform) ||
                other.platform == platform));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, deviceToken, playerId, platform);

  /// Create a copy of NotificationTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationTokenRequestImplCopyWith<_$NotificationTokenRequestImpl>
      get copyWith => __$$NotificationTokenRequestImplCopyWithImpl<
          _$NotificationTokenRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationTokenRequestImplToJson(
      this,
    );
  }
}

abstract class _NotificationTokenRequest implements NotificationTokenRequest {
  const factory _NotificationTokenRequest(
          {@JsonKey(name: 'device_token') required final String deviceToken,
          @JsonKey(name: 'player_id') final String? playerId,
          @JsonKey(name: 'platform') required final String platform}) =
      _$NotificationTokenRequestImpl;

  factory _NotificationTokenRequest.fromJson(Map<String, dynamic> json) =
      _$NotificationTokenRequestImpl.fromJson;

  @override
  @JsonKey(name: 'device_token')
  String get deviceToken;
  @override
  @JsonKey(name: 'player_id')
  String? get playerId;
  @override
  @JsonKey(name: 'platform')
  String get platform;

  /// Create a copy of NotificationTokenRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationTokenRequestImplCopyWith<_$NotificationTokenRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationSettingsRequest _$NotificationSettingsRequestFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingsRequest.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingsRequest {
  @JsonKey(name: 'push_notifications')
  bool get pushNotifications => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_reminders')
  bool? get bookingReminders => throw _privateConstructorUsedError;
  @JsonKey(name: 'promotional_notifications')
  bool? get promotionalNotifications => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettingsRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsRequestCopyWith<NotificationSettingsRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsRequestCopyWith<$Res> {
  factory $NotificationSettingsRequestCopyWith(
          NotificationSettingsRequest value,
          $Res Function(NotificationSettingsRequest) then) =
      _$NotificationSettingsRequestCopyWithImpl<$Res,
          NotificationSettingsRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: 'push_notifications') bool pushNotifications,
      @JsonKey(name: 'booking_reminders') bool? bookingReminders,
      @JsonKey(name: 'promotional_notifications')
      bool? promotionalNotifications});
}

/// @nodoc
class _$NotificationSettingsRequestCopyWithImpl<$Res,
        $Val extends NotificationSettingsRequest>
    implements $NotificationSettingsRequestCopyWith<$Res> {
  _$NotificationSettingsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushNotifications = null,
    Object? bookingReminders = freezed,
    Object? promotionalNotifications = freezed,
  }) {
    return _then(_value.copyWith(
      pushNotifications: null == pushNotifications
          ? _value.pushNotifications
          : pushNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      bookingReminders: freezed == bookingReminders
          ? _value.bookingReminders
          : bookingReminders // ignore: cast_nullable_to_non_nullable
              as bool?,
      promotionalNotifications: freezed == promotionalNotifications
          ? _value.promotionalNotifications
          : promotionalNotifications // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsRequestImplCopyWith<$Res>
    implements $NotificationSettingsRequestCopyWith<$Res> {
  factory _$$NotificationSettingsRequestImplCopyWith(
          _$NotificationSettingsRequestImpl value,
          $Res Function(_$NotificationSettingsRequestImpl) then) =
      __$$NotificationSettingsRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'push_notifications') bool pushNotifications,
      @JsonKey(name: 'booking_reminders') bool? bookingReminders,
      @JsonKey(name: 'promotional_notifications')
      bool? promotionalNotifications});
}

/// @nodoc
class __$$NotificationSettingsRequestImplCopyWithImpl<$Res>
    extends _$NotificationSettingsRequestCopyWithImpl<$Res,
        _$NotificationSettingsRequestImpl>
    implements _$$NotificationSettingsRequestImplCopyWith<$Res> {
  __$$NotificationSettingsRequestImplCopyWithImpl(
      _$NotificationSettingsRequestImpl _value,
      $Res Function(_$NotificationSettingsRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushNotifications = null,
    Object? bookingReminders = freezed,
    Object? promotionalNotifications = freezed,
  }) {
    return _then(_$NotificationSettingsRequestImpl(
      pushNotifications: null == pushNotifications
          ? _value.pushNotifications
          : pushNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      bookingReminders: freezed == bookingReminders
          ? _value.bookingReminders
          : bookingReminders // ignore: cast_nullable_to_non_nullable
              as bool?,
      promotionalNotifications: freezed == promotionalNotifications
          ? _value.promotionalNotifications
          : promotionalNotifications // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsRequestImpl
    implements _NotificationSettingsRequest {
  const _$NotificationSettingsRequestImpl(
      {@JsonKey(name: 'push_notifications') required this.pushNotifications,
      @JsonKey(name: 'booking_reminders') this.bookingReminders,
      @JsonKey(name: 'promotional_notifications')
      this.promotionalNotifications});

  factory _$NotificationSettingsRequestImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationSettingsRequestImplFromJson(json);

  @override
  @JsonKey(name: 'push_notifications')
  final bool pushNotifications;
  @override
  @JsonKey(name: 'booking_reminders')
  final bool? bookingReminders;
  @override
  @JsonKey(name: 'promotional_notifications')
  final bool? promotionalNotifications;

  @override
  String toString() {
    return 'NotificationSettingsRequest(pushNotifications: $pushNotifications, bookingReminders: $bookingReminders, promotionalNotifications: $promotionalNotifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsRequestImpl &&
            (identical(other.pushNotifications, pushNotifications) ||
                other.pushNotifications == pushNotifications) &&
            (identical(other.bookingReminders, bookingReminders) ||
                other.bookingReminders == bookingReminders) &&
            (identical(
                    other.promotionalNotifications, promotionalNotifications) ||
                other.promotionalNotifications == promotionalNotifications));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, pushNotifications,
      bookingReminders, promotionalNotifications);

  /// Create a copy of NotificationSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsRequestImplCopyWith<_$NotificationSettingsRequestImpl>
      get copyWith => __$$NotificationSettingsRequestImplCopyWithImpl<
          _$NotificationSettingsRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsRequestImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingsRequest
    implements NotificationSettingsRequest {
  const factory _NotificationSettingsRequest(
          {@JsonKey(name: 'push_notifications')
          required final bool pushNotifications,
          @JsonKey(name: 'booking_reminders') final bool? bookingReminders,
          @JsonKey(name: 'promotional_notifications')
          final bool? promotionalNotifications}) =
      _$NotificationSettingsRequestImpl;

  factory _NotificationSettingsRequest.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsRequestImpl.fromJson;

  @override
  @JsonKey(name: 'push_notifications')
  bool get pushNotifications;
  @override
  @JsonKey(name: 'booking_reminders')
  bool? get bookingReminders;
  @override
  @JsonKey(name: 'promotional_notifications')
  bool? get promotionalNotifications;

  /// Create a copy of NotificationSettingsRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsRequestImplCopyWith<_$NotificationSettingsRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
