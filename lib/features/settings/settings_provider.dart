import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mangadex_flutter/core/services/local/sp_service.dart';

part 'settings_provider.freezed.dart';
part 'settings_provider.g.dart';

@freezed
class SettingsState with _$SettingsState {
  factory SettingsState(
      {required bool downloadedOnly,
      required bool incognitoMode,
      required bool showUnreadCountOnUpdateIcon,
      required bool confirmExit,
      required String appLanguage,
      required bool darkTheme,
      required bool pureBlackTheme,
      required String relativeTimestamp,
      required String dateFormat}) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) =>
      _$SettingsStateFromJson(json);
}

final settingsProvider =
    NotifierProvider<SettingsNotifier, SettingsState>(SettingsNotifier.new);

class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    return SettingsState(
        downloadedOnly: SPService.getDownloadedOnly(),
        incognitoMode: SPService.getIncognitoMode(),
        showUnreadCountOnUpdateIcon: SPService.getShowUnreadCountOnUpdateIcon(),
        confirmExit: SPService.getConfirmExit(),
        appLanguage: SPService.getAppLanguage(),
        darkTheme: SPService.getDarkTheme(),
        pureBlackTheme: SPService.getPureBlackTheme(),
        relativeTimestamp: SPService.getRelativeTimestamp(),
        dateFormat: SPService.getDateFormat());
  }

  Future<void> setDownloadedOnly(bool value) async {
    await SPService.setDownloadedOnly(value);
    state = state.copyWith(downloadedOnly: value);
  }

  Future<void> setIncognitoMode(bool value) async {
    await SPService.setIncognitoMode(value);
    state = state.copyWith(incognitoMode: value);
  }

  Future<void> setShowUnreadCountOnUpdateIcon(bool value) async {
    await SPService.setShowUnreadCountOnUpdateIcon(value);
    state = state.copyWith(showUnreadCountOnUpdateIcon: value);
  }

  Future<void> setConfirmExit(bool value) async {
    await SPService.setConfirmExit(value);
    state = state.copyWith(confirmExit: value);
  }

  Future<void> setAppLanguage(String value) async {
    await SPService.setAppLanguage(value);
    state = state.copyWith(appLanguage: value);
  }

  Future<void> setDarkTheme(bool value) async {
    await SPService.setDarkTheme(value);
    state = state.copyWith(darkTheme: value);
  }

  Future<void> setPureBlackTheme(bool value) async {
    await SPService.setPureBlackTheme(value);
    state = state.copyWith(pureBlackTheme: value);
  }

  Future<void> setRelativeTimestamp(String value) async {
    await SPService.setRelativeTimestamp(value);
    state = state.copyWith(relativeTimestamp: value);
  }

  Future<void> setDateFormat(String value) async {
    await SPService.setDateFormat(value);
    state = state.copyWith(dateFormat: value);
  }
}
