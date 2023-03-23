import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:see_our_sounds/src/core/utils/database_util.dart';
import 'package:see_our_sounds/src/repositories/audio_tagging_repository.dart';

final audioTaggingDBProvider =
    ChangeNotifierProvider((ref) => AudioTaggingRepositoryImpl(DatabaseUtil()));
