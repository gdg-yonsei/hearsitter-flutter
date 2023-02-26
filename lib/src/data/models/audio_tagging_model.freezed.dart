// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_tagging_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AudioTaggingModel _$AudioTaggingModelFromJson(Map<String, dynamic> json) {
  return _AudioTaggingModel.fromJson(json);
}

/// @nodoc
mixin _$AudioTaggingModel {
  @JsonKey(name: 'Alarm')
  bool get isAlert => throw _privateConstructorUsedError;
  @JsonKey(name: 'Label')
  String get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'Tagging_rate')
  double get taggingRate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AudioTaggingModelCopyWith<AudioTaggingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioTaggingModelCopyWith<$Res> {
  factory $AudioTaggingModelCopyWith(
          AudioTaggingModel value, $Res Function(AudioTaggingModel) then) =
      _$AudioTaggingModelCopyWithImpl<$Res, AudioTaggingModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'Alarm') bool isAlert,
      @JsonKey(name: 'Label') String label,
      @JsonKey(name: 'Tagging_rate') double taggingRate});
}

/// @nodoc
class _$AudioTaggingModelCopyWithImpl<$Res, $Val extends AudioTaggingModel>
    implements $AudioTaggingModelCopyWith<$Res> {
  _$AudioTaggingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAlert = null,
    Object? label = null,
    Object? taggingRate = null,
  }) {
    return _then(_value.copyWith(
      isAlert: null == isAlert
          ? _value.isAlert
          : isAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      taggingRate: null == taggingRate
          ? _value.taggingRate
          : taggingRate // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AudioTaggingModelCopyWith<$Res>
    implements $AudioTaggingModelCopyWith<$Res> {
  factory _$$_AudioTaggingModelCopyWith(_$_AudioTaggingModel value,
          $Res Function(_$_AudioTaggingModel) then) =
      __$$_AudioTaggingModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'Alarm') bool isAlert,
      @JsonKey(name: 'Label') String label,
      @JsonKey(name: 'Tagging_rate') double taggingRate});
}

/// @nodoc
class __$$_AudioTaggingModelCopyWithImpl<$Res>
    extends _$AudioTaggingModelCopyWithImpl<$Res, _$_AudioTaggingModel>
    implements _$$_AudioTaggingModelCopyWith<$Res> {
  __$$_AudioTaggingModelCopyWithImpl(
      _$_AudioTaggingModel _value, $Res Function(_$_AudioTaggingModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isAlert = null,
    Object? label = null,
    Object? taggingRate = null,
  }) {
    return _then(_$_AudioTaggingModel(
      isAlert: null == isAlert
          ? _value.isAlert
          : isAlert // ignore: cast_nullable_to_non_nullable
              as bool,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
      taggingRate: null == taggingRate
          ? _value.taggingRate
          : taggingRate // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AudioTaggingModel implements _AudioTaggingModel {
  const _$_AudioTaggingModel(
      {@JsonKey(name: 'Alarm') required this.isAlert,
      @JsonKey(name: 'Label') required this.label,
      @JsonKey(name: 'Tagging_rate') required this.taggingRate});

  factory _$_AudioTaggingModel.fromJson(Map<String, dynamic> json) =>
      _$$_AudioTaggingModelFromJson(json);

  @override
  @JsonKey(name: 'Alarm')
  final bool isAlert;
  @override
  @JsonKey(name: 'Label')
  final String label;
  @override
  @JsonKey(name: 'Tagging_rate')
  final double taggingRate;

  @override
  String toString() {
    return 'AudioTaggingModel(isAlert: $isAlert, label: $label, taggingRate: $taggingRate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AudioTaggingModel &&
            (identical(other.isAlert, isAlert) || other.isAlert == isAlert) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.taggingRate, taggingRate) ||
                other.taggingRate == taggingRate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, isAlert, label, taggingRate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AudioTaggingModelCopyWith<_$_AudioTaggingModel> get copyWith =>
      __$$_AudioTaggingModelCopyWithImpl<_$_AudioTaggingModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AudioTaggingModelToJson(
      this,
    );
  }
}

abstract class _AudioTaggingModel implements AudioTaggingModel {
  const factory _AudioTaggingModel(
          {@JsonKey(name: 'Alarm') required final bool isAlert,
          @JsonKey(name: 'Label') required final String label,
          @JsonKey(name: 'Tagging_rate') required final double taggingRate}) =
      _$_AudioTaggingModel;

  factory _AudioTaggingModel.fromJson(Map<String, dynamic> json) =
      _$_AudioTaggingModel.fromJson;

  @override
  @JsonKey(name: 'Alarm')
  bool get isAlert;
  @override
  @JsonKey(name: 'Label')
  String get label;
  @override
  @JsonKey(name: 'Tagging_rate')
  double get taggingRate;
  @override
  @JsonKey(ignore: true)
  _$$_AudioTaggingModelCopyWith<_$_AudioTaggingModel> get copyWith =>
      throw _privateConstructorUsedError;
}
