import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hear_sitter/src/core/app_assets.dart';
import 'package:hear_sitter/src/core/app_constants.dart';
import 'package:hear_sitter/src/core/utils/router_util.dart';
import 'package:hear_sitter/src/models/audio_tagging_model.dart';
import 'package:hear_sitter/src/providers/audio_tagging_api_provider.dart';
import 'package:hear_sitter/src/providers/audio_tagging_db_provider.dart';
import 'package:hear_sitter/src/providers/decibel_provider.dart';
import 'package:hear_sitter/src/providers/stt_provider.dart';
import 'package:hear_sitter/src/screens/history/history_screen.dart';
import 'package:hear_sitter/src/screens/home/widgets/decibel_history_chart.dart';
import 'package:hear_sitter/src/screens/home/widgets/decibel_scale_chart.dart';
import 'package:hear_sitter/src/screens/home/widgets/toggle_button.dart';

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
        ref.watch(audioTaggingApiProvider).audioTaggingStream();
    AudioTaggingModel audioTaggingModel =
        ref.watch(audioTaggingApiProvider).audioTaggingModel;
    final decibelStream = ref.watch(decibelStreamProvider);
    List<AudioTaggingModel> history = ref.watch(audioTaggingDBProvider).history;

    // if (audioTaggingModel.isAlert) {
    //   ref.read(audioTaggingApiProvider.notifier).stopRecording();
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
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const SimpleDialog(
                                title: Text('Decibel Scale'),
                                children: [DecibelScaleChart()],
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.question_mark_rounded,
                        size: 22,
                        color: AppColor.lightGrayColor,
                      )),
                  SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.asset(AppAssets.logo2)),
                  appBarIconButton(
                      onTap: () {
                        context.go(APP_SCREEN.category.routePath);
                      },
                      icon: const Icon(
                        Icons.grid_view_rounded,
                        size: 23,
                        color: AppColor.lightGrayColor,
                      ))
                ],
              ),
            ),
            // Text(stt.speechToText.lastRecognizedWords),
            // Text(audioTaggingModel.label.toString()),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade100,
                          blurRadius: 2,
                          spreadRadius: 1)
                    ]),
                child: history.isEmpty ? noHistoryRow() : historyRow(history)),
            decibelStream.when(
                data: (data) {
                  int currentDecibel = data[0] as int;
                  List<int> decibelHistory = data[1] as List<int>;
                  if (audioTaggingModel.isAlert &&
                      history.isNotEmpty &&
                      audioTaggingModel.label != history.last.label) {
                    ref
                        .read(audioTaggingDBProvider)
                        .addHistory(audioTaggingModel, currentDecibel);
                  } else if (audioTaggingModel.isAlert && history.isEmpty) {
                    ref
                        .read(audioTaggingDBProvider)
                        .addHistory(audioTaggingModel, currentDecibel);
                  }
                  return decibelHistoryGauge(
                      decibelHistory: decibelHistory,
                      lineColor: AppColor.primaryColor,
                      decibel: currentDecibel);
                },
                error: (error, stackTrace) => Text('Error : $error'),
                loading: () => decibelHistoryGauge(
                    decibelHistory: List.filled(80, 0),
                    lineColor: Colors.transparent,
                    decibel: 0)),
            const Spacer(),
            bottomNavBar(isRecording)
          ],
        ),
      ),
    ));
  }

  Widget historyTitle() {
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

  Widget bottomNavBar(bool isRecording) {
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
          bottomNavIcon(
              onTap: () {
                context.push(APP_SCREEN.history.routePath);
              },
              icon: Icons.description_rounded,
              text: 'History'),
          const SizedBox(
            width: 20,
          ),
          bottomNavIcon(
              onTap: () {}, icon: Icons.mail_rounded, text: 'Feedback'),
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
                    ? ref.read(audioTaggingApiProvider.notifier).stopRecording()
                    : await ref
                        .read(audioTaggingApiProvider.notifier)
                        .startRecording();
              },
              isRecording: isRecording)
        ],
      ),
    );
  }

  Widget noHistoryRow() {
    return Row(
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
    );
  }

  Row historyRow(List<AudioTaggingModel> history) {
    late Color boxColor;
    late String boxImgUrl;
    String historyLabel = history.last.label;
    String historyDate = history.last.date;
    int historyDecibel = history.last.decibel;
    if (historyLabel == SoundCategory.INFANT_CRYING.label) {
      boxColor = SoundCategory.INFANT_CRYING.color;
      boxImgUrl = SoundCategory.INFANT_CRYING.iconLight;
    } else if (historyLabel == SoundCategory.CRACK_SOUND.label) {
      boxColor = SoundCategory.CRACK_SOUND.color;
      boxImgUrl = SoundCategory.CRACK_SOUND.iconLight;
    } else if (historyLabel == SoundCategory.FIRE_ALARM.label) {
      boxColor = SoundCategory.FIRE_ALARM.color;
      boxImgUrl = SoundCategory.FIRE_ALARM.iconLight;
    } else if (historyLabel == SoundCategory.GUN_SHOT.label) {
      boxColor = SoundCategory.GUN_SHOT.color;
      boxImgUrl = SoundCategory.GUN_SHOT.iconLight;
    } else if (historyLabel == SoundCategory.CAR_HORN.label) {
      boxColor = SoundCategory.CAR_HORN.color;
      boxImgUrl = SoundCategory.CAR_HORN.iconLight;
    } else if (historyLabel == SoundCategory.NAME.label) {
      boxColor = SoundCategory.NAME.color;
      boxImgUrl = SoundCategory.NAME.iconLight;
    } else if (historyLabel == SoundCategory.MAMA.label) {
      boxColor = SoundCategory.MAMA.color;
      boxImgUrl = SoundCategory.MAMA.iconLight;
    } else if (historyLabel == SoundCategory.PAPA.label) {
      boxColor = SoundCategory.PAPA.color;
      boxImgUrl = SoundCategory.PAPA.iconLight;
    }
    return Row(
      children: [
        historyIconBox(boxImgUrl, boxColor),
        const SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              historyLabel,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  '${historyDecibel}dB',
                  style: const TextStyle(
                      fontSize: 13,
                      color: AppColor.darkColor,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  width: 110,
                ),
                Text(
                  historyDate,
                  style: const TextStyle(
                      fontSize: 13,
                      color: AppColor.darkColor,
                      fontWeight: FontWeight.w300),
                ),
              ],
            )
          ],
        )
      ],
    );
  }

  Widget bottomNavIcon(
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
          width: 43,
          height: 43,
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

  Widget historyIconBox(String imgUrl, Color boxColor) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: boxColor,
      ),
      child: Image.asset(
        imgUrl,
        scale: 2.5,
      ),
    );
  }

  Widget decibelHistoryGauge(
      {required List<int> decibelHistory,
      required Color lineColor,
      required int decibel}) {
    return Column(
      children: [
        DecibelHistoryChart(
            decibelHistory: decibelHistory, lineColor: lineColor),
        const SizedBox(
          height: 10,
        ),
        AspectRatio(
          aspectRatio: 1.3,
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
                    color: decibel > 89
                        ? AppColor.errorColor
                        : AppColor.primaryColor,
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
        ),
      ],
    );
  }
}
