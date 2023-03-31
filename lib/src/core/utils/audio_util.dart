import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

class AudioUtil {
  static Uint8List toWAV(List<Uint8List> audioChunks) {
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
