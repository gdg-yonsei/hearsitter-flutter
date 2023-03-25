import 'dart:ui';

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
  INFANT_CRYING,
  CRACK_SOUND,
  FIRE_ALARM,
  GUN_SHOT,
  CAR_HORN,
  ANNOUNCEMNET,
  NAME,
  MAMAM_PAPA,
  BICYCLE_BELL,
}

enum PuzzleType { MATH_PUZZLE, MEMORY_PUZZLE, BRAIN_PUZZLE }

class KeyUtil {
  static const IS_DARK_MODE = "isDarkMode";

  static const String splash = 'Splash';
  static const String dashboard = 'Dashboard';
  static const String home = 'Home';

  static const String calculator = 'Calculator';
  static const String guessSign = 'GuessSign';
  static const String correctAnswer = 'CorrectAnswer';
  static const String quickCalculation = 'QuickCalculation';
  static const String mentalArithmetic = 'MentalArithmetic';
  static const String squareRoot = 'SquareRoot';
  static const String mathPairs = 'MathPairs';
  static const String magicTriangle = 'MagicTriangle';
  static const String picturePuzzle = 'PicturePuzzle';
}
