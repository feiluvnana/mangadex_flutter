import 'package:collection/collection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangadex_flutter/core/services/api/mangadex_api.dart';
import 'package:mangadexapi_flutter/mangadexapi_flutter.dart' as mgd;

final chapterProvider = FutureProvider.family<mgd.Chapter, String>((ref, id) async {
  return MangadexApi.instance.chapter(id).then((res) => res.data);
});

final atHomeProvider = FutureProvider.family<mgd.AtHome, String>((ref, chapterId) async {
  return MangadexApi.instance.atHome(chapterId);
});

final authorProvider = FutureProvider.family<mgd.Author, String>((ref, id) async {
  return MangadexApi.instance.author(id).then((res) => res.data);
});

final mangaProvider = FutureProvider.family<mgd.Manga, String>((ref, id) async {
  return MangadexApi.instance.manga(id).then((res) => res.data);
});

final coverProvider = FutureProvider.family<mgd.Cover, String>((ref, id) async {
  return MangadexApi.instance.cover(id).then((res) => res.data);
});

final scanlationGroupProvider =
    FutureProvider.family<mgd.ScanlationGroup, String>((ref, id) async {
  return MangadexApi.instance.scanlationGroup(id).then((res) => res.data);
});

final tagsProvider = FutureProvider.autoDispose<List<mgd.Tag>>((ref) async {
  return MangadexApi.instance.tags().then((res) => res.data.sorted((t1, t2) =>
      (t1.attributes.name["en"] ?? "").compareTo(t2.attributes.name["en"] ?? "")));
});

final themeTagsProvider = FutureProvider.autoDispose<List<mgd.Tag>>((ref) async {
  return ref.watch(tagsProvider.future).then(
      (tags) => tags.where((e) => e.attributes.group == mgd.TagGroup.theme).toList());
});

final genreTagsProvider = FutureProvider.autoDispose<List<mgd.Tag>>((ref) async {
  return ref.watch(tagsProvider.future).then(
      (tags) => tags.where((e) => e.attributes.group == mgd.TagGroup.genre).toList());
});

final formatTagsProvider = FutureProvider.autoDispose<List<mgd.Tag>>((ref) async {
  return ref.watch(tagsProvider.future).then(
      (tags) => tags.where((e) => e.attributes.group == mgd.TagGroup.format).toList());
});

final contentTagsProvider = FutureProvider.autoDispose<List<mgd.Tag>>((ref) async {
  return ref.watch(tagsProvider.future).then(
      (tags) => tags.where((e) => e.attributes.group == mgd.TagGroup.content).toList());
});
