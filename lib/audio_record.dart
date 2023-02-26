import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:see_our_sounds/src/config/app_constants.dart';
import 'package:see_our_sounds/src/core/core.dart';
import 'package:see_our_sounds/src/data/models/audio_tagging_model.dart';
import 'package:see_our_sounds/src/data/repositories/audio_tagging_repo_impl.dart';
import 'package:see_our_sounds/src/data/services/remote/audio_tagging_service.dart';
import 'package:see_our_sounds/src/domain/repositories/audio_tagging_repo.dart';
import 'package:see_our_sounds/src/screen/provider/audio_tagging_provider.dart';
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
  List<Uint8List> audioChunks = [];
  bool isRecording = false;
  bool isSTTEnable = false;
  StreamSubscription? recorderStatus;
  StreamSubscription? audioStream;
  double confidence = 1.0;
  String text = '';

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

  Future getPong() async {
    var request = http.Request('GET', Uri.parse(uriBase + uriPing));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Stream<AudioTaggingModel> audioTagging() async* {
    final audioStreamController = StreamController<DateTime>();
    Timer? timer;
    StreamSubscription<DateTime>? audioStreamSubscription;

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      audioStreamController.add(DateTime.now());
    });

    audioStreamSubscription =
        audioStreamController.stream.listen((event) async {
      if (!isRecording) {
        timer?.cancel();
        await audioStreamController.close();
        await audioStreamSubscription?.cancel();
      } else {
        Uint8List wav = toWAV(audioChunks);
        AudioTaggingModel audioTaggingModel = await postAudio(wav);
      }
    });
  }

  Stream<AudioTaggingModel> audioTaggingStream() async* {
    await for (final value in recorder.audioStream) {
      print('확인 : $value');
      Uint8List wav = toWAV(audioChunks);
      AudioTaggingModel audioTaggingModel = await postAudio(wav);
      yield audioTaggingModel;
    }
  }

  Future<AudioTaggingModel> postAudio(Uint8List data) async {
    final uri = Uri.parse(uriBase + uriUint);
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openRecord();
    audioTaggingStream();
    speechToText = SpeechToText();
    localNotification.initNotification();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    recorderStatus?.cancel();
    audioStream?.cancel();
    recorder.stop();
    audioChunks.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: audioTaggingStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(speechToText.isListening
                        ? text
                        : isSTTEnable
                            ? 'Click button'
                            : 'Speech not available'),
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
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Data',
                    style: TextStyle(fontSize: 30),
                  ),
                ],
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: AvatarGlow(
        animate: isRecording,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 80,
        duration: const Duration(milliseconds: 4000),
        repeatPauseDuration: const Duration(milliseconds: 200),
        repeat: true,
        child: FloatingActionButton(
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
      ),
    );
  }
}
