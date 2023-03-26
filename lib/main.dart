import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:see_our_sounds/src/screens/category/category_card.dart';
import 'package:see_our_sounds/src/screens/category/category_screen.dart';
import 'package:see_our_sounds/src/screens/home/home_screen.dart';
import 'package:see_our_sounds/src/screens/onboarding_screen.dart';

void main() {
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
      home: OnboardingScreen(),
    );
  }
}
