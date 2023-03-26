import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
  static late final SharedPreferences _prefs;

  SharedPreferences get prefs => _prefs;
  static final SharedPreferencesUtil _prefsUtil =
      SharedPreferencesUtil._internal();

  SharedPreferencesUtil._internal();

  factory SharedPreferencesUtil() => _prefsUtil;

  static initialize() async => _prefs = await SharedPreferences.getInstance();
}
