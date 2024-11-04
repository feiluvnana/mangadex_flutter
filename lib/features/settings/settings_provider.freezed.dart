// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsState _$SettingsStateFromJson(Map<String, dynamic> json) {
  return _SettingsState.fromJson(json);
}

/// @nodoc
mixin _$SettingsState {
  bool get downloadedOnly => throw _privateConstructorUsedError;
  bool get incognitoMode => throw _privateConstructorUsedError;
  bool get showUnreadCountOnUpdateIcon => throw _privateConstructorUsedError;
  bool get confirmExit => throw _privateConstructorUsedError;
  String get appLanguage => throw _privateConstructorUsedError;

  /// Serializes this SettingsState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
  @useResult
  $Res call(
      {bool downloadedOnly,
      bool incognitoMode,
      bool showUnreadCountOnUpdateIcon,
      bool confirmExit,
      String appLanguage});
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadedOnly = null,
    Object? incognitoMode = null,
    Object? showUnreadCountOnUpdateIcon = null,
    Object? confirmExit = null,
    Object? appLanguage = null,
  }) {
    return _then(_value.copyWith(
      downloadedOnly: null == downloadedOnly
          ? _value.downloadedOnly
          : downloadedOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      incognitoMode: null == incognitoMode
          ? _value.incognitoMode
          : incognitoMode // ignore: cast_nullable_to_non_nullable
              as bool,
      showUnreadCountOnUpdateIcon: null == showUnreadCountOnUpdateIcon
          ? _value.showUnreadCountOnUpdateIcon
          : showUnreadCountOnUpdateIcon // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmExit: null == confirmExit
          ? _value.confirmExit
          : confirmExit // ignore: cast_nullable_to_non_nullable
              as bool,
      appLanguage: null == appLanguage
          ? _value.appLanguage
          : appLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsStateImplCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$SettingsStateImplCopyWith(
          _$SettingsStateImpl value, $Res Function(_$SettingsStateImpl) then) =
      __$$SettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool downloadedOnly,
      bool incognitoMode,
      bool showUnreadCountOnUpdateIcon,
      bool confirmExit,
      String appLanguage});
}

/// @nodoc
class __$$SettingsStateImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsStateImpl>
    implements _$$SettingsStateImplCopyWith<$Res> {
  __$$SettingsStateImplCopyWithImpl(
      _$SettingsStateImpl _value, $Res Function(_$SettingsStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? downloadedOnly = null,
    Object? incognitoMode = null,
    Object? showUnreadCountOnUpdateIcon = null,
    Object? confirmExit = null,
    Object? appLanguage = null,
  }) {
    return _then(_$SettingsStateImpl(
      downloadedOnly: null == downloadedOnly
          ? _value.downloadedOnly
          : downloadedOnly // ignore: cast_nullable_to_non_nullable
              as bool,
      incognitoMode: null == incognitoMode
          ? _value.incognitoMode
          : incognitoMode // ignore: cast_nullable_to_non_nullable
              as bool,
      showUnreadCountOnUpdateIcon: null == showUnreadCountOnUpdateIcon
          ? _value.showUnreadCountOnUpdateIcon
          : showUnreadCountOnUpdateIcon // ignore: cast_nullable_to_non_nullable
              as bool,
      confirmExit: null == confirmExit
          ? _value.confirmExit
          : confirmExit // ignore: cast_nullable_to_non_nullable
              as bool,
      appLanguage: null == appLanguage
          ? _value.appLanguage
          : appLanguage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SettingsStateImpl implements _SettingsState {
  _$SettingsStateImpl(
      {required this.downloadedOnly,
      required this.incognitoMode,
      required this.showUnreadCountOnUpdateIcon,
      required this.confirmExit,
      required this.appLanguage});

  factory _$SettingsStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsStateImplFromJson(json);

  @override
  final bool downloadedOnly;
  @override
  final bool incognitoMode;
  @override
  final bool showUnreadCountOnUpdateIcon;
  @override
  final bool confirmExit;
  @override
  final String appLanguage;

  @override
  String toString() {
    return 'SettingsState(downloadedOnly: $downloadedOnly, incognitoMode: $incognitoMode, showUnreadCountOnUpdateIcon: $showUnreadCountOnUpdateIcon, confirmExit: $confirmExit, appLanguage: $appLanguage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsStateImpl &&
            (identical(other.downloadedOnly, downloadedOnly) ||
                other.downloadedOnly == downloadedOnly) &&
            (identical(other.incognitoMode, incognitoMode) ||
                other.incognitoMode == incognitoMode) &&
            (identical(other.showUnreadCountOnUpdateIcon,
                    showUnreadCountOnUpdateIcon) ||
                other.showUnreadCountOnUpdateIcon ==
                    showUnreadCountOnUpdateIcon) &&
            (identical(other.confirmExit, confirmExit) ||
                other.confirmExit == confirmExit) &&
            (identical(other.appLanguage, appLanguage) ||
                other.appLanguage == appLanguage));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, downloadedOnly, incognitoMode,
      showUnreadCountOnUpdateIcon, confirmExit, appLanguage);

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      __$$SettingsStateImplCopyWithImpl<_$SettingsStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsStateImplToJson(
      this,
    );
  }
}

abstract class _SettingsState implements SettingsState {
  factory _SettingsState(
      {required final bool downloadedOnly,
      required final bool incognitoMode,
      required final bool showUnreadCountOnUpdateIcon,
      required final bool confirmExit,
      required final String appLanguage}) = _$SettingsStateImpl;

  factory _SettingsState.fromJson(Map<String, dynamic> json) =
      _$SettingsStateImpl.fromJson;

  @override
  bool get downloadedOnly;
  @override
  bool get incognitoMode;
  @override
  bool get showUnreadCountOnUpdateIcon;
  @override
  bool get confirmExit;
  @override
  String get appLanguage;

  /// Create a copy of SettingsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
