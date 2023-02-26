// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:see_our_sounds/src/screen/provider/audio_tagging_provider.dart';
//
// // StreamProvider.autoDispose: destroys state if no-longer listened
// // final streamProvider = StreamProvider<String>((ref) => Stream.periodic(
// //   const Duration(seconds: 1),
// //       (count) => '$count',
// // ));
//
// final timerProvider = StreamProvider<int>(
//       (ref) {
//     return Stream.periodic(const Duration(seconds: 1), (number) => number);
//   },
// );
//
// // final tttProvider = StreamProvider((ref){
// //     final audioTaggingService = ref.watch(audioTaggingServiceProvider);
// //     return audioTaggingService.getPong();
// // });
//
// final streamProvider = StreamProvider<DateTime>((ref){
//   final controller = StreamController<DateTime>();
//   controller.add(DateTime.now());
//
//   ref.watch(timerProvider.stream).forEach((event) {
//     final
//   });
//
//   return controller.stream;
// });
//
// class StreamProviderScreen extends StatelessWidget {
//   const StreamProviderScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Stream Provider'),
//         ),
//         body: Center(
//           //* use "Consumer" instead of "extends ConsumerWidget". It's also good
//           child: Consumer(
//             builder: (context, ref, child) {
//               final  AsyncValue<String> stream = ref.watch(streamProvider);
//               return stream.when(
//                 data: (data) => Column(children: [Text(data)],),
//                 error: (error, stack) => Text(error.toString()),
//                 loading: () => const CircularProgressIndicator(),
//               );
//             },
//           ),
//         ));
//   }
// }