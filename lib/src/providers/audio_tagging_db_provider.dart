import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hear_sitter/src/core/utils/database_util.dart';
import 'package:hear_sitter/src/repositories/audio_tagging_repository.dart';

final audioTaggingDBProvider =
    ChangeNotifierProvider((ref) => AudioTaggingRepositoryImpl(DatabaseUtil()));
