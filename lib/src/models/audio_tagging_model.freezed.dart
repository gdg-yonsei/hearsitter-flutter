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
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'Alarm')
  bool get isAlert => throw _privateConstructorUsedError;
  @JsonKey(name: 'Label')
  String get label => throw _privateConstructorUsedError;
  @JsonKey(name: 'Tagging_rate')
  double get taggingRate => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  int get decibel => throw _privateConstructorUsedError;

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
      {int? id,
      @JsonKey(name: 'Alarm') bool isAlert,
      @JsonKey(name: 'Label') String label,
      @JsonKey(name: 'Tagging_rate') double taggingRate,
      String date,
      int decibel});
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
    Object? id = freezed,
    Object? isAlert = null,
    Object? label = null,
    Object? taggingRate = null,
    Object? date = null,
    Object? decibel = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      decibel: null == decibel
          ? _value.decibel
          : decibel // ignore: cast_nullable_to_non_nullable
              as int,
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
      {int? id,
      @JsonKey(name: 'Alarm') bool isAlert,
      @JsonKey(name: 'Label') String label,
      @JsonKey(name: 'Tagging_rate') double taggingRate,
      String date,
      int decibel});
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
    Object? id = freezed,
    Object? isAlert = null,
    Object? label = null,
    Object? taggingRate = null,
    Object? date = null,
    Object? decibel = null,
  }) {
    return _then(_$_AudioTaggingModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      decibel: null == decibel
          ? _value.decibel
          : decibel // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AudioTaggingModel implements _AudioTaggingModel {
  const _$_AudioTaggingModel(
      {this.id = null,
      @JsonKey(name: 'Alarm') required this.isAlert,
      @JsonKey(name: 'Label') required this.label,
      @JsonKey(name: 'Tagging_rate') required this.taggingRate,
      this.date = '',
      this.decibel = 0});

  factory _$_AudioTaggingModel.fromJson(Map<String, dynamic> json) =>
      _$$_AudioTaggingModelFromJson(json);

  @override
  @JsonKey()
  final int? id;
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
  @JsonKey()
  final String date;
  @override
  @JsonKey()
  final int decibel;

  @override
  String toString() {
    return 'AudioTaggingModel(id: $id, isAlert: $isAlert, label: $label, taggingRate: $taggingRate, date: $date, decibel: $decibel)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AudioTaggingModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.isAlert, isAlert) || other.isAlert == isAlert) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.taggingRate, taggingRate) ||
                other.taggingRate == taggingRate) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.decibel, decibel) || other.decibel == decibel));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, isAlert, label, taggingRate, date, decibel);

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
      {final int? id,
      @JsonKey(name: 'Alarm') required final bool isAlert,
      @JsonKey(name: 'Label') required final String label,
      @JsonKey(name: 'Tagging_rate') required final double taggingRate,
      final String date,
      final int decibel}) = _$_AudioTaggingModel;

  factory _AudioTaggingModel.fromJson(Map<String, dynamic> json) =
      _$_AudioTaggingModel.fromJson;

  @override
  int? get id;
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
  String get date;
  @override
  int get decibel;
  @override
  @JsonKey(ignore: true)
  _$$_AudioTaggingModelCopyWith<_$_AudioTaggingModel> get copyWith =>
      throw _privateConstructorUsedError;
}
