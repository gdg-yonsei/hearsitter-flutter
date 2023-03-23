import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:see_our_sounds/src/repositories/stt_repository.dart';
import 'package:speech_to_text/speech_to_text.dart';

final sttProvider = ChangeNotifierProvider((ref){
  final stt = SpeechToText();
  return STTRepositoryImpl(speechToText: stt);
});

