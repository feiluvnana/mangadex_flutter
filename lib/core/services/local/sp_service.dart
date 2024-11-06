// ignore_for_file: constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class SPService {
  static late final SharedPreferences _prefs;

  static Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static const _spPrefix = "sp.";
  static const DOWNLOADED_ONLY = "$_spPrefix.downloaded_only";
  static const INCOGNITO_MODE = "$_spPrefix.incognito_mode";
  static const SHOW_UNREAD_COUNT_ON_UPDATE_ICON =
      "$_spPrefix.show_unread_count_on_update_icon";
  static const CONFIRM_EXIT = "$_spPrefix.confirm_exit";
  static const APP_LANGUAGE = "$_spPrefix.app_language";
  static const DARK_THEME = "$_spPrefix.dark_theme";
  static const PURE_BLACK_THEME = "$_spPrefix.pure_black_theme";
  static const RELATIVE_TIMESTAMP = "$_spPrefix.relative_timestamp";
  static const DATE_FORMAT = "$_spPrefix.date_format";

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

  static Future<void> setDarkTheme(bool value) async {
    await _prefs.setBool(DARK_THEME, value);
  }

  static bool getDarkTheme() {
    return _prefs.getBool(DARK_THEME) ?? true;
  }

  static Future<void> setPureBlackTheme(bool value) async {
    await _prefs.setBool(PURE_BLACK_THEME, value);
  }

  static bool getPureBlackTheme() {
    return _prefs.getBool(PURE_BLACK_THEME) ?? false;
  }

  static Future<void> setRelativeTimestamp(String value) async {
    await _prefs.setString(RELATIVE_TIMESTAMP, value);
  }

  static String getRelativeTimestamp() {
    return _prefs.getString(RELATIVE_TIMESTAMP) ?? "long";
  }

  static Future<void> setDateFormat(String value) async {
    await _prefs.setString(DATE_FORMAT, value);
  }

  static String getDateFormat() {
    return _prefs.getString(DATE_FORMAT) ?? "dd/MM/yyyy";
  }
}
