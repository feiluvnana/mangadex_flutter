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
      {@Default(<ContentRating>{ContentRating.safe, ContentRating.suggestive})
      Set<ContentRating> contentRating}) = _MangaFilterParams;
}

final filterMangaProvider = FutureProvider.autoDispose
    .family<List<Manga>, (int, MangaFilterParams)>((ref, params) async {
  final result = await MangadexApi.instance.mangas(
      limit: 20,
      offset: params.$1,
      contentRating: params.$2.contentRating.toList(),
      order: {"followedCount": "desc"});
  return result.data;
});
