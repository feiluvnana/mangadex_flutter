import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex_flutter/features/search/search_provider.dart';
import 'package:mangadex_flutter/features/search/widgets/search_result_manga_card.dart';
import 'package:mangadexapi_flutter/mangadexapi_flutter.dart' as mgd;

class PopularTab extends ConsumerStatefulWidget {
  const PopularTab();

  @override
  ConsumerState<PopularTab> createState() => _PopularTabState();
}

class _PopularTabState extends ConsumerState<PopularTab> {
  final pagingController =
      PagingController<int, mgd.Manga>(firstPageKey: 0, invisibleItemsThreshold: 20);
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) async {
      final mangas = await ref.read(popularMangaProvider(pageKey).future);
      if (mangas.length < 20) {
        pagingController.appendLastPage(mangas);
      } else {
        pagingController.appendPage(mangas, pageKey + 20);
      }
    });
  }

  @override
  void dispose() {
    pagingController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(popularMangaProvider);
          pagingController.refresh();
        },
        child: PagedGridView<int, mgd.Manga>(
            key: const PageStorageKey("popular"),
            scrollController: scrollController,
            pagingController: pagingController,
            showNewPageErrorIndicatorAsGridChild: false,
            showNewPageProgressIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / (sqrt(5) + 1),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
            builderDelegate: PagedChildBuilderDelegate<mgd.Manga>(
                itemBuilder: (context, manga, index) =>
                    SearchResultMangaCard(manga: manga))));
  }
}
