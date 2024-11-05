// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsStateImpl _$$SettingsStateImplFromJson(Map<String, dynamic> json) =>
    _$SettingsStateImpl(
      downloadedOnly: json['downloadedOnly'] as bool,
      incognitoMode: json['incognitoMode'] as bool,
      showUnreadCountOnUpdateIcon: json['showUnreadCountOnUpdateIcon'] as bool,
      confirmExit: json['confirmExit'] as bool,
      appLanguage: json['appLanguage'] as String,
      darkTheme: json['darkTheme'] as bool,
      pureBlackTheme: json['pureBlackTheme'] as bool,
      relativeTimestamp: json['relativeTimestamp'] as String,
      dateFormat: json['dateFormat'] as String,
    );

Map<String, dynamic> _$$SettingsStateImplToJson(_$SettingsStateImpl instance) =>
    <String, dynamic>{
      'downloadedOnly': instance.downloadedOnly,
      'incognitoMode': instance.incognitoMode,
      'showUnreadCountOnUpdateIcon': instance.showUnreadCountOnUpdateIcon,
      'confirmExit': instance.confirmExit,
      'appLanguage': instance.appLanguage,
      'darkTheme': instance.darkTheme,
      'pureBlackTheme': instance.pureBlackTheme,
      'relativeTimestamp': instance.relativeTimestamp,
      'dateFormat': instance.dateFormat,
    };
