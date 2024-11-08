import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex_flutter/common/widgets/manga_page_skeleton.dart';
import 'package:mangadex_flutter/main_provider.dart';
import 'package:mangadexapi_flutter/mangadexapi_flutter.dart' as mgd;

class FilterResultMangaPage extends ConsumerStatefulWidget {
  final String mangaId;
  const FilterResultMangaPage({super.key, required this.mangaId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterResultMangaPageState();
}

class _FilterResultMangaPageState extends ConsumerState<FilterResultMangaPage> {
  Future<(mgd.Manga, mgd.Author?, mgd.Cover?)> _getData() async {
    final manga = await ref.read(mangaProvider(widget.mangaId).future);
    final authorFuture = manga.author == null
        ? Future.value(null)
        : ref.read(authorProvider(manga.author!.id).future);
    final coverFuture = manga.coverArt == null
        ? Future.value(null)
        : ref.read(coverProvider(manga.coverArt!.id).future);
    final result = await (authorFuture, coverFuture).wait;
    return (manga, result.$1, result.$2);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<(mgd.Manga, mgd.Author?, mgd.Cover?)>(
        future: _getData(),
        builder: (context, snapshot) {
          final manga = snapshot.data?.$1;
          final author = snapshot.data?.$2;
          final cover = snapshot.data?.$3;

          if (manga == null) {
            return Scaffold(
              body: CustomScrollView(slivers: [
                SliverAppBar.large(
                    leading: IconButton(
                        onPressed: context.pop, icon: const Icon(Icons.arrow_back))),
                SliverFillRemaining(
                    child: Center(
                        child: snapshot.hasError
                            ? Text(snapshot.error.toString())
                            : const CircularProgressIndicator()))
              ]),
            );
          }
          return MangaPageSkeleton(
              mangaTitle: manga.attributes.title["en"],
              mangaDescription: manga.attributes.description["en"],
              mangaAuthor: author?.attributes.name,
              mangaStatus: manga.attributes.status,
              mangaCoverUrl: cover?.url,
              mangaTags: manga.attributes.tags
                  .map((e) => e.attributes.name["en"] ?? "Unknown tag")
                  .toList(),
              onAuthorTap: () {},
              onFavoriteTap: () {},
              onMoreTap: () {});
        });
  }
}
