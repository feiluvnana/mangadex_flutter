// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SPService {
  static late final SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const DOWNLOADED_ONLY = "downloaded_only";
  static const INCOGNITO_MODE = "incognito_mode";
  static const SHOW_UNREAD_COUNT_ON_UPDATE_ICON = "show_unread_count_on_update_icon";
  static const CONFIRM_EXIT = "confirm_exit";
  static const APP_LANGUAGE = "app_language";

  static Future<void> setDownloadedOnly(bool value) async {
    await _prefs.setBool(DOWNLOADED_ONLY, value);
  }

  static bool getDownloadedOnly() {
    return _prefs.getBool(DOWNLOADED_ONLY) ?? false;
  }

  static Future<void> setIncognitoMode(bool value) async {
    await _prefs.setBool(INCOGNITO_MODE, value);
  }

  static bool getIncognitoMode() {
    return _prefs.getBool(INCOGNITO_MODE) ?? false;
  }

  static Future<void> setShowUnreadCountOnUpdateIcon(bool value) async {
    await _prefs.setBool(SHOW_UNREAD_COUNT_ON_UPDATE_ICON, value);
  }

  static bool getShowUnreadCountOnUpdateIcon() {
    return _prefs.getBool(SHOW_UNREAD_COUNT_ON_UPDATE_ICON) ?? false;
  }

  static Future<void> setConfirmExit(bool value) async {
    await _prefs.setBool(CONFIRM_EXIT, value);
  }

  static bool getConfirmExit() {
    return _prefs.getBool(CONFIRM_EXIT) ?? false;
  }

  static Future<void> setAppLanguage(String value) async {
    await _prefs.setString(APP_LANGUAGE, value);
  }

  static String getAppLanguage() {
    return _prefs.getString(APP_LANGUAGE) ?? "en";
  }
}
