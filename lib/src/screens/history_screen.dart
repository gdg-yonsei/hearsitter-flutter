import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:see_our_sounds/src/models/audio_tagging_model.dart';
import 'package:see_our_sounds/src/providers/audio_tagging_db_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AudioTaggingModel> history = ref.watch(audioTaggingDBProvider).history;

    // Let's render the todos in a scrollable list view
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            itemCount: history.length,
            itemBuilder: (context, idx) {
              return ListTile(
                title: Text(history[idx].label),
              );
            }),
      ),
    );
  }
}
