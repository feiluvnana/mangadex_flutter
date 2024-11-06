import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex_flutter/core/services/api/mangadex_api.dart';
import 'package:mangadex_flutter/features/search/search_provider.dart';
import 'package:mangadexapi_flutter/mangadexapi_flutter.dart' as mgd;

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  int currentTab = 0;

  final popularPagingController =
      PagingController<int, mgd.Manga>(firstPageKey: 0, invisibleItemsThreshold: 20);
  final popularScrollController = ScrollController();

  final latestPagingController =
      PagingController<int, mgd.Manga>(firstPageKey: 0, invisibleItemsThreshold: 20);
  final latestScrollController = ScrollController();

  MangaFilterParams mangaFilterParams = const MangaFilterParams();

  @override
  void initState() {
    super.initState();
    popularPagingController.addPageRequestListener((pageKey) async {
      final mangas = await ref.read(popularMangaProvider(pageKey).future);
      if (mangas.length >= 20) {
        popularPagingController.appendPage(mangas, pageKey + 20);
      } else {
        popularPagingController.appendLastPage(mangas);
      }
    });
    latestPagingController.addPageRequestListener((pageKey) async {
      final mangas = await ref.read(latestMangaProvider(pageKey).future);
      if (mangas.length >= 20) {
        latestPagingController.appendPage(mangas, pageKey + 20);
      } else {
        latestPagingController.appendLastPage(mangas);
      }
    });
  }

  @override
  void dispose() {
    popularPagingController.dispose();
    popularScrollController.dispose();
    latestPagingController.dispose();
    latestScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: ScrollConfiguration.of(context)
            .copyWith(dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
        child: Scaffold(
            appBar: AppBar(
                leading: IconButton(
                    onPressed: context.pop, icon: const Icon(Icons.arrow_back)),
                forceMaterialTransparency: true,
                centerTitle: false,
                title: const Text("Search")),
            body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(children: [
                  Row(children: [
                    _ExpandableChip(
                        icon: Icons.favorite,
                        label: "Popular",
                        selected: currentTab == 0,
                        onSelected: (value) => setState(() => currentTab = 0)),
                    const SizedBox(width: 8),
                    _ExpandableChip(
                        icon: Icons.new_releases,
                        label: "Latest",
                        selected: currentTab == 1,
                        onSelected: (value) => setState(() => currentTab = 1)),
                    const SizedBox(width: 8),
                    _ExpandableChip(
                        icon: Icons.filter_alt,
                        label: "Filter",
                        selected: currentTab == 2,
                        onSelected: (value) => setState(() => currentTab = 2))
                  ]),
                  const SizedBox(height: 16),
                  Expanded(
                      child: switch (currentTab) {
                    0 => _popularTab(),
                    1 => _latestTab(),
                    2 => _filterTab(),
                    _ => const SizedBox.shrink()
                  })
                ])),
            floatingActionButton: currentTab == 2
                ? FloatingActionButton(
                    shape: const CircleBorder(),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => _FilterResultPage(mangaFilterParams)));
                    },
                    child: const Icon(Icons.search))
                : null));
  }

  void _updateContentRating(mgd.ContentRating contentRating, bool? value) {
    final newContentRating = value == false
        ? mangaFilterParams.contentRating.where((e) => e != contentRating).toSet()
        : (mangaFilterParams.contentRating.toSet()..add(contentRating));
    mangaFilterParams = mangaFilterParams.copyWith(contentRating: newContentRating);
    setState(() {});
  }

  Widget _popularTab() {
    return RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(popularMangaProvider);
          popularPagingController.refresh();
        },
        child: PagedGridView<int, mgd.Manga>(
            key: const PageStorageKey("popular"),
            scrollController: popularScrollController,
            pagingController: popularPagingController,
            showNewPageErrorIndicatorAsGridChild: false,
            showNewPageProgressIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / (sqrt(5) + 1),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
            builderDelegate: PagedChildBuilderDelegate<mgd.Manga>(
                itemBuilder: (context, manga, index) => _MangaCard(manga))));
  }

  Widget _latestTab() {
    return RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(latestMangaProvider);
          latestPagingController.refresh();
        },
        child: PagedGridView<int, mgd.Manga>(
            key: const PageStorageKey("latest"),
            scrollController: latestScrollController,
            pagingController: latestPagingController,
            showNewPageErrorIndicatorAsGridChild: false,
            showNewPageProgressIndicatorAsGridChild: false,
            showNoMoreItemsIndicatorAsGridChild: false,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 2 / (sqrt(5) + 1),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12),
            builderDelegate: PagedChildBuilderDelegate<mgd.Manga>(
                itemBuilder: (context, manga, index) => _MangaCard(manga))));
  }

  Widget _filterTab() {
    return Theme(
        data: Theme.of(context).copyWith(
            listTileTheme: ListTileThemeData(
                minTileHeight: 36,
                titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12))),
        child: ListView(children: [
          ExpansionTile(
              shape: const RoundedRectangleBorder(),
              title: const Text("Content rating",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              children: [
                ListTile(
                    leading: Checkbox(
                        value: mangaFilterParams.contentRating
                            .contains(mgd.ContentRating.safe),
                        onChanged: (value) {
                          _updateContentRating(mgd.ContentRating.safe, value);
                        }),
                    title: const Text("Safe")),
                ListTile(
                    leading: Checkbox(
                        value: mangaFilterParams.contentRating
                            .contains(mgd.ContentRating.suggestive),
                        onChanged: (value) {
                          _updateContentRating(mgd.ContentRating.suggestive, value);
                        }),
                    title: const Text("Suggestive")),
                ListTile(
                    leading: Checkbox(
                        value: mangaFilterParams.contentRating
                            .contains(mgd.ContentRating.erotica),
                        onChanged: (value) {
                          _updateContentRating(mgd.ContentRating.erotica, value);
                        }),
                    title: const Text("Erotica")),
                ListTile(
                    leading: Checkbox(
                        value: mangaFilterParams.contentRating
                            .contains(mgd.ContentRating.pornographic),
                        onChanged: (value) {
                          _updateContentRating(mgd.ContentRating.pornographic, value);
                        }),
                    title: const Text("Pornographic"))
              ])
        ]));
  }
}

class _FilterResultPage extends ConsumerStatefulWidget {
  final MangaFilterParams mangaFilterParams;
  const _FilterResultPage(this.mangaFilterParams);

  @override
  ConsumerState<_FilterResultPage> createState() => _FilterResultPageState();
}

class _FilterResultPageState extends ConsumerState<_FilterResultPage> {
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
            leading: IconButton(
                onPressed: Navigator.of(context).pop, icon: const Icon(Icons.arrow_back)),
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
                    itemBuilder: (context, manga, index) => _MangaCard(manga)))));
  }
}

class _ExpandableChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool selected;
  final void Function(bool) onSelected;
  const _ExpandableChip(
      {required this.selected,
      required this.onSelected,
      required this.label,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final labelStyle =
        theme.textTheme.labelLarge?.copyWith(color: theme.colorScheme.onPrimaryContainer);

    return FilterChip(
        showCheckmark: false,
        labelStyle: labelStyle,
        label: SizedBox(
            width: screenWidth * 0.15,
            child: AnimatedCrossFade(
                firstChild: Row(
                    mainAxisAlignment: MainAxisAlignment.center, children: [Text(label)]),
                secondChild: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(icon, size: 16, color: labelStyle?.color),
                  const SizedBox(width: 4),
                  Text(label)
                ]),
                crossFadeState:
                    !selected ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 100))),
        selected: selected,
        onSelected: onSelected);
  }
}

class _MangaCard extends StatelessWidget {
  final mgd.Manga manga;
  const _MangaCard(this.manga);

  Future<mgd.Cover?> _getCover() async {
    final coverRelationship = manga.relationships
        .firstWhereOrNull((e) => e.type == mgd.RelationshipType.cover_art);
    if (coverRelationship == null) return null;
    final cover = await MangadexApi.instance.cover(coverRelationship.id);
    return cover.data;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FutureBuilder<mgd.Cover?>(
        future: _getCover(),
        builder: (context, snapshot) {
          return Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: Stack(children: [
                Positioned.fill(
                    child: CachedNetworkImage(
                        imageUrl: snapshot.data?.url256 ?? "",
                        errorWidget: (context, url, error) => const Placeholder(),
                        fit: BoxFit.cover,
                        imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet)),
                Positioned.fill(
                    child: Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                      Colors.transparent,
                      theme.colorScheme.surface.withAlpha(222)
                    ])))),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(manga.attributes.title["en"] ?? "Unknown title",
                            style: theme.textTheme.titleSmall,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis)))
              ]));
        });
  }
}
