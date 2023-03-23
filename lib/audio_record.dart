import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:noise_meter/noise_meter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:see_our_sounds/src/core/app_constants.dart';
import 'package:see_our_sounds/src/core/core.dart';
import 'package:see_our_sounds/src/core/notification/local_notification.dart';
import 'package:see_our_sounds/src/core/utils/audio_util.dart';
import 'package:see_our_sounds/src/models/audio_tagging_model.dart';
import 'package:see_our_sounds/src/screens/home/audio_waveform.dart';
import 'package:see_our_sounds/src/screens/home/decibel_history_chart.dart';
import 'package:sound_stream/sound_stream.dart';
import 'package:speech_to_text/speech_to_text.dart';

class AudioStream extends StatefulWidget {
  const AudioStream({Key? key}) : super(key: key);

  @override
  State<AudioStream> createState() => _AudioStreamState();
}

class _AudioStreamState extends State<AudioStream> {
  LocalNotification localNotification = LocalNotification();
  late SpeechToText speechToText;
  RecorderStream recorder = RecorderStream();
  late NoiseMeter noiseMeter;
  List<Uint8List> audioChunks = [];
  List<double> decibelHistory = [];
  bool isRecording = false;
  bool isSTTEnable = false;
  StreamSubscription<NoiseReading>? noiseSubscription;
  StreamSubscription? recorderStatus;
  StreamSubscription? audioStream;
  double confidence = 1.0;
  String text = '';
  double currentDecibel = 0;

  Future<void> openRecord() async {
    recorderStatus = recorder.status.listen((status) async {
      var permissionStatus = await Permission.microphone.status;
      if (mounted && permissionStatus.isGranted) {
        setState(() {
          isRecording = status == SoundStreamStatus.Playing;
        });
      }
    });

    audioStream = recorder.audioStream.listen((data) {
      audioChunks.add(data);
      if (audioChunks.length > 60) {
        audioChunks.removeAt(0);
      }
    });

    await Future.wait([recorder.initialize()]);
  }

  void onError(Object error) {
    isRecording = false;
    throw Exception(error.toString());
  }

  Future getPong() async {
    var request =
        http.Request('GET', Uri.parse(AppUri.uriBase + AppUri.uriPing));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Stream<AudioTaggingModel> audioTaggingStream() async* {
    await for (final _ in recorder.audioStream) {
      Uint8List wav = AudioUtil.toWAV(audioChunks);
      AudioTaggingModel audioTaggingModel = await postAudio(wav);
      yield audioTaggingModel;
    }
  }

  Future<AudioTaggingModel> postAudio(Uint8List data) async {
    final uri = Uri.parse(AppUri.uriBase + AppUri.uriUint);
    var response = await http.post(uri, body: data);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      return AudioTaggingModel.fromJson(responseBody);
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  void _listen() async {
    if (!isRecording) {
      bool available = await speechToText.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        speechToText.listen(
          onResult: (val) => setState(() {
            text = val.recognizedWords;
            print(text);
            if (val.hasConfidenceRating && val.confidence > 0) {
              confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      speechToText.stop();
    }
  }

  void onData(NoiseReading noiseReading) {
    setState(() {
      if (isRecording) {
        var decibel = noiseReading.meanDecibel;
        currentDecibel = decibel;
        if (decibel < 30) {
          decibelHistory.add(30);
        } else if (decibel > 110) {
          decibelHistory.add(110);
        } else {
          decibelHistory.add(decibel);
        }
        if (decibelHistory.length > 80) {
          decibelHistory.removeAt(0);
        }
      } else {
        currentDecibel = 0;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openRecord();
    audioTaggingStream();
    speechToText = SpeechToText();
    localNotification.initNotification();
    noiseMeter = NoiseMeter(onError);
    noiseSubscription = noiseMeter.noiseStream.listen(onData);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    recorderStatus?.cancel();
    audioStream?.cancel();
    recorder.stop();
    audioChunks.clear();
    noiseSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // SfRadialGauge(
          //   axes: <RadialAxis>[
          //     RadialAxis(
          //       minimum: 0,
          //       maximum: 100,
          //       ranges: <GaugeRange>[
          //         GaugeRange(startValue: 0, endValue: 50, color: Colors.green),
          //         GaugeRange(
          //             startValue: 50, endValue: 100, color: Colors.orange),
          //         GaugeRange(startValue: 100, endValue: 150, color: Colors.red)
          //       ],
          //       pointers: [
          //         NeedlePointer(
          //           value: 90, tailStyle: TailStyle(width: 0, length: 0), needleLength: 1,
          //         )
          //       ],
          //       annotations: [
          //         GaugeAnnotation(
          //           widget: Container(
          //             child: Text('90'),
          //           ),
          //           angle: 90,
          //           positionFactor: .5,
          //         )
          //       ],
          //     )
          //   ],
          // ),
          Text(currentDecibel.round().toString()),
          // DecibelHistoryChart(decibelHistory: decibelHistory),
          // AudioWaveform(decibelHistory: decibelHistory),
          StreamBuilder(
              stream: audioTaggingStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data!.isAlert.toString(),
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          snapshot.data!.label,
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          snapshot.data!.taggingRate.toString(),
                          style: TextStyle(fontSize: 30),
                        ),
                        Text(
                          snapshot.data!.date,
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  );
                }
                return Center(
                  child: const SizedBox(),
                );
              }),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(isRecording ? Icons.mic : Icons.mic_off),
        onPressed: () async {
          _listen();
          if (isRecording) {
            recorder.stop();
            audioChunks.clear();
          } else {
            recorder.start();
            getPong();
          }
          _listen();
        },
      ),
    );
  }
}
