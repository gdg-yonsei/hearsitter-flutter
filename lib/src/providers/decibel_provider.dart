import 'dart:async';
import '../screens/home/home_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noise_meter/noise_meter.dart';

final NoiseMeter noiseMeter = NoiseMeter(onError);

void onError(Object error) {
  throw Exception(error.toString());
}

final noiseMeterProvider =
    Provider.autoDispose<NoiseMeter>((ref) => noiseMeter);

final decibelStreamProvider = StreamProvider.autoDispose((ref) async* {
  int currentDecibel = 0;
  List<int> decibelHistory = [];

  final isRecording = ref.watch(isRecordingProvider);
  final noiseMeter = ref.watch(noiseMeterProvider);
  await for (final noiseReading in noiseMeter.noiseStream) {
    currentDecibel = noiseReading.meanDecibel.round();
    if (currentDecibel > 120) {
      await Future.delayed(const Duration(seconds: 1));
      decibelHistory.add(120);
    } else {
      await Future.delayed(const Duration(seconds: 1));
      decibelHistory.add(currentDecibel);
    }

    if (decibelHistory.length > 60) {
      decibelHistory.removeAt(0);
    }

    if (isRecording) {
      yield [currentDecibel, decibelHistory];
    } else {
      currentDecibel = 0;
      decibelHistory = [];
      break;
    }
  }
});
