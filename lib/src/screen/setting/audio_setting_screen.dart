import 'package:flutter/material.dart';

class AudioSettingScreen extends StatefulWidget {
  const AudioSettingScreen({Key? key}) : super(key: key);

  @override
  State<AudioSettingScreen> createState() => _AudioSettingScreenState();
}

class _AudioSettingScreenState extends State<AudioSettingScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
