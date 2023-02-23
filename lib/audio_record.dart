import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:see_our_sounds/src/core/core.dart';
import 'package:sound_stream/sound_stream.dart';

class AudioStream extends StatefulWidget {
  const AudioStream({Key? key}) : super(key: key);

  @override
  State<AudioStream> createState() => _AudioStreamState();
}

class _AudioStreamState extends State<AudioStream> {
  LocalNotification _localNotification = LocalNotification();
  RecorderStream recorder = RecorderStream();
  List<Uint8List> audioChunks = [];
  bool isRecording = false;
  DateTime currentTime = DateTime(0);
  Uint8List? audioFile;
  StreamSubscription? recorderStatus;
  StreamSubscription? audioStream;

  Future<void> openRecord() async {
    recorderStatus = recorder.status.listen((status) async {
      var permissionStatus = await Permission.microphone.status;
      if (mounted && permissionStatus.isGranted) {
        setState(() {
          isRecording = status == SoundStreamStatus.Playing;
          print('레코딩 $isRecording');
        });
      }
    });

    audioStream = recorder.audioStream.listen((data) {
      print('오디오 전전 ${audioChunks.length}');
      audioChunks.add(data);
      // 1초에 20개의 data 들어옴
      if (audioChunks.length > 260) {
        audioChunks.removeAt(0);
        print('오디오 삭제');
        print('오디오 후후 ${audioChunks.length}');
      }
    });

    await Future.wait([
      recorder.initialize(),
    ]);
  }

  Uint8List writeWavFile(List<Uint8List> audioChunks) {
    var data = audioChunks.expand((i) => i).toList();
    var channels = 1;
    int sampleRate = 32000;
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

  Future pingPong() async {
    var request =
    http.Request('GET', Uri.parse('http://watch.jimmy0006.site:3000/ping'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future audioRecognition() async {
    final audioStreamController = StreamController<DateTime>();
    Timer? timer;
    StreamSubscription<DateTime>? audioStreamSubscription;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      audioStreamController.add(DateTime.now());
    });

    audioStreamSubscription =
        audioStreamController.stream.listen((event) async {
          if (!isRecording) {
            timer?.cancel();
            await audioStreamController.close();
            await audioStreamSubscription?.cancel();
          } else {
            var data = await writeWavFile(audioChunks);
            var responseBody = await sendAudio(data);
          }
        });
  }



  Future<Map<String, dynamic>?> sendAudio(Uint8List data) async {
    final uri = Uri.parse('http://watch.jimmy0006.site:3000/uint');
    var response = await http.post(uri, body: data);
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      return responseBody;
    } else {
      print(response.reasonPhrase);
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openRecord();
    _localNotification.initNotification();
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
      body: Column(
        children: [
          IconButton(
            iconSize: 90,
            icon: Icon(isRecording ? Icons.mic : Icons.mic_off),
            onPressed: () async {
              if (isRecording) {
                recorder.stop();
                audioChunks.clear();
              } else {
                recorder.start();
                pingPong();
                audioRecognition();
              }
            },
          )
        ],
      ),
    );
  }
}
