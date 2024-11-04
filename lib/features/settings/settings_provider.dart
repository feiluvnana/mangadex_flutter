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
      required String appLanguage}) = _SettingsState;

  factory SettingsState.fromJson(Map<String, dynamic> json) => _$SettingsStateFromJson(json);
}

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(SettingsNotifier.new);

class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    return SettingsState(
        downloadedOnly: SPService.getDownloadedOnly(),
        incognitoMode: SPService.getIncognitoMode(),
        showUnreadCountOnUpdateIcon: SPService.getShowUnreadCountOnUpdateIcon(),
        confirmExit: SPService.getConfirmExit(),
        appLanguage: SPService.getAppLanguage());
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
}
