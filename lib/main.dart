import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hear_sitter/src/core/app_router.dart';
import 'package:hear_sitter/src/core/app_theme.dart';
import 'package:hear_sitter/src/core/utils/sharedprefs_util.dart';

import 'package:hear_sitter/src/providers/test.dart';
import 'package:sound_stream/sound_stream.dart';
late bool isOnboard;
RecorderStream recorderStream = RecorderStream();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesUtil.initialize();
  await recorderStream.initialize();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'HearSitter',
      debugShowCheckedModeBanner: false,
      theme: themeData(),
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
