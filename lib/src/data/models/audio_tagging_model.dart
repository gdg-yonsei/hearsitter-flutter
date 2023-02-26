import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_tagging_model.freezed.dart';

part 'audio_tagging_model.g.dart';

@freezed
class AudioTaggingModel with _$AudioTaggingModel {
  const factory AudioTaggingModel({
    @JsonKey(name: 'Alarm') required bool isAlert,
    @JsonKey(name: 'Label') required String label,
    @JsonKey(name: 'Tagging_rate') required double taggingRate,
  }) = _AudioTaggingModel;

  factory AudioTaggingModel.fromJson(Map<String, dynamic> json) =>
      _$AudioTaggingModelFromJson(json);
}

// label: json['Label'], taggingRate: json['Tagging_rate']);
// List<Object?> get props => [label, taggingRate];
