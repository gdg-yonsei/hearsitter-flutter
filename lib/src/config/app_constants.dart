final String uriBase = 'http://watch.jimmy0006.site:3000';
final String uriPing = '/ping';
final String uriUint = '/uint';

enum GameCategoryType {
  CALCULATOR,
  GUESS_SIGN,
  SQUARE_ROOT,
  MATH_PAIRS,
  CORRECT_ANSWER,
  MAGIC_TRIANGLE,
  MENTAL_ARITHMETIC,
  QUICK_CALCULATION,
  MATH_GRID,
  PICTURE_PUZZLE,
  NUMBER_PYRAMID
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
