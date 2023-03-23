import 'package:audio_wave/audio_wave.dart';
import 'package:flutter/material.dart';
import 'package:see_our_sounds/src/core/app_constants.dart';

class AudioWaveform extends StatelessWidget {
  final List<double> decibelHistory;

  const AudioWaveform({Key? key, required this.decibelHistory})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return decibelHistory.isNotEmpty
        ? AudioWave(
            height: 160,
            width: size.width * .9,
            spacing: decibelHistory.length > 10 ? 2.5 : 20,
            animationLoop: 1,
            beatRate: const Duration(milliseconds: 30),
            bars: List.generate(
                decibelHistory.length,
                (index) => AudioWaveBar(
                    heightFactor: decibelHistory[index] * 0.005,
                    color: AppColor.primaryColor)),
          )
        : const SizedBox();
  }
}
