import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';

abstract class STTRepository {
  Future<void> initialize();

  Future<void> startListening();

  Future<void> stopListening();

  Future<void> cancelListening();
}

class STTRepositoryImpl extends ChangeNotifier implements STTRepository {
  STTRepositoryImpl({required this.speechToText}) {
    initialize();
  }

  SpeechToText speechToText;

  @override
  Future<void> initialize() async {
    await speechToText.initialize();
  }

  @override
  Future<void> startListening() async {
    speechToText.listen(onResult: (res) => notifyListeners());
    notifyListeners();
  }

  @override
  Future<void> stopListening() async {
    await speechToText.stop();
    notifyListeners();
  }

  @override
  Future<void> cancelListening() async {
    await speechToText.cancel();
    notifyListeners();
  }
}
