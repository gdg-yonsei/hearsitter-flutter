import 'dart:ui';

import 'package:hear_sitter/src/core/app_assets.dart';

class AppUri {
  AppUri._();

  static const String uriBase = 'http://watch.jimmy0006.site:3000';
  static const String uriPing = '/ping';
  static const String uriUint = '/uint';
}

class AppColor {
  AppColor._();

  static const primaryColor = Color(0xff4285f4);
  static const secondaryColor = Color(0xffa7bbff);
  static const errorColor = Color(0xffE54C19);
  static const grayColor = Color(0xffa1a1a1);
  static const lightGrayColor = Color(0xffd9d9d9);
  static const accentColor = Color(0xff00164e);
  static const darkColor = Color(0xff181818);
}

class AppDatabase {
  static const String tableName = 'history';
  static const int version = 1; // database version
}

enum SoundCategory {
  BABY_CRYING, // 아기 울음 소리
  CRACK_SOUND, // 유리 깨지는 소리
  FIRE_ALARM, // 화재 알람
  GUN_SHOT, // 총소리
  CAR_HORN, // 자동차 경적 소리
  NAME, // 이름
  MAMA, // 엄마
  PAPA, // 아빠
}

extension SoundCategoryUtil on SoundCategory {
  String get iconLight {
    switch (this) {
      case SoundCategory.BABY_CRYING:
        return AppAssets.infantCryingIconLight;
      case SoundCategory.CRACK_SOUND:
        return AppAssets.crackIconLight;
      case SoundCategory.FIRE_ALARM:
        return AppAssets.fireAlarmIconLight;
      case SoundCategory.GUN_SHOT:
        return AppAssets.gunIconLight;
      case SoundCategory.CAR_HORN:
        return AppAssets.carHornIconLight;
      case SoundCategory.NAME:
        return AppAssets.nameIconLight;
      case SoundCategory.MAMA:
        return AppAssets.mamaPapaIconLight;
      case SoundCategory.PAPA:
        return AppAssets.mamaPapaIconLight;
    }
  }

  String get iconDark {
    switch (this) {
      case SoundCategory.BABY_CRYING:
        return AppAssets.infantCryingIconDark;
      case SoundCategory.CRACK_SOUND:
        return AppAssets.crackIconDark;
      case SoundCategory.FIRE_ALARM:
        return AppAssets.fireAlarmIconDark;
      case SoundCategory.GUN_SHOT:
        return AppAssets.gunIconDark;
      case SoundCategory.CAR_HORN:
        return AppAssets.carHornIconDark;
      case SoundCategory.NAME:
        return AppAssets.nameIconDark;
      case SoundCategory.MAMA:
        return AppAssets.mamaPapaIconDark;
      case SoundCategory.PAPA:
        return AppAssets.mamaPapaIconDark;
    }
  }

  String get label {
    switch (this) {
      case SoundCategory.BABY_CRYING:
        return 'Baby Crying';
      case SoundCategory.CRACK_SOUND:
        return 'Glass';
      case SoundCategory.FIRE_ALARM:
        return 'Fire alarm';
      case SoundCategory.GUN_SHOT:
        return 'Gunshot';
      case SoundCategory.CAR_HORN:
        return 'Car horn';
      case SoundCategory.NAME:
        return 'Name';
      case SoundCategory.MAMA:
        return 'Mama';
      case SoundCategory.PAPA:
        return 'Papa';
    }
  }

  Color get color {
    switch (this) {
      case SoundCategory.BABY_CRYING:
        return const Color(0xffffd400);
      case SoundCategory.CRACK_SOUND:
        return const Color(0xff0072db);
      case SoundCategory.FIRE_ALARM:
        return const Color(0xffe94025);
      case SoundCategory.GUN_SHOT:
        return const Color(0xff473b3d);
      case SoundCategory.CAR_HORN:
        return const Color(0xff7c1bbb);
      case SoundCategory.NAME:
        return const Color(0xffffa7cb);
      case SoundCategory.MAMA:
        return const Color(0xffff6e11);
      case SoundCategory.PAPA:
        return const Color(0xff008d62);
    }
  }
}
