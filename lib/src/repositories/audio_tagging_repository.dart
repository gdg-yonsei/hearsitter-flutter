import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:see_our_sounds/src/core/utils/database_util.dart';
import 'package:see_our_sounds/src/models/audio_tagging_model.dart';

abstract class AudioTaggingRepository {
  Future<dynamic> getAllHistory();

  Future<void> addHistory(AudioTaggingModel audioTagging, int currentDecibel);

  Future<void> deleteHistory(int id);
}

class AudioTaggingRepositoryImpl extends ChangeNotifier
    implements AudioTaggingRepository {
  AudioTaggingRepositoryImpl(this._databaseUtil);

  final databaseUtil = DatabaseUtil();
  final DatabaseUtil _databaseUtil;
  List<AudioTaggingModel> _history = <AudioTaggingModel>[];

  List<AudioTaggingModel> get history => _history;

  @override
  Future<dynamic> getAllHistory() async {
    return _databaseUtil.getAllHistory().then((value) {
      _history = value;
    }).whenComplete(notifyListeners);
  }

  @override
  Future<void> addHistory(
      AudioTaggingModel audioTagging, int currentDecibel) async {
    return _databaseUtil
        .addHistory(audioTagging, currentDecibel)
        .whenComplete(() {
      audioTagging = audioTagging.copyWith(
          date: DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now()),
          decibel: currentDecibel);
      _history.add(audioTagging);
      notifyListeners();
    });
  }

  @override
  Future<void> deleteHistory(int id) async {
    return _databaseUtil.deleteHistory(id).whenComplete(() {
      _history.removeAt(id);
      notifyListeners();
    });
  }
}
