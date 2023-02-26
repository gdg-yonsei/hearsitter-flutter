import 'dart:async';
import 'dart:convert';

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:riverpod/riverpod.dart';
import 'package:see_our_sounds/audio_record.dart';
import 'package:see_our_sounds/src/domain/repositories/audio_tagging_repo.dart';
import 'package:sound_stream/sound_stream.dart';

class AudioTaggingRepoImpl implements AudioTaggingRepo {
  @override
  List<Uint8List> audioChunks = [];

  @override
  StreamSubscription? audioStream;

  @override
  bool isRecording = false;

  @override
  RecorderStream recorder = RecorderStream();

  @override
  StreamSubscription? recorderStatus;

  @override
  late Uint8List wav;

  @override
  Future<void> openRecord() async {
    recorderStatus = recorder.status.listen((status) async {
      var permissionStatus = await Permission.microphone.status;
      if (permissionStatus.isGranted) {
        recorder.start();
        isRecording = status == SoundStreamStatus.Playing;
      }
    });

    createAudioChunks();

    await Future.wait([
      recorder.initialize(),
    ]);
  }

  void createAudioChunks() {
    audioStream = recorder.audioStream.listen((data) {
      audioChunks.add(data);
      // 대략 약 4초씩
      if (audioChunks.length > 60) {
        audioChunks.removeAt(0);
      }
    });
  }

  @override
  Future<void> stopRecord() async {
    await recorder.stop();
    await recorderStatus?.cancel();
    await audioStream?.cancel();
    audioChunks.clear();
    isRecording = false;
  }

  @override
  Uint8List toWAV(List<Uint8List> audioChunks) {
    var data = audioChunks.expand((i) => i).toList();
    var channels = 1;
    int sampleRate = 16000;
    int byteRate = (16 * sampleRate * channels) ~/ 8;
    int totalAudioLen = data.length;
    int totalDataLen = totalAudioLen + 36;

    Uint8List header = Uint8List.fromList([
      ...utf8.encode('RIFF'),
      (totalDataLen & 0xff),
      ((totalDataLen >> 8) & 0xff),
      ((totalDataLen >> 16) & 0xff),
      ((totalDataLen >> 24) & 0xff),
      ...utf8.encode('WAVEfmt '),
      // 4 bytes: size of 'fmt ' chunk
      16, 0, 0, 0,
      // type of fmt
      1, 0, channels, 0,
      (sampleRate & 0xff),
      ((sampleRate >> 8) & 0xff),
      ((sampleRate >> 16) & 0xff),
      ((sampleRate >> 24) & 0xff),
      (byteRate & 0xff),
      ((byteRate >> 8) & 0xff),
      ((byteRate >> 16) & 0xff),
      ((byteRate >> 24) & 0xff),
      ((16 * channels) ~/ 8), // block align
      0, 16, 0, // bit size
      ...utf8.encode('data'),
      (totalAudioLen & 0xff),
      ((totalAudioLen >> 8) & 0xff),
      ((totalAudioLen >> 16) & 0xff),
      ((totalAudioLen >> 24) & 0xff),
      ...data
    ]);

    return header;
  }
}
