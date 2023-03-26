import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:hear_sitter/src/core/utils/audio_util.dart';
import 'package:hear_sitter/src/models/audio_tagging_model.dart';
import 'package:hear_sitter/src/services/audio_tagging_service.dart';
import 'package:sound_stream/sound_stream.dart';

final recorderStreamProvider =
ChangeNotifierProvider((ref) => RecorderStreamNotifier(RecorderStream()));

class RecorderStreamNotifier extends ChangeNotifier {
  RecorderStreamNotifier(this._recorderStream) {
    openRecord();
  }

  bool recorderEnable = false;
  List<Uint8List> audioChunks = [];
  final RecorderStream _recorderStream;
  AudioTaggingModel _audioTaggingModel =
  const AudioTaggingModel(isAlert: false, label: '제발', taggingRate: 0);

  AudioTaggingModel get audioTaggingModel => _audioTaggingModel;

  Future<void> openRecord() async {
    _recorderStream.status.listen((status) async {
      var permissionStatus = await Permission.microphone.status;
      if (permissionStatus.isGranted) {
        recorderEnable = status == SoundStreamStatus.Playing;
        notifyListeners();
      }
      notifyListeners();
    });

    await Future.wait([_recorderStream.initialize()]);
    notifyListeners();
  }

  Stream<AudioTaggingModel> audioTaggingStream() async* {
    await for (final data in _recorderStream.audioStream) {
      audioChunks.add(data);
      if (audioChunks.length > 60) {
        audioChunks.removeAt(0);
      }
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
