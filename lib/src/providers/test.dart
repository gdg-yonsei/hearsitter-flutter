import 'dart:async';
import 'dart:typed_data';

import 'package:sound_stream/sound_stream.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

RecorderStream recorderStream = RecorderStream();

bool recorderEnable = false;
List<Uint8List> audioChunks = [];
StreamSubscription? audioStream;

Future<void> openRecord() async {
  recorderStream.status.listen((status) async {
    recorderEnable = status == SoundStreamStatus.Playing;
    // debugPrint(recorderEnable.toString() + '체크');
  });

  audioStream = recorderStream.audioStream.listen((data) {
    audioChunks.add(data);
    if (audioChunks.length > 60) {
      audioChunks.removeAt(0);
    }
  });

  await Future.wait([recorderStream.initialize()]);
}

final auidoTaggingApiProvider2 = Provider.autoDispose((ref) => recorderStream);
