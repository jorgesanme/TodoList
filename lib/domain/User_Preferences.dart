import 'package:shared_preferences/shared_preferences.dart';


class UserPreferences {
  static late  SharedPreferences _preferences ;
  static const _keyDoneOption = 'DoneOption';
  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setUserDonePreference(String selected) async =>
      await _preferences.setString(_keyDoneOption, selected);

  static String getUserPreference() => _preferences.getString(_keyDoneOption) ?? 'Nothing';
}