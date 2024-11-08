import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex_flutter/common/widgets/manga_card_skeleton.dart';
import 'package:mangadex_flutter/features/search/search_provider.dart';
import 'package:mangadexapi_flutter/mangadexapi_flutter.dart' as mgd;

class FilterResultTab extends ConsumerStatefulWidget {
  final MangaFilterParams mangaFilterParams;
  const FilterResultTab({required this.mangaFilterParams, super.key});

  @override
  ConsumerState<FilterResultTab> createState() => _FilterResultPageState();
}

class _FilterResultPageState extends ConsumerState<FilterResultTab> {
  final pagingController =
      PagingController<int, mgd.Manga>(firstPageKey: 0, invisibleItemsThreshold: 20);
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) async {
      final mangas =
          await ref.read(filterMangaProvider((pageKey, widget.mangaFilterParams)).future);
      if (mangas.length < 20) {
        pagingController.appendLastPage(mangas);
      } else {
        pagingController.appendPage(mangas, pageKey + 20);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            centerTitle: false,
            title: const Text("Filter results")),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PagedGridView<int, mgd.Manga>(
                pagingController: pagingController,
                scrollController: scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2 / (sqrt(5) + 1),
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12),
                builderDelegate: PagedChildBuilderDelegate<mgd.Manga>(
                    itemBuilder: (context, manga, index) => MangaCardSkeleton(
                        manga: manga,
                        onTap: () => context.go("/home/search/manga/${manga.id}"))))));
  }
}
