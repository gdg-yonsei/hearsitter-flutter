import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hear_sitter/src/core/app_assets.dart';
import 'package:hear_sitter/src/core/app_constants.dart';
import 'package:hear_sitter/src/models/audio_tagging_model.dart';
import 'package:hear_sitter/src/providers/audio_tagging_db_provider.dart';
import 'package:hear_sitter/src/screens/home/widgets/appbar_icon_button.dart';
import 'package:hear_sitter/src/screens/home/widgets/history_row.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<AudioTaggingModel> history = ref.watch(audioTaggingDBProvider).history;

    // Let's render the todos in a scrollable list view
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      appBarIconButton(
                          onTap: () {
                            context.pop();
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 22,
                            color: AppColor.lightGrayColor,
                          )),
                      SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.asset(AppAssets.logo2)),
                      const SizedBox(
                        width: 43,
                      )
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'History',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500),
              ),
              history.isNotEmpty
                  ? const SizedBox(
                      height: 20,
                    )
                  : const SizedBox(),
              history.isEmpty
                  ? historyEmptyScreen()
                  : Expanded(
                      child: ListView.builder(
                          itemCount: history.length,
                          itemBuilder: (context, idx) {
                            late Color boxColor;
                            late String boxImgUrl;
                            String historyLabel = history[idx].label;
                            String historyDate = history[idx].date;
                            int historyDecibel = history[idx].decibel;
                            if (historyLabel ==
                                SoundCategory.INFANT_CRYING.label) {
                              boxColor = SoundCategory.INFANT_CRYING.color;
                              boxImgUrl = SoundCategory.INFANT_CRYING.iconLight;
                            } else if (historyLabel ==
                                SoundCategory.CRACK_SOUND.label) {
                              boxColor = SoundCategory.CRACK_SOUND.color;
                              boxImgUrl = SoundCategory.CRACK_SOUND.iconLight;
                            } else if (historyLabel ==
                                SoundCategory.FIRE_ALARM.label) {
                              boxColor = SoundCategory.FIRE_ALARM.color;
                              boxImgUrl = SoundCategory.FIRE_ALARM.iconLight;
                            } else if (historyLabel ==
                                SoundCategory.GUN_SHOT.label) {
                              boxColor = SoundCategory.GUN_SHOT.color;
                              boxImgUrl = SoundCategory.GUN_SHOT.iconLight;
                            } else if (historyLabel ==
                                SoundCategory.CAR_HORN.label) {
                              boxColor = SoundCategory.CAR_HORN.color;
                              boxImgUrl = SoundCategory.CAR_HORN.iconLight;
                            } else if (historyLabel ==
                                SoundCategory.NAME.label) {
                              boxColor = SoundCategory.NAME.color;
                              boxImgUrl = SoundCategory.NAME.iconLight;
                            } else if (historyLabel ==
                                SoundCategory.MAMA.label) {
                              boxColor = SoundCategory.MAMA.color;
                              boxImgUrl = SoundCategory.MAMA.iconLight;
                            } else if (historyLabel ==
                                SoundCategory.PAPA.label) {
                              boxColor = SoundCategory.PAPA.color;
                              boxImgUrl = SoundCategory.PAPA.iconLight;
                            }
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade200,
                                          blurRadius: 1,
                                          spreadRadius: 1)
                                    ]),
                                child: ListTile(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15))),
                                  leading: historyIconBox(boxImgUrl, boxColor),
                                  title: Text(
                                    historyLabel,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${historyDecibel}dB',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Text(
                                        historyDate,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget historyEmptyScreen() {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: AppColor.grayColor,
              ),
              child: const Icon(
                Icons.description_rounded,
                color: AppColor.lightGrayColor,
                size: 55,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'No History',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: AppColor.grayColor),
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              'There is no any detection history yet.',
              style: TextStyle(fontSize: 15, color: AppColor.grayColor),
            ),
          ],
        ),
      ),
    );
  }
}
