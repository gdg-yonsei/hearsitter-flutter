// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_tagging_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AudioTaggingModel _$$_AudioTaggingModelFromJson(Map<String, dynamic> json) =>
    _$_AudioTaggingModel(
      isAlert: json['Alarm'] as bool,
      label: json['Label'] as String,
      taggingRate: (json['Tagging_rate'] as num).toDouble(),
    );

Map<String, dynamic> _$$_AudioTaggingModelToJson(
        _$_AudioTaggingModel instance) =>
    <String, dynamic>{
      'Alarm': instance.isAlert,
      'Label': instance.label,
      'Tagging_rate': instance.taggingRate,
    };
