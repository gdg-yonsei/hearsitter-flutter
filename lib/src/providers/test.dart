import 'dart:async';
import 'dart:typed_data';
import 'package:hear_sitter/src/core/core.dart';
import 'package:hear_sitter/src/models/audio_tagging_model.dart';
import 'package:hear_sitter/src/services/audio_tagging_service.dart';

import '../screens/home/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:sound_stream/sound_stream.dart';

final RecorderStream recorderStream = RecorderStream();
bool recorderEnable = false;
List<Uint8List> audioChunks = [];
StreamSubscription? audioStream;

Future<void> openRecord() async {
  recorderStream.status.listen((status) async {
    recorderEnable = status == SoundStreamStatus.Playing;
    debugPrint(recorderEnable.toString() + '체크');
  });

  audioStream = recorderStream.audioStream.listen((data) {
    audioChunks.add(data);
    if (audioChunks.length > 60) {
      audioChunks.removeAt(0);
    }
  });

  await Future.wait([recorderStream.initialize()]);
}

final recorderStreamProvider = Provider.autoDispose((ref) => recorderStream);

final audioTaggingApiProvider2 = StreamProvider.autoDispose((ref) async* {
  final isRecording = ref.watch(isRecordingProvider);
  final recorderStream = ref.watch(recorderStreamProvider);

  await for (final _ in recorderStream.audioStream) {
    Uint8List wav = AudioUtil.toWAV(audioChunks);
    AudioTaggingModel audioTaggingModel =
        await AudioTaggingServiceImpl().postAudio(wav);
    debugPrint(audioTaggingModel.toString());
    yield audioTaggingModel;
  }

  Future<void> startRecording() async {
    recorderStream.start();
    await AudioTaggingServiceImpl().getPong();
  }

  void stopRecording() {
    recorderStream.stop();
    audioChunks.clear();
  }

  if (isRecording) {
    startRecording();
  } else {
    stopRecording();
  }
});
