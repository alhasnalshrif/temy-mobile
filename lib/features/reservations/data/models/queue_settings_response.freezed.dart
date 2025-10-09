// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'queue_settings_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

QueueSettingsResponse _$QueueSettingsResponseFromJson(
    Map<String, dynamic> json) {
  return _QueueSettingsResponse.fromJson(json);
}

/// @nodoc
mixin _$QueueSettingsResponse {
  String get status => throw _privateConstructorUsedError;
  QueueSettingsData get data => throw _privateConstructorUsedError;

  /// Serializes this QueueSettingsResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueSettingsResponseCopyWith<QueueSettingsResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueSettingsResponseCopyWith<$Res> {
  factory $QueueSettingsResponseCopyWith(QueueSettingsResponse value,
          $Res Function(QueueSettingsResponse) then) =
      _$QueueSettingsResponseCopyWithImpl<$Res, QueueSettingsResponse>;
  @useResult
  $Res call({String status, QueueSettingsData data});

  $QueueSettingsDataCopyWith<$Res> get data;
}

/// @nodoc
class _$QueueSettingsResponseCopyWithImpl<$Res,
        $Val extends QueueSettingsResponse>
    implements $QueueSettingsResponseCopyWith<$Res> {
  _$QueueSettingsResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as QueueSettingsData,
    ) as $Val);
  }

  /// Create a copy of QueueSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueSettingsDataCopyWith<$Res> get data {
    return $QueueSettingsDataCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueueSettingsResponseImplCopyWith<$Res>
    implements $QueueSettingsResponseCopyWith<$Res> {
  factory _$$QueueSettingsResponseImplCopyWith(
          _$QueueSettingsResponseImpl value,
          $Res Function(_$QueueSettingsResponseImpl) then) =
      __$$QueueSettingsResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, QueueSettingsData data});

  @override
  $QueueSettingsDataCopyWith<$Res> get data;
}

/// @nodoc
class __$$QueueSettingsResponseImplCopyWithImpl<$Res>
    extends _$QueueSettingsResponseCopyWithImpl<$Res,
        _$QueueSettingsResponseImpl>
    implements _$$QueueSettingsResponseImplCopyWith<$Res> {
  __$$QueueSettingsResponseImplCopyWithImpl(_$QueueSettingsResponseImpl _value,
      $Res Function(_$QueueSettingsResponseImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? data = null,
  }) {
    return _then(_$QueueSettingsResponseImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as QueueSettingsData,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueSettingsResponseImpl implements _QueueSettingsResponse {
  const _$QueueSettingsResponseImpl({required this.status, required this.data});

  factory _$QueueSettingsResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueSettingsResponseImplFromJson(json);

  @override
  final String status;
  @override
  final QueueSettingsData data;

  @override
  String toString() {
    return 'QueueSettingsResponse(status: $status, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSettingsResponseImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, status, data);

  /// Create a copy of QueueSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSettingsResponseImplCopyWith<_$QueueSettingsResponseImpl>
      get copyWith => __$$QueueSettingsResponseImplCopyWithImpl<
          _$QueueSettingsResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueSettingsResponseImplToJson(
      this,
    );
  }
}

abstract class _QueueSettingsResponse implements QueueSettingsResponse {
  const factory _QueueSettingsResponse(
      {required final String status,
      required final QueueSettingsData data}) = _$QueueSettingsResponseImpl;

  factory _QueueSettingsResponse.fromJson(Map<String, dynamic> json) =
      _$QueueSettingsResponseImpl.fromJson;

  @override
  String get status;
  @override
  QueueSettingsData get data;

  /// Create a copy of QueueSettingsResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSettingsResponseImplCopyWith<_$QueueSettingsResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}

QueueSettingsData _$QueueSettingsDataFromJson(Map<String, dynamic> json) {
  return _QueueSettingsData.fromJson(json);
}

/// @nodoc
mixin _$QueueSettingsData {
  @JsonKey(name: 'is_queue_mode')
  bool get isQueueMode => throw _privateConstructorUsedError;
  @JsonKey(name: 'queue_settings')
  QueueSettings get queueSettings => throw _privateConstructorUsedError;

  /// Serializes this QueueSettingsData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueSettingsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueSettingsDataCopyWith<QueueSettingsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueSettingsDataCopyWith<$Res> {
  factory $QueueSettingsDataCopyWith(
          QueueSettingsData value, $Res Function(QueueSettingsData) then) =
      _$QueueSettingsDataCopyWithImpl<$Res, QueueSettingsData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'is_queue_mode') bool isQueueMode,
      @JsonKey(name: 'queue_settings') QueueSettings queueSettings});

  $QueueSettingsCopyWith<$Res> get queueSettings;
}

/// @nodoc
class _$QueueSettingsDataCopyWithImpl<$Res, $Val extends QueueSettingsData>
    implements $QueueSettingsDataCopyWith<$Res> {
  _$QueueSettingsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueSettingsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isQueueMode = null,
    Object? queueSettings = null,
  }) {
    return _then(_value.copyWith(
      isQueueMode: null == isQueueMode
          ? _value.isQueueMode
          : isQueueMode // ignore: cast_nullable_to_non_nullable
              as bool,
      queueSettings: null == queueSettings
          ? _value.queueSettings
          : queueSettings // ignore: cast_nullable_to_non_nullable
              as QueueSettings,
    ) as $Val);
  }

  /// Create a copy of QueueSettingsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $QueueSettingsCopyWith<$Res> get queueSettings {
    return $QueueSettingsCopyWith<$Res>(_value.queueSettings, (value) {
      return _then(_value.copyWith(queueSettings: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$QueueSettingsDataImplCopyWith<$Res>
    implements $QueueSettingsDataCopyWith<$Res> {
  factory _$$QueueSettingsDataImplCopyWith(_$QueueSettingsDataImpl value,
          $Res Function(_$QueueSettingsDataImpl) then) =
      __$$QueueSettingsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'is_queue_mode') bool isQueueMode,
      @JsonKey(name: 'queue_settings') QueueSettings queueSettings});

  @override
  $QueueSettingsCopyWith<$Res> get queueSettings;
}

/// @nodoc
class __$$QueueSettingsDataImplCopyWithImpl<$Res>
    extends _$QueueSettingsDataCopyWithImpl<$Res, _$QueueSettingsDataImpl>
    implements _$$QueueSettingsDataImplCopyWith<$Res> {
  __$$QueueSettingsDataImplCopyWithImpl(_$QueueSettingsDataImpl _value,
      $Res Function(_$QueueSettingsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueSettingsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isQueueMode = null,
    Object? queueSettings = null,
  }) {
    return _then(_$QueueSettingsDataImpl(
      isQueueMode: null == isQueueMode
          ? _value.isQueueMode
          : isQueueMode // ignore: cast_nullable_to_non_nullable
              as bool,
      queueSettings: null == queueSettings
          ? _value.queueSettings
          : queueSettings // ignore: cast_nullable_to_non_nullable
              as QueueSettings,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueSettingsDataImpl implements _QueueSettingsData {
  const _$QueueSettingsDataImpl(
      {@JsonKey(name: 'is_queue_mode') required this.isQueueMode,
      @JsonKey(name: 'queue_settings') required this.queueSettings});

  factory _$QueueSettingsDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueSettingsDataImplFromJson(json);

  @override
  @JsonKey(name: 'is_queue_mode')
  final bool isQueueMode;
  @override
  @JsonKey(name: 'queue_settings')
  final QueueSettings queueSettings;

  @override
  String toString() {
    return 'QueueSettingsData(isQueueMode: $isQueueMode, queueSettings: $queueSettings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSettingsDataImpl &&
            (identical(other.isQueueMode, isQueueMode) ||
                other.isQueueMode == isQueueMode) &&
            (identical(other.queueSettings, queueSettings) ||
                other.queueSettings == queueSettings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, isQueueMode, queueSettings);

  /// Create a copy of QueueSettingsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSettingsDataImplCopyWith<_$QueueSettingsDataImpl> get copyWith =>
      __$$QueueSettingsDataImplCopyWithImpl<_$QueueSettingsDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueSettingsDataImplToJson(
      this,
    );
  }
}

abstract class _QueueSettingsData implements QueueSettingsData {
  const factory _QueueSettingsData(
      {@JsonKey(name: 'is_queue_mode') required final bool isQueueMode,
      @JsonKey(name: 'queue_settings')
      required final QueueSettings queueSettings}) = _$QueueSettingsDataImpl;

  factory _QueueSettingsData.fromJson(Map<String, dynamic> json) =
      _$QueueSettingsDataImpl.fromJson;

  @override
  @JsonKey(name: 'is_queue_mode')
  bool get isQueueMode;
  @override
  @JsonKey(name: 'queue_settings')
  QueueSettings get queueSettings;

  /// Create a copy of QueueSettingsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSettingsDataImplCopyWith<_$QueueSettingsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

QueueSettings _$QueueSettingsFromJson(Map<String, dynamic> json) {
  return _QueueSettings.fromJson(json);
}

/// @nodoc
mixin _$QueueSettings {
  @JsonKey(name: 'max_queue_size')
  int get maxQueueSize => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_service_time')
  int get estimatedServiceTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'auto_advance_queue')
  bool get autoAdvanceQueue => throw _privateConstructorUsedError;

  /// Serializes this QueueSettings to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of QueueSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $QueueSettingsCopyWith<QueueSettings> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $QueueSettingsCopyWith<$Res> {
  factory $QueueSettingsCopyWith(
          QueueSettings value, $Res Function(QueueSettings) then) =
      _$QueueSettingsCopyWithImpl<$Res, QueueSettings>;
  @useResult
  $Res call(
      {@JsonKey(name: 'max_queue_size') int maxQueueSize,
      @JsonKey(name: 'estimated_service_time') int estimatedServiceTime,
      @JsonKey(name: 'auto_advance_queue') bool autoAdvanceQueue});
}

/// @nodoc
class _$QueueSettingsCopyWithImpl<$Res, $Val extends QueueSettings>
    implements $QueueSettingsCopyWith<$Res> {
  _$QueueSettingsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of QueueSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxQueueSize = null,
    Object? estimatedServiceTime = null,
    Object? autoAdvanceQueue = null,
  }) {
    return _then(_value.copyWith(
      maxQueueSize: null == maxQueueSize
          ? _value.maxQueueSize
          : maxQueueSize // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedServiceTime: null == estimatedServiceTime
          ? _value.estimatedServiceTime
          : estimatedServiceTime // ignore: cast_nullable_to_non_nullable
              as int,
      autoAdvanceQueue: null == autoAdvanceQueue
          ? _value.autoAdvanceQueue
          : autoAdvanceQueue // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$QueueSettingsImplCopyWith<$Res>
    implements $QueueSettingsCopyWith<$Res> {
  factory _$$QueueSettingsImplCopyWith(
          _$QueueSettingsImpl value, $Res Function(_$QueueSettingsImpl) then) =
      __$$QueueSettingsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'max_queue_size') int maxQueueSize,
      @JsonKey(name: 'estimated_service_time') int estimatedServiceTime,
      @JsonKey(name: 'auto_advance_queue') bool autoAdvanceQueue});
}

/// @nodoc
class __$$QueueSettingsImplCopyWithImpl<$Res>
    extends _$QueueSettingsCopyWithImpl<$Res, _$QueueSettingsImpl>
    implements _$$QueueSettingsImplCopyWith<$Res> {
  __$$QueueSettingsImplCopyWithImpl(
      _$QueueSettingsImpl _value, $Res Function(_$QueueSettingsImpl) _then)
      : super(_value, _then);

  /// Create a copy of QueueSettings
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxQueueSize = null,
    Object? estimatedServiceTime = null,
    Object? autoAdvanceQueue = null,
  }) {
    return _then(_$QueueSettingsImpl(
      maxQueueSize: null == maxQueueSize
          ? _value.maxQueueSize
          : maxQueueSize // ignore: cast_nullable_to_non_nullable
              as int,
      estimatedServiceTime: null == estimatedServiceTime
          ? _value.estimatedServiceTime
          : estimatedServiceTime // ignore: cast_nullable_to_non_nullable
              as int,
      autoAdvanceQueue: null == autoAdvanceQueue
          ? _value.autoAdvanceQueue
          : autoAdvanceQueue // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$QueueSettingsImpl implements _QueueSettings {
  const _$QueueSettingsImpl(
      {@JsonKey(name: 'max_queue_size') required this.maxQueueSize,
      @JsonKey(name: 'estimated_service_time')
      required this.estimatedServiceTime,
      @JsonKey(name: 'auto_advance_queue') required this.autoAdvanceQueue});

  factory _$QueueSettingsImpl.fromJson(Map<String, dynamic> json) =>
      _$$QueueSettingsImplFromJson(json);

  @override
  @JsonKey(name: 'max_queue_size')
  final int maxQueueSize;
  @override
  @JsonKey(name: 'estimated_service_time')
  final int estimatedServiceTime;
  @override
  @JsonKey(name: 'auto_advance_queue')
  final bool autoAdvanceQueue;

  @override
  String toString() {
    return 'QueueSettings(maxQueueSize: $maxQueueSize, estimatedServiceTime: $estimatedServiceTime, autoAdvanceQueue: $autoAdvanceQueue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$QueueSettingsImpl &&
            (identical(other.maxQueueSize, maxQueueSize) ||
                other.maxQueueSize == maxQueueSize) &&
            (identical(other.estimatedServiceTime, estimatedServiceTime) ||
                other.estimatedServiceTime == estimatedServiceTime) &&
            (identical(other.autoAdvanceQueue, autoAdvanceQueue) ||
                other.autoAdvanceQueue == autoAdvanceQueue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, maxQueueSize, estimatedServiceTime, autoAdvanceQueue);

  /// Create a copy of QueueSettings
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$QueueSettingsImplCopyWith<_$QueueSettingsImpl> get copyWith =>
      __$$QueueSettingsImplCopyWithImpl<_$QueueSettingsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$QueueSettingsImplToJson(
      this,
    );
  }
}

abstract class _QueueSettings implements QueueSettings {
  const factory _QueueSettings(
      {@JsonKey(name: 'max_queue_size') required final int maxQueueSize,
      @JsonKey(name: 'estimated_service_time')
      required final int estimatedServiceTime,
      @JsonKey(name: 'auto_advance_queue')
      required final bool autoAdvanceQueue}) = _$QueueSettingsImpl;

  factory _QueueSettings.fromJson(Map<String, dynamic> json) =
      _$QueueSettingsImpl.fromJson;

  @override
  @JsonKey(name: 'max_queue_size')
  int get maxQueueSize;
  @override
  @JsonKey(name: 'estimated_service_time')
  int get estimatedServiceTime;
  @override
  @JsonKey(name: 'auto_advance_queue')
  bool get autoAdvanceQueue;

  /// Create a copy of QueueSettings
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$QueueSettingsImplCopyWith<_$QueueSettingsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
