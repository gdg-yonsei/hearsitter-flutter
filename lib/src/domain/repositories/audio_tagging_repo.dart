import 'dart:async';
import 'dart:typed_data';

import 'package:sound_stream/sound_stream.dart';

abstract class AudioTaggingRepo{
  late RecorderStream recorder;
  StreamSubscription? recorderStatus;
  StreamSubscription? audioStream;
  late bool isRecording;
  late List<Uint8List> audioChunks;
  late Uint8List wav;

  Uint8List toWAV(List<Uint8List> audioChunks);
  Future<void> openRecord();
  Future<void> stopRecord();
}