import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

final sttProvider = ChangeNotifierProvider((ref) {
  final stt = SpeechToText();
  return STTNotifier(speechToText: stt);
});

class STTNotifier extends ChangeNotifier {
  STTNotifier({required this.speechToText}) {
    initialize();
  }

  SpeechToText speechToText;

  Future<void> initialize() async {
    await speechToText.initialize();
  }

  bool _isListening = false;
  // speech_to_text 패키지가 자동으로 단어 인식하면, 끄므로,
  // 연속적으로 speech_to_text하기 위해 Future.delyaed()
  Future<void> startListening() async {
    speechToText.listen(onResult: (res) => notifyListeners(), localeId: 'EN');
    notifyListeners();
  }

  Future<void> stopListening() async {
    _isListening = false;
    await speechToText.stop();
    notifyListeners();
  }

  Future<void> cancelListening() async {
    await speechToText.cancel();
    notifyListeners();
  }
}
