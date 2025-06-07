// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NotificationResponse _$NotificationResponseFromJson(Map<String, dynamic> json) {
  return _NotificationResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationResponse {
  @JsonKey(name: 'status')
  String get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'message')
  String get message => throw _privateConstructorUsedError;

  /// Serializes this NotificationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationResponseCopyWith<NotificationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationResponseCopyWith<$Res> {
  factory $NotificationResponseCopyWith(NotificationResponse value,
          $Res Function(NotificationResponse) then) =
      _$NotificationResponseCopyWithImpl<$Res, NotificationResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'status') String status,
      @JsonKey(name: 'message') String message});
}

/// @nodoc
class _$NotificationResponseCopyWithImpl<$Res,
        $Val extends NotificationResponse>
    implements $NotificationResponseCopyWith<$Res> {
  _$NotificationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationResponseImplCopyWith<$Res>
    implements $NotificationResponseCopyWith<$Res> {
  factory _$$NotificationResponseImplCopyWith(_$NotificationResponseImpl value,
          $Res Function(_$NotificationResponseImpl) then) =
      __$$NotificationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'status') String status,
      @JsonKey(name: 'message') String message});
}

/// @nodoc
class __$$NotificationResponseImplCopyWithImpl<$Res>
    extends _$NotificationResponseCopyWithImpl<$Res, _$NotificationResponseImpl>
    implements _$$NotificationResponseImplCopyWith<$Res> {
  __$$NotificationResponseImplCopyWithImpl(_$NotificationResponseImpl _value,
      $Res Function(_$NotificationResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? message = null,
  }) {
    return _then(_$NotificationResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationResponseImpl implements _NotificationResponse {
  const _$NotificationResponseImpl(
      {@JsonKey(name: 'status') required this.status,
      @JsonKey(name: 'message') required this.message});

  factory _$NotificationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationResponseImplFromJson(json);

  @override
  @JsonKey(name: 'status')
  final String status;
  @override
  @JsonKey(name: 'message')
  final String message;

  @override
  String toString() {
    return 'NotificationResponse(status: $status, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, message);

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationResponseImplCopyWith<_$NotificationResponseImpl>
      get copyWith =>
          __$$NotificationResponseImplCopyWithImpl<_$NotificationResponseImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationResponseImplToJson(
      this,
    );
  }
}

abstract class _NotificationResponse implements NotificationResponse {
  const factory _NotificationResponse(
          {@JsonKey(name: 'status') required final String status,
          @JsonKey(name: 'message') required final String message}) =
      _$NotificationResponseImpl;

  factory _NotificationResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationResponseImpl.fromJson;

  @override
  @JsonKey(name: 'status')
  String get status;
  @override
  @JsonKey(name: 'message')
  String get message;

  /// Create a copy of NotificationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationResponseImplCopyWith<_$NotificationResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationSettingsResponse _$NotificationSettingsResponseFromJson(
    Map<String, dynamic> json) {
  return _NotificationSettingsResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationSettingsResponse {
  @JsonKey(name: 'push_notifications')
  bool get pushNotifications => throw _privateConstructorUsedError;
  @JsonKey(name: 'booking_reminders')
  bool get bookingReminders => throw _privateConstructorUsedError;
  @JsonKey(name: 'promotional_notifications')
  bool get promotionalNotifications => throw _privateConstructorUsedError;

  /// Serializes this NotificationSettingsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationSettingsResponseCopyWith<NotificationSettingsResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationSettingsResponseCopyWith<$Res> {
  factory $NotificationSettingsResponseCopyWith(
          NotificationSettingsResponse value,
          $Res Function(NotificationSettingsResponse) then) =
      _$NotificationSettingsResponseCopyWithImpl<$Res,
          NotificationSettingsResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'push_notifications') bool pushNotifications,
      @JsonKey(name: 'booking_reminders') bool bookingReminders,
      @JsonKey(name: 'promotional_notifications')
      bool promotionalNotifications});
}

/// @nodoc
class _$NotificationSettingsResponseCopyWithImpl<$Res,
        $Val extends NotificationSettingsResponse>
    implements $NotificationSettingsResponseCopyWith<$Res> {
  _$NotificationSettingsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushNotifications = null,
    Object? bookingReminders = null,
    Object? promotionalNotifications = null,
  }) {
    return _then(_value.copyWith(
      pushNotifications: null == pushNotifications
          ? _value.pushNotifications
          : pushNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      bookingReminders: null == bookingReminders
          ? _value.bookingReminders
          : bookingReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      promotionalNotifications: null == promotionalNotifications
          ? _value.promotionalNotifications
          : promotionalNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationSettingsResponseImplCopyWith<$Res>
    implements $NotificationSettingsResponseCopyWith<$Res> {
  factory _$$NotificationSettingsResponseImplCopyWith(
          _$NotificationSettingsResponseImpl value,
          $Res Function(_$NotificationSettingsResponseImpl) then) =
      __$$NotificationSettingsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'push_notifications') bool pushNotifications,
      @JsonKey(name: 'booking_reminders') bool bookingReminders,
      @JsonKey(name: 'promotional_notifications')
      bool promotionalNotifications});
}

/// @nodoc
class __$$NotificationSettingsResponseImplCopyWithImpl<$Res>
    extends _$NotificationSettingsResponseCopyWithImpl<$Res,
        _$NotificationSettingsResponseImpl>
    implements _$$NotificationSettingsResponseImplCopyWith<$Res> {
  __$$NotificationSettingsResponseImplCopyWithImpl(
      _$NotificationSettingsResponseImpl _value,
      $Res Function(_$NotificationSettingsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pushNotifications = null,
    Object? bookingReminders = null,
    Object? promotionalNotifications = null,
  }) {
    return _then(_$NotificationSettingsResponseImpl(
      pushNotifications: null == pushNotifications
          ? _value.pushNotifications
          : pushNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
      bookingReminders: null == bookingReminders
          ? _value.bookingReminders
          : bookingReminders // ignore: cast_nullable_to_non_nullable
              as bool,
      promotionalNotifications: null == promotionalNotifications
          ? _value.promotionalNotifications
          : promotionalNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationSettingsResponseImpl
    implements _NotificationSettingsResponse {
  const _$NotificationSettingsResponseImpl(
      {@JsonKey(name: 'push_notifications') required this.pushNotifications,
      @JsonKey(name: 'booking_reminders') required this.bookingReminders,
      @JsonKey(name: 'promotional_notifications')
      required this.promotionalNotifications});

  factory _$NotificationSettingsResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationSettingsResponseImplFromJson(json);

  @override
  @JsonKey(name: 'push_notifications')
  final bool pushNotifications;
  @override
  @JsonKey(name: 'booking_reminders')
  final bool bookingReminders;
  @override
  @JsonKey(name: 'promotional_notifications')
  final bool promotionalNotifications;

  @override
  String toString() {
    return 'NotificationSettingsResponse(pushNotifications: $pushNotifications, bookingReminders: $bookingReminders, promotionalNotifications: $promotionalNotifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationSettingsResponseImpl &&
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

  /// Create a copy of NotificationSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationSettingsResponseImplCopyWith<
          _$NotificationSettingsResponseImpl>
      get copyWith => __$$NotificationSettingsResponseImplCopyWithImpl<
          _$NotificationSettingsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationSettingsResponseImplToJson(
      this,
    );
  }
}

abstract class _NotificationSettingsResponse
    implements NotificationSettingsResponse {
  const factory _NotificationSettingsResponse(
      {@JsonKey(name: 'push_notifications')
      required final bool pushNotifications,
      @JsonKey(name: 'booking_reminders') required final bool bookingReminders,
      @JsonKey(name: 'promotional_notifications')
      required final bool
          promotionalNotifications}) = _$NotificationSettingsResponseImpl;

  factory _NotificationSettingsResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationSettingsResponseImpl.fromJson;

  @override
  @JsonKey(name: 'push_notifications')
  bool get pushNotifications;
  @override
  @JsonKey(name: 'booking_reminders')
  bool get bookingReminders;
  @override
  @JsonKey(name: 'promotional_notifications')
  bool get promotionalNotifications;

  /// Create a copy of NotificationSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationSettingsResponseImplCopyWith<
          _$NotificationSettingsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationHistoryItem _$NotificationHistoryItemFromJson(
    Map<String, dynamic> json) {
  return _NotificationHistoryItem.fromJson(json);
}

/// @nodoc
mixin _$NotificationHistoryItem {
  @JsonKey(name: 'id')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'title')
  String get title => throw _privateConstructorUsedError;
  @JsonKey(name: 'body')
  String get body => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'data')
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  @JsonKey(name: 'read_at')
  String? get readAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;

  /// Serializes this NotificationHistoryItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationHistoryItemCopyWith<NotificationHistoryItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationHistoryItemCopyWith<$Res> {
  factory $NotificationHistoryItemCopyWith(NotificationHistoryItem value,
          $Res Function(NotificationHistoryItem) then) =
      _$NotificationHistoryItemCopyWithImpl<$Res, NotificationHistoryItem>;
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'body') String body,
      @JsonKey(name: 'type') String type,
      @JsonKey(name: 'data') Map<String, dynamic>? data,
      @JsonKey(name: 'read_at') String? readAt,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class _$NotificationHistoryItemCopyWithImpl<$Res,
        $Val extends NotificationHistoryItem>
    implements $NotificationHistoryItemCopyWith<$Res> {
  _$NotificationHistoryItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? data = freezed,
    Object? readAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationHistoryItemImplCopyWith<$Res>
    implements $NotificationHistoryItemCopyWith<$Res> {
  factory _$$NotificationHistoryItemImplCopyWith(
          _$NotificationHistoryItemImpl value,
          $Res Function(_$NotificationHistoryItemImpl) then) =
      __$$NotificationHistoryItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'id') int id,
      @JsonKey(name: 'title') String title,
      @JsonKey(name: 'body') String body,
      @JsonKey(name: 'type') String type,
      @JsonKey(name: 'data') Map<String, dynamic>? data,
      @JsonKey(name: 'read_at') String? readAt,
      @JsonKey(name: 'created_at') String createdAt});
}

/// @nodoc
class __$$NotificationHistoryItemImplCopyWithImpl<$Res>
    extends _$NotificationHistoryItemCopyWithImpl<$Res,
        _$NotificationHistoryItemImpl>
    implements _$$NotificationHistoryItemImplCopyWith<$Res> {
  __$$NotificationHistoryItemImplCopyWithImpl(
      _$NotificationHistoryItemImpl _value,
      $Res Function(_$NotificationHistoryItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? body = null,
    Object? type = null,
    Object? data = freezed,
    Object? readAt = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$NotificationHistoryItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      body: null == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      readAt: freezed == readAt
          ? _value.readAt
          : readAt // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationHistoryItemImpl implements _NotificationHistoryItem {
  const _$NotificationHistoryItemImpl(
      {@JsonKey(name: 'id') required this.id,
      @JsonKey(name: 'title') required this.title,
      @JsonKey(name: 'body') required this.body,
      @JsonKey(name: 'type') required this.type,
      @JsonKey(name: 'data') final Map<String, dynamic>? data,
      @JsonKey(name: 'read_at') this.readAt,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _data = data;

  factory _$NotificationHistoryItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$NotificationHistoryItemImplFromJson(json);

  @override
  @JsonKey(name: 'id')
  final int id;
  @override
  @JsonKey(name: 'title')
  final String title;
  @override
  @JsonKey(name: 'body')
  final String body;
  @override
  @JsonKey(name: 'type')
  final String type;
  final Map<String, dynamic>? _data;
  @override
  @JsonKey(name: 'data')
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  @JsonKey(name: 'read_at')
  final String? readAt;
  @override
  @JsonKey(name: 'created_at')
  final String createdAt;

  @override
  String toString() {
    return 'NotificationHistoryItem(id: $id, title: $title, body: $body, type: $type, data: $data, readAt: $readAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationHistoryItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.readAt, readAt) || other.readAt == readAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, title, body, type,
      const DeepCollectionEquality().hash(_data), readAt, createdAt);

  /// Create a copy of NotificationHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationHistoryItemImplCopyWith<_$NotificationHistoryItemImpl>
      get copyWith => __$$NotificationHistoryItemImplCopyWithImpl<
          _$NotificationHistoryItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationHistoryItemImplToJson(
      this,
    );
  }
}

abstract class _NotificationHistoryItem implements NotificationHistoryItem {
  const factory _NotificationHistoryItem(
          {@JsonKey(name: 'id') required final int id,
          @JsonKey(name: 'title') required final String title,
          @JsonKey(name: 'body') required final String body,
          @JsonKey(name: 'type') required final String type,
          @JsonKey(name: 'data') final Map<String, dynamic>? data,
          @JsonKey(name: 'read_at') final String? readAt,
          @JsonKey(name: 'created_at') required final String createdAt}) =
      _$NotificationHistoryItemImpl;

  factory _NotificationHistoryItem.fromJson(Map<String, dynamic> json) =
      _$NotificationHistoryItemImpl.fromJson;

  @override
  @JsonKey(name: 'id')
  int get id;
  @override
  @JsonKey(name: 'title')
  String get title;
  @override
  @JsonKey(name: 'body')
  String get body;
  @override
  @JsonKey(name: 'type')
  String get type;
  @override
  @JsonKey(name: 'data')
  Map<String, dynamic>? get data;
  @override
  @JsonKey(name: 'read_at')
  String? get readAt;
  @override
  @JsonKey(name: 'created_at')
  String get createdAt;

  /// Create a copy of NotificationHistoryItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationHistoryItemImplCopyWith<_$NotificationHistoryItemImpl>
      get copyWith => throw _privateConstructorUsedError;
}

NotificationHistoryResponse _$NotificationHistoryResponseFromJson(
    Map<String, dynamic> json) {
  return _NotificationHistoryResponse.fromJson(json);
}

/// @nodoc
mixin _$NotificationHistoryResponse {
  @JsonKey(name: 'notifications')
  List<NotificationHistoryItem> get notifications =>
      throw _privateConstructorUsedError;

  /// Serializes this NotificationHistoryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NotificationHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NotificationHistoryResponseCopyWith<NotificationHistoryResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationHistoryResponseCopyWith<$Res> {
  factory $NotificationHistoryResponseCopyWith(
          NotificationHistoryResponse value,
          $Res Function(NotificationHistoryResponse) then) =
      _$NotificationHistoryResponseCopyWithImpl<$Res,
          NotificationHistoryResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'notifications')
      List<NotificationHistoryItem> notifications});
}

/// @nodoc
class _$NotificationHistoryResponseCopyWithImpl<$Res,
        $Val extends NotificationHistoryResponse>
    implements $NotificationHistoryResponseCopyWith<$Res> {
  _$NotificationHistoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NotificationHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
  }) {
    return _then(_value.copyWith(
      notifications: null == notifications
          ? _value.notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<NotificationHistoryItem>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NotificationHistoryResponseImplCopyWith<$Res>
    implements $NotificationHistoryResponseCopyWith<$Res> {
  factory _$$NotificationHistoryResponseImplCopyWith(
          _$NotificationHistoryResponseImpl value,
          $Res Function(_$NotificationHistoryResponseImpl) then) =
      __$$NotificationHistoryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'notifications')
      List<NotificationHistoryItem> notifications});
}

/// @nodoc
class __$$NotificationHistoryResponseImplCopyWithImpl<$Res>
    extends _$NotificationHistoryResponseCopyWithImpl<$Res,
        _$NotificationHistoryResponseImpl>
    implements _$$NotificationHistoryResponseImplCopyWith<$Res> {
  __$$NotificationHistoryResponseImplCopyWithImpl(
      _$NotificationHistoryResponseImpl _value,
      $Res Function(_$NotificationHistoryResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of NotificationHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notifications = null,
  }) {
    return _then(_$NotificationHistoryResponseImpl(
      notifications: null == notifications
          ? _value._notifications
          : notifications // ignore: cast_nullable_to_non_nullable
              as List<NotificationHistoryItem>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NotificationHistoryResponseImpl
    implements _NotificationHistoryResponse {
  const _$NotificationHistoryResponseImpl(
      {@JsonKey(name: 'notifications')
      required final List<NotificationHistoryItem> notifications})
      : _notifications = notifications;

  factory _$NotificationHistoryResponseImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NotificationHistoryResponseImplFromJson(json);

  final List<NotificationHistoryItem> _notifications;
  @override
  @JsonKey(name: 'notifications')
  List<NotificationHistoryItem> get notifications {
    if (_notifications is EqualUnmodifiableListView) return _notifications;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notifications);
  }

  @override
  String toString() {
    return 'NotificationHistoryResponse(notifications: $notifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NotificationHistoryResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._notifications, _notifications));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_notifications));

  /// Create a copy of NotificationHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NotificationHistoryResponseImplCopyWith<_$NotificationHistoryResponseImpl>
      get copyWith => __$$NotificationHistoryResponseImplCopyWithImpl<
          _$NotificationHistoryResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NotificationHistoryResponseImplToJson(
      this,
    );
  }
}

abstract class _NotificationHistoryResponse
    implements NotificationHistoryResponse {
  const factory _NotificationHistoryResponse(
          {@JsonKey(name: 'notifications')
          required final List<NotificationHistoryItem> notifications}) =
      _$NotificationHistoryResponseImpl;

  factory _NotificationHistoryResponse.fromJson(Map<String, dynamic> json) =
      _$NotificationHistoryResponseImpl.fromJson;

  @override
  @JsonKey(name: 'notifications')
  List<NotificationHistoryItem> get notifications;

  /// Create a copy of NotificationHistoryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NotificationHistoryResponseImplCopyWith<_$NotificationHistoryResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
