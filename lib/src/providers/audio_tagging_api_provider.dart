import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hear_sitter/src/core/utils/audio_util.dart';
import 'package:hear_sitter/src/models/audio_tagging_model.dart';
import 'package:hear_sitter/src/services/audio_tagging_service.dart';
import 'package:sound_stream/sound_stream.dart';

final audioTaggingApiProvider =
    ChangeNotifierProvider((ref) => AudioTaggingApiNotifier(RecorderStream()));

class AudioTaggingApiNotifier extends ChangeNotifier {
  AudioTaggingApiNotifier(this._recorderStream) {
    openRecord();
  }

  bool recorderEnable = false;
  List<Uint8List> audioChunks = [];
  StreamSubscription? audioStream;
  final RecorderStream _recorderStream;
  AudioTaggingModel _audioTaggingModel =
      const AudioTaggingModel(isAlert: false, label: '버전1', taggingRate: 0);

  AudioTaggingModel get audioTaggingModel => _audioTaggingModel;

  Future<void> openRecord() async {
    _recorderStream.status.listen((status) async {
      recorderEnable = status == SoundStreamStatus.Playing;
      // debugPrint(recorderEnable.toString() + '체크');
      notifyListeners();
    });

    audioStream = _recorderStream.audioStream.listen((data) {
      audioChunks.add(data);
      if (audioChunks.length > 60) {
        audioChunks.removeAt(0);
      }
    });

    await Future.wait([_recorderStream.initialize()]);
    notifyListeners();
  }

  Stream<AudioTaggingModel> audioTaggingStream() async* {
    await for (final _ in _recorderStream.audioStream) {
      Uint8List wav = AudioUtil.toWAV(audioChunks);
      _audioTaggingModel = await AudioTaggingServiceImpl().postAudio(wav);
      debugPrint(_audioTaggingModel.toString());
      yield _audioTaggingModel;
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> startRecording() async {
    _recorderStream.start();
    await AudioTaggingServiceImpl().getPong();
    notifyListeners();
  }

  void stopRecording() {
    _recorderStream.stop();
    audioChunks.clear();
    notifyListeners();
  }
}
