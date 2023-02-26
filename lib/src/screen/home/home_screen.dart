// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter/material.dart';
// import 'package:see_our_sounds/src/data/repositories/audio_tagging_repo_impl.dart';
// import 'package:see_our_sounds/src/screen/provider/audio_tagging_provider.dart';
//
// class HomeScreen extends ConsumerWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     bool isRecording = AudioTaggingRepoImpl().isRecording;
//     final openRecord = ref.watch(openRecordProvider);
//     final stopRecord = ref.watch(stopRecordProvider);
//     final label = ref.read(labelProvider);
//     final taggingRate = ref.read(taggingRateProvider);
//     return Scaffold(
//       body: Column(
//         children: [
//           IconButton(
//             iconSize: 90,
//             icon: Icon(isRecording ? Icons.mic : Icons.mic_off),
//             onPressed: () async {
//               if (isRecording) {
//                 openRecord;
//               } else {
//                 stopRecord;
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
