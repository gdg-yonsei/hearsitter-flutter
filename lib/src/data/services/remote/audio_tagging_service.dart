import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:see_our_sounds/src/config/config.dart';
import 'package:see_our_sounds/src/data/models/audio_tagging_model.dart';

class AudioTaggingService {


  Future getPong() async {
    var request = http.Request('GET', Uri.parse(uriBase + uriPing));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      throw Exception(response.reasonPhrase);
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

  Future audioTagging({required bool isRecording, required Uint8List data}) async {
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
        await postAudio(data);
      }
    });
  }

  // Stream<AudioTaggingModel> audioTaggingStream(Uint8List audioChunks) async* {
  //   while (isRecording && audioChunks.isNotEmpty) {
  //     Uint8List wav = toWAV(audioChunks);
  //     AudioTaggingModel audioTaggingModel = await postAudio(wav);
  //     yield audioTaggingModel;
  //   }
  // }
}
