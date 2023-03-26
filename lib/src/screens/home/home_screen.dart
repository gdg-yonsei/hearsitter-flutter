import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:see_our_sounds/src/core/app_constants.dart';
import 'package:see_our_sounds/src/models/audio_tagging_model.dart';
import 'package:see_our_sounds/src/providers/audio_tagging_api_provider.dart';
import 'package:see_our_sounds/src/providers/audio_tagging_db_provider.dart';
import 'package:see_our_sounds/src/providers/decibel_provider.dart';
import 'package:see_our_sounds/src/providers/stt_provider.dart';
import 'package:see_our_sounds/src/screens/home/decibel_history_chart.dart';
import 'package:see_our_sounds/src/screens/home/widgets/toggle_button.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

final isRecordingProvider = StateProvider<bool>((ref) => false);

class HomseScreen extends ConsumerStatefulWidget {
  const HomseScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomseScreen> createState() => _HomseScreenState();
}

class _HomseScreenState extends ConsumerState<HomseScreen> {
  @override
  Widget build(BuildContext context) {
    bool isRecording = ref.watch(isRecordingProvider);
    final stt = ref.watch(sttProvider);
    final audioTaggingApi =
        ref.watch(recorderStreamProvider).audioTaggingStream();
    AudioTaggingModel audioTaggingModel =
        ref.watch(recorderStreamProvider).audioTaggingModel;
    final decibelStream = ref.watch(decibelStreamProvider);
    List<AudioTaggingModel> history = ref.watch(audioTaggingDBProvider).history;
    //
    // if (audioTaggingModel.isAlert) {
    //   ref.read(recorderStreamProvider.notifier).stopRecording();
    //   SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    //     Future.delayed(const Duration(milliseconds: 1500));
    //     Navigator.push(
    //         context, MaterialPageRoute(builder: (context) => HistoryScreen()));
    //   });
    // }

    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  appBarIconButton(
                      onTap: () {},
                      icon: const Icon(
                        Icons.question_mark_rounded,
                        size: 24,
                        color: AppColor.lightGrayColor,
                      )),
                  const Text(
                    'HearSitter',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  appBarIconButton(
                      onTap: () {},
                      icon: const Icon(
                        Icons.grid_view_rounded,
                        size: 25,
                        color: AppColor.lightGrayColor,
                      ))
                ],
              ),
            ),
            // Text(stt.speechToText.lastRecognizedWords),
            Text(audioTaggingModel.isAlert.toString()),
            Text(audioTaggingModel.isAlert.toString()),
            StreamBuilder(
              stream: audioTaggingApi,
              builder: (context, snapshot) {
                return const SizedBox.shrink();
              },
            ),
            const Spacer(),
            historyTitle(),
            Container(
              width: double.infinity,
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.shade100,
                        blurRadius: 2,
                        spreadRadius: 1)
                  ]),
              child: history.isEmpty
                  ? Row(
                      children: [
                        iconBox(
                            const Icon(
                              Icons.description_rounded,
                              color: AppColor.grayColor,
                              size: 30,
                            ),
                            AppColor.lightGrayColor),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'There is no history yet.',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColor.grayColor),
                        ),
                      ],
                    )
                  : Row(
                      children: [Text(history[0].label)],
                    ),
            ),
            decibelStream.when(
                data: (data) {
                  List<int> decibelHistory = data[1] as List<int>;
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      DecibelHistoryChart(
                        decibelHistory: decibelHistory,
                        lineColor: AppColor.primaryColor,
                      ),
                      decibelGauge(data[0] as int),
                    ],
                  );
                },
                error: (error, stackTrace) => Text('Error : $error'),
                loading: () => Column(
                      children: [
                        DecibelHistoryChart(
                          decibelHistory: List.filled(80, 0),
                          lineColor: Colors.transparent,
                        ),
                        decibelGauge(0),
                      ],
                    )),
            const Spacer(),
            bottomNavigationBar(isRecording)
          ],
        ),
      ),
    ));
  }

  Row historyTitle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Recent History',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          textAlign: TextAlign.start,
        ),
        TextButton(
            onPressed: () {},
            child: const Text(
              'See All',
              style: TextStyle(
                  color: AppColor.primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w400),
            ))
      ],
    );
  }

  Widget bottomNavigationBar(bool isRecording) {
    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade100, blurRadius: 2, spreadRadius: 1)
          ]),
      child: Row(
        children: [
          bottomNavigationIcon(
              onTap: () {}, icon: Icons.description_rounded, text: 'History'),
          const SizedBox(
            width: 20,
          ),
          bottomNavigationIcon(
              onTap: () {}, icon: Icons.settings_rounded, text: 'Setting'),
          const Padding(
            padding: EdgeInsets.only(left: 20),
            child: SizedBox(
              height: 40,
              child: VerticalDivider(
                width: 1,
                thickness: 1,
              ),
            ),
          ),
          const Spacer(),
          Text(
            isRecording
                ? "HearSitter's\n Working."
                : "HearSitter's \nNot Working.",
            textAlign: TextAlign.center,
            style: TextStyle(
                color: isRecording ? AppColor.primaryColor : AppColor.grayColor,
                fontSize: 13,
                fontWeight: FontWeight.w500),
          ),
          const Spacer(
            flex: 2,
          ),
          ToggleButton(
              onTap: () async {
                ref.read(isRecordingProvider.notifier).state =
                    isRecording ? false : true;
                isRecording
                    ? ref.read(recorderStreamProvider.notifier).stopRecording()
                    : await ref
                        .read(recorderStreamProvider.notifier)
                        .startRecording();
              },
              isRecording: isRecording)
        ],
      ),
    );
  }

  Widget bottomNavigationIcon(
      {required onTap, required IconData icon, required String text}) {
    return InkWell(
      splashColor: AppColor.primaryColor,
      customBorder: const CircleBorder(),
      onTap: onTap,
      child: SizedBox.fromSize(
        size: const Size(50, 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 25,
              color: AppColor.lightGrayColor,
            ),
            Text(
              text,
              style: const TextStyle(
                color: AppColor.grayColor,
                fontSize: 10,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget appBarIconButton({required VoidCallback onTap, required Widget icon}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade200, blurRadius: 1, spreadRadius: 1)
              ]),
          child: icon,
        ));
  }

  Widget iconBox(Widget icon, Color boxColor) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: boxColor,
      ),
      child: icon,
    );
  }

  Widget decibelGauge(int decibel) {
    return SizedBox(
      width: 290,
      height: 280,
      child: SfRadialGauge(
        axes: <RadialAxis>[
          RadialAxis(
            minimum: 0,
            maximum: 120,
            interval: 20,
            showLastLabel: true,
            showTicks: false,
            useRangeColorForAxis: true,
            axisLineStyle: const AxisLineStyle(
              thickness: 25,
              cornerStyle: CornerStyle.bothCurve,
            ),
            axisLabelStyle: const GaugeTextStyle(
              fontSize: 13,
              fontFamily: 'NotoSansKR',
              color: AppColor.grayColor,
            ),
            pointers: [
              RangePointer(
                value: decibel.toDouble(),
                cornerStyle: CornerStyle.bothCurve,
                width: 25,
                color: AppColor.primaryColor,
              ),
            ],
            annotations: [
              GaugeAnnotation(
                widget: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: '$decibel\n',
                      style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: AppColor.darkColor),
                      children: const [
                        TextSpan(
                          text: 'dB',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        )
                      ]),
                ),
                angle: 90,
                positionFactor: 0.1,
              ),
            ],
          )
        ],
      ),
    );
  }
}
