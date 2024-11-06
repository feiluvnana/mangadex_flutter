// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MangaFilterParams {
  Set<ContentRating> get contentRating => throw _privateConstructorUsedError;

  /// Create a copy of MangaFilterParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MangaFilterParamsCopyWith<MangaFilterParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MangaFilterParamsCopyWith<$Res> {
  factory $MangaFilterParamsCopyWith(
          MangaFilterParams value, $Res Function(MangaFilterParams) then) =
      _$MangaFilterParamsCopyWithImpl<$Res, MangaFilterParams>;
  @useResult
  $Res call({Set<ContentRating> contentRating});
}

/// @nodoc
class _$MangaFilterParamsCopyWithImpl<$Res, $Val extends MangaFilterParams>
    implements $MangaFilterParamsCopyWith<$Res> {
  _$MangaFilterParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MangaFilterParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentRating = null,
  }) {
    return _then(_value.copyWith(
      contentRating: null == contentRating
          ? _value.contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as Set<ContentRating>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MangaFilterParamsImplCopyWith<$Res>
    implements $MangaFilterParamsCopyWith<$Res> {
  factory _$$MangaFilterParamsImplCopyWith(_$MangaFilterParamsImpl value,
          $Res Function(_$MangaFilterParamsImpl) then) =
      __$$MangaFilterParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Set<ContentRating> contentRating});
}

/// @nodoc
class __$$MangaFilterParamsImplCopyWithImpl<$Res>
    extends _$MangaFilterParamsCopyWithImpl<$Res, _$MangaFilterParamsImpl>
    implements _$$MangaFilterParamsImplCopyWith<$Res> {
  __$$MangaFilterParamsImplCopyWithImpl(_$MangaFilterParamsImpl _value,
      $Res Function(_$MangaFilterParamsImpl) _then)
      : super(_value, _then);

  /// Create a copy of MangaFilterParams
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? contentRating = null,
  }) {
    return _then(_$MangaFilterParamsImpl(
      contentRating: null == contentRating
          ? _value._contentRating
          : contentRating // ignore: cast_nullable_to_non_nullable
              as Set<ContentRating>,
    ));
  }
}

/// @nodoc

class _$MangaFilterParamsImpl implements _MangaFilterParams {
  const _$MangaFilterParamsImpl(
      {final Set<ContentRating> contentRating = const <ContentRating>{
        ContentRating.safe,
        ContentRating.suggestive
      }})
      : _contentRating = contentRating;

  final Set<ContentRating> _contentRating;
  @override
  @JsonKey()
  Set<ContentRating> get contentRating {
    if (_contentRating is EqualUnmodifiableSetView) return _contentRating;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_contentRating);
  }

  @override
  String toString() {
    return 'MangaFilterParams(contentRating: $contentRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MangaFilterParamsImpl &&
            const DeepCollectionEquality()
                .equals(other._contentRating, _contentRating));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_contentRating));

  /// Create a copy of MangaFilterParams
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MangaFilterParamsImplCopyWith<_$MangaFilterParamsImpl> get copyWith =>
      __$$MangaFilterParamsImplCopyWithImpl<_$MangaFilterParamsImpl>(
          this, _$identity);
}

abstract class _MangaFilterParams implements MangaFilterParams {
  const factory _MangaFilterParams({final Set<ContentRating> contentRating}) =
      _$MangaFilterParamsImpl;

  @override
  Set<ContentRating> get contentRating;

  /// Create a copy of MangaFilterParams
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MangaFilterParamsImplCopyWith<_$MangaFilterParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
