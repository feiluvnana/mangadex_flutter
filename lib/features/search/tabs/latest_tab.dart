import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex_flutter/common/widgets/manga_card_skeleton.dart';
import 'package:mangadex_flutter/features/search/search_provider.dart';
import 'package:mangadexapi_flutter/mangadexapi_flutter.dart' as mgd;

class LatestTab extends ConsumerStatefulWidget {
  const LatestTab({super.key});

  @override
  ConsumerState<LatestTab> createState() => _LatestTabState();
}

class _LatestTabState extends ConsumerState<LatestTab> {
  final pagingController =
      PagingController<int, mgd.Manga>(firstPageKey: 0, invisibleItemsThreshold: 20);
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) async {
      final mangas = await ref.read(latestMangaProvider(pageKey).future);
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
          ref.invalidate(latestMangaProvider);
          pagingController.refresh();
        },
        child: PagedGridView<int, mgd.Manga>(
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
                itemBuilder: (context, manga, index) => MangaCardSkeleton(
                    manga: manga,
                    onTap: () => context.go("/home/search/manga/${manga.id}")))));
  }
}
