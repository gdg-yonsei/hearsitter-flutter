import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hear_sitter/src/core/app_assets.dart';
import 'package:hear_sitter/src/core/app_constants.dart';
import 'package:hear_sitter/src/core/utils/router_util.dart';
import 'package:hear_sitter/src/models/audio_tagging_model.dart';
import 'package:hear_sitter/src/screens/home/widgets/history_row.dart';
import 'package:hear_sitter/src/screens/home/widgets/no_history_row.dart';
import 'package:hear_sitter/src/providers/audio_tagging_api_provider.dart';
import 'package:hear_sitter/src/providers/audio_tagging_db_provider.dart';
import 'package:hear_sitter/src/providers/decibel_provider.dart';
import 'package:hear_sitter/src/providers/stt_provider.dart';
import 'package:hear_sitter/src/screens/home/widgets/appbar_icon_button.dart';
import 'package:hear_sitter/src/screens/home/widgets/decibel_history_gauge.dart';
import 'package:hear_sitter/src/screens/home/widgets/decibel_scale_chart.dart';
import 'package:hear_sitter/src/screens/home/widgets/history_title.dart';
import 'package:hear_sitter/src/screens/home/widgets/toggle_button.dart';

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
            const HistoryTitle(),
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
              onTap: () {
                _sendEmail();
              }, icon: Icons.mail_rounded, text: 'Feedback'),
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

  Future<void> _sendEmail() async {
    final Email email = Email(
        body: '',
        subject: '[HearSitter Feedback]',
        recipients: ['gdsc.yonsei.hearsitter@gmail.com'],
        cc: [],
        bcc: [],
        attachmentPaths: [],
        isHTML: false);

    try {
      await FlutterEmailSender.send(email);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sorry, an error occurred.')));
    }
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
}
