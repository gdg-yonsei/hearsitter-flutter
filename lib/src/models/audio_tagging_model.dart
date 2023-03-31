import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_tagging_model.freezed.dart';

part 'audio_tagging_model.g.dart';

@freezed
class AudioTaggingModel with _$AudioTaggingModel {
  const factory AudioTaggingModel({
    @Default(null) int? id,
    @JsonKey(name: 'Alarm') required bool isAlert,
    @JsonKey(name: 'Label') required String label,
    @JsonKey(name: 'Tagging_rate') required double taggingRate,
    @Default('') String date,
    @Default(0) int decibel,
  }) = _AudioTaggingModel;

  factory AudioTaggingModel.fromJson(Map<String, dynamic> json) =>
      _$AudioTaggingModelFromJson(json);
}
