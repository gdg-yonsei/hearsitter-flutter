import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:see_our_sounds/src/data/models/audio_tagging_model.dart';
import 'package:see_our_sounds/src/data/repositories/audio_tagging_repo_impl.dart';
import 'package:see_our_sounds/src/data/services/remote/audio_tagging_service.dart';
import 'package:see_our_sounds/src/domain/repositories/audio_tagging_repo.dart';

final auidoTaggingProvider =
    Provider<AudioTaggingRepo>((ref) => AudioTaggingRepoImpl());

final audioTaggingServiceProvider =
    Provider<AudioTaggingService>((ref) => AudioTaggingService());



final openRecordProvider = FutureProvider((ref) {
  final audioTaggingRepo = ref.watch(auidoTaggingProvider);
  return audioTaggingRepo.openRecord();
});

// final provider =
//     StreamProvider.autoDispose<AudioTaggingModel>((ref) {
//   final controller = StreamController<AudioTaggingModel>();
//
//   ref.onDispose(() {
//     controller.close();
//   });
// });
