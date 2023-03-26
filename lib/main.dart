import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:see_our_sounds/src/core/utils/sharedprefs_util.dart';
import 'package:see_our_sounds/src/screens/home/home_screen.dart';

import 'package:see_our_sounds/src/screens/onboarding/onboarding_screen.dart';

late bool isOnboard;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesUtil.initialize();
  final prefs = SharedPreferencesUtil().prefs;
  isOnboard = prefs.getBool('isOnboard') ?? false;
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HearSitter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'NotoSansKR',
          scaffoldBackgroundColor: Colors.white),
      home: isOnboard ? const HomseScreen() : const OnboardingScreen(),
    );
  }
}
