import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mangadex_flutter/core/services/api/mangadex_api.dart';
import 'package:mangadexapi_flutter/mangadexapi_flutter.dart';

part 'search_provider.freezed.dart';

final popularMangaProvider =
    FutureProvider.autoDispose.family<List<Manga>, int>((ref, offset) async {
  final result = await MangadexApi.instance
      .mangas(limit: 20, offset: offset, order: {"followedCount": "desc"});
  return result.data;
});

final latestMangaProvider =
    FutureProvider.autoDispose.family<List<Manga>, int>((ref, offset) async {
  final result = await MangadexApi.instance
      .mangas(limit: 20, offset: offset, order: {"latestUploadedChapter": "desc"});
  return result.data;
});

@freezed
class MangaFilterParams with _$MangaFilterParams {
  const factory MangaFilterParams(
      {@Default(true) bool hasAvailableChapters,
      @Default({}) Set<String> originalLanguage,
      @Default({ContentRating.safe, ContentRating.suggestive})
      Set<ContentRating> contentRating,
      @Default({}) Set<PublicationDemographic> publicationDemographic,
      @Default({}) Set<Status> status,
      @Default({}) Map<String, String> sort,
      @Default("AND") String includedTagsMode,
      @Default("OR") String excludedTagsMode,
      @Default(<Tag, bool>{}) Map<Tag, bool> tags}) = _MangaFilterParams;
}

final filterMangaProvider = FutureProvider.autoDispose
    .family<List<Manga>, (int, MangaFilterParams)>((ref, params) async {
  final result = await MangadexApi.instance.mangas(
      limit: 20,
      offset: params.$1,
      publicationDemographic: params.$2.publicationDemographic.toList(),
      contentRating: params.$2.contentRating.toList(),
      originalLanguage: params.$2.originalLanguage.toList(),
      status: params.$2.status.toList(),
      order: params.$2.sort,
      includedTags:
          params.$2.tags.entries.where((e) => e.value).map((e) => e.key.id).toList(),
      excludedTags:
          params.$2.tags.entries.where((e) => !e.value).map((e) => e.key.id).toList(),
      includedTagsMode: params.$2.includedTagsMode,
      excludedTagsMode: params.$2.excludedTagsMode,
      hasAvailableChapters: params.$2.hasAvailableChapters ? 1 : 0);
  return result.data;
});
