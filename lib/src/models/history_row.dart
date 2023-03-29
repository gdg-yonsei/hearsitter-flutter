import 'package:flutter/material.dart';
import 'package:hear_sitter/src/core/app_constants.dart';
import 'package:hear_sitter/src/models/audio_tagging_model.dart';

Widget historyRow(List<AudioTaggingModel> history) {
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
