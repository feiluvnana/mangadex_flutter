import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex_flutter/features/search/search_provider.dart';
import 'package:mangadex_flutter/main_provider.dart';
import 'package:mangadexapi_flutter/mangadexapi_flutter.dart' as mgd;

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  int currentTab = 2;
  MangaFilterParams mangaFilterParams = const MangaFilterParams();
  bool isAddingFilter = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                0 => const _PopularTab(),
                1 => const _LatestTab(),
                2 => _filterTab(),
                _ => const SizedBox.shrink()
              })
            ])),
        floatingActionButton: currentTab == 2
            ? FloatingActionButton(
                shape: const CircleBorder(),
                onPressed: () {
                  isAddingFilter = !isAddingFilter;
                  setState(() {});
                },
                child: Icon(isAddingFilter ? Icons.search : Icons.edit))
            : null);
  }

  void _updateOriginalLanguage(Set<String> languages, bool? value) {
    assert(value != null);
    final newOriginalLanguage = value == false
        ? mangaFilterParams.originalLanguage
            .toSet()
            .where((e) => !languages.contains(e))
            .toSet()
        : (mangaFilterParams.originalLanguage.toSet()..addAll(languages));
    mangaFilterParams = mangaFilterParams.copyWith(originalLanguage: newOriginalLanguage);
    setState(() {});
  }

  void _updateContentRating(mgd.ContentRating contentRating, bool? value) {
    assert(value != null);
    final newContentRating = value == false
        ? mangaFilterParams.contentRating.toSet().where((e) => e != contentRating).toSet()
        : (mangaFilterParams.contentRating.toSet()..add(contentRating));
    mangaFilterParams = mangaFilterParams.copyWith(contentRating: newContentRating);
    setState(() {});
  }

  void _updatePublicationDemographic(
      mgd.PublicationDemographic publicationDemographic, bool? value) {
    assert(value != null);
    final newPublicationDemographic = value == false
        ? mangaFilterParams.publicationDemographic
            .toSet()
            .where((e) => e != publicationDemographic)
            .toSet()
        : (mangaFilterParams.publicationDemographic.toSet()..add(publicationDemographic));
    mangaFilterParams =
        mangaFilterParams.copyWith(publicationDemographic: newPublicationDemographic);
    setState(() {});
  }

  void _updateStatus(mgd.Status status, bool? value) {
    assert(value != null);
    final newStatus = value == false
        ? mangaFilterParams.status.toSet().where((e) => e != status).toSet()
        : (mangaFilterParams.status.toSet()..add(status));
    mangaFilterParams = mangaFilterParams.copyWith(status: newStatus);
    setState(() {});
  }

  // void _updateSort(String key, String value) {
  //   mangaFilterParams = mangaFilterParams.copyWith(sort: {key: value});
  //   setState(() {});
  // }

  void _updateIncludedTagsMode(String value) {
    mangaFilterParams = mangaFilterParams.copyWith(includedTagsMode: value);
    setState(() {});
  }

  void _updateExcludedTagsMode(String value) {
    mangaFilterParams = mangaFilterParams.copyWith(excludedTagsMode: value);
    setState(() {});
  }

  void _updateTags(mgd.Tag tag, bool? value) {
    final Map<mgd.Tag, bool> newTags = switch (value) {
      null => Map.from(mangaFilterParams.tags)..[tag] = false,
      true => Map.from(mangaFilterParams.tags)..[tag] = true,
      false => Map.from(mangaFilterParams.tags)..remove(tag)
    };
    mangaFilterParams = mangaFilterParams.copyWith(tags: newTags);
    setState(() {});
  }

  bool? _getTagStatus(mgd.Tag tag) {
    return mangaFilterParams.tags[tag] == null
        ? false
        : !mangaFilterParams.tags[tag]!
            ? null
            : true;
  }

  Widget _filterTab() {
    return isAddingFilter
        ? Theme(
            data: Theme.of(context).copyWith(
                listTileTheme: ListTileThemeData(
                    minTileHeight: 36,
                    titleTextStyle: Theme.of(context).textTheme.bodyMedium,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12))),
            child: ListView(children: [
              ExpansionTile(
                  title: const Text("Original language",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    ListTile(
                        leading: Checkbox(
                            value: mangaFilterParams.originalLanguage
                                .where((e) => {"ja", "ja-ro"}.contains(e))
                                .isNotEmpty,
                            onChanged: (value) {
                              _updateOriginalLanguage({"ja", "ja-ro"}, value);
                            }),
                        title: const Text("Japanese (Manga)")),
                    ListTile(
                        leading: Checkbox(
                            value: mangaFilterParams.originalLanguage
                                .where((e) => {"ko", "ko-ro"}.contains(e))
                                .isNotEmpty,
                            onChanged: (value) {
                              _updateOriginalLanguage({"ko", "ko-ro"}, value);
                            }),
                        title: const Text("Korean (Manhwa)")),
                    ListTile(
                        leading: Checkbox(
                            value: mangaFilterParams.originalLanguage
                                .where((e) => {"zh", "zh-ro"}.contains(e))
                                .isNotEmpty,
                            onChanged: (value) {
                              _updateOriginalLanguage({"zh", "zh-ro"}, value);
                            }),
                        title: const Text("Chinese (Manhua)"))
                  ]),
              ExpansionTile(
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
                  ]),
              ExpansionTile(
                  title: const Text("Publication demographic",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    ListTile(
                        leading: Checkbox(
                            value: mangaFilterParams.publicationDemographic
                                .contains(mgd.PublicationDemographic.shounen),
                            onChanged: (value) {
                              _updatePublicationDemographic(
                                  mgd.PublicationDemographic.shounen, value);
                            }),
                        title: const Text("Shounen")),
                    ListTile(
                        leading: Checkbox(
                            value: mangaFilterParams.publicationDemographic
                                .contains(mgd.PublicationDemographic.shoujo),
                            onChanged: (value) {
                              _updatePublicationDemographic(
                                  mgd.PublicationDemographic.shoujo, value);
                            }),
                        title: const Text("Shoujo")),
                    ListTile(
                        leading: Checkbox(
                            value: mangaFilterParams.publicationDemographic
                                .contains(mgd.PublicationDemographic.seinen),
                            onChanged: (value) {
                              _updatePublicationDemographic(
                                  mgd.PublicationDemographic.seinen, value);
                            }),
                        title: const Text("Seinen")),
                    ListTile(
                        leading: Checkbox(
                            value: mangaFilterParams.publicationDemographic
                                .contains(mgd.PublicationDemographic.josei),
                            onChanged: (value) {
                              _updatePublicationDemographic(
                                  mgd.PublicationDemographic.josei, value);
                            }),
                        title: const Text("Josei")),
                    ListTile(
                        leading: Checkbox(
                            value: mangaFilterParams.publicationDemographic
                                .contains(mgd.PublicationDemographic.none),
                            onChanged: (value) {
                              _updatePublicationDemographic(
                                  mgd.PublicationDemographic.none, value);
                            }),
                        title: const Text("Seinen"))
                  ]),
              ExpansionTile(
                  title:
                      const Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    ListTile(
                        leading: Checkbox(
                            value: mangaFilterParams.status.contains(mgd.Status.ongoing),
                            onChanged: (value) {
                              _updateStatus(mgd.Status.ongoing, value);
                            }),
                        title: const Text("Ongoing")),
                    ListTile(
                        leading: Checkbox(
                            value:
                                mangaFilterParams.status.contains(mgd.Status.completed),
                            onChanged: (value) {
                              _updateStatus(mgd.Status.completed, value);
                            }),
                        title: const Text("Completed")),
                    ListTile(
                        leading: Checkbox(
                            value: mangaFilterParams.status.contains(mgd.Status.hiatus),
                            onChanged: (value) {
                              _updateStatus(mgd.Status.hiatus, value);
                            }),
                        title: const Text("Hiatus")),
                    ListTile(
                        leading: Checkbox(
                            value:
                                mangaFilterParams.status.contains(mgd.Status.cancelled),
                            onChanged: (value) {
                              _updateStatus(mgd.Status.cancelled, value);
                            }),
                        title: const Text("Cancelled"))
                  ]),
              const ExpansionTile(
                  title:
                      Text("Sort (TODO)", style: TextStyle(fontWeight: FontWeight.bold))),
              ExpansionTile(
                  title: const Text("Tags mode",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  children: [
                    ListTile(
                        trailing: SizedBox(
                          width: 200,
                          child: SegmentedButton(
                              segments: const [
                                ButtonSegment(value: "AND", label: Text("AND")),
                                ButtonSegment(value: "OR", label: Text("OR"))
                              ],
                              selected: {
                                mangaFilterParams.includedTagsMode
                              },
                              onSelectionChanged: (value) {
                                _updateIncludedTagsMode(value.first);
                              }),
                        ),
                        title: const Text("Include tags mode")),
                    ListTile(
                        trailing: SizedBox(
                          width: 200,
                          child: SegmentedButton(
                              segments: const [
                                ButtonSegment(value: "AND", label: Text("AND")),
                                ButtonSegment(value: "OR", label: Text("OR"))
                              ],
                              selected: {
                                mangaFilterParams.excludedTagsMode
                              },
                              onSelectionChanged: (value) {
                                _updateExcludedTagsMode(value.first);
                              }),
                        ),
                        title: const Text("Exclude tags mode"))
                  ]),
              ExpansionTile(
                  title: const Text("Content",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  children: (ref.watch(contentTagsProvider).valueOrNull ?? [])
                      .map((e) => ListTile(
                          leading: Checkbox(
                              activeColor: _getTagStatus(e) == true
                                  ? null
                                  : Theme.of(context).colorScheme.error,
                              tristate: true,
                              value: _getTagStatus(e),
                              onChanged: (value) {
                                _updateTags(e, value);
                              }),
                          title: Text(e.attributes.name["en"] ?? "Unknown content tag")))
                      .toList()),
              ExpansionTile(
                  title:
                      const Text("Format", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: (ref.watch(formatTagsProvider).valueOrNull ?? [])
                      .map((e) => ListTile(
                          leading: Checkbox(
                              activeColor: _getTagStatus(e) == true
                                  ? null
                                  : Theme.of(context).colorScheme.error,
                              tristate: true,
                              value: _getTagStatus(e),
                              onChanged: (value) {
                                _updateTags(e, value);
                              }),
                          title: Text(e.attributes.name["en"] ?? "Unknown format tag")))
                      .toList()),
              ExpansionTile(
                  title:
                      const Text("Theme", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: (ref.watch(themeTagsProvider).valueOrNull ?? [])
                      .map((e) => ListTile(
                          leading: Checkbox(
                              activeColor: _getTagStatus(e) == true
                                  ? null
                                  : Theme.of(context).colorScheme.error,
                              tristate: true,
                              value: _getTagStatus(e),
                              onChanged: (value) {
                                _updateTags(e, value);
                              }),
                          title: Text(e.attributes.name["en"] ?? "Unknown theme tag")))
                      .toList()),
              ExpansionTile(
                  title:
                      const Text("Genre", style: TextStyle(fontWeight: FontWeight.bold)),
                  children: (ref.watch(genreTagsProvider).valueOrNull ?? [])
                      .map((e) => ListTile(
                          leading: Checkbox(
                              activeColor: _getTagStatus(e) == true
                                  ? null
                                  : Theme.of(context).colorScheme.error,
                              tristate: true,
                              value: _getTagStatus(e),
                              onChanged: (value) {
                                _updateTags(e, value);
                              }),
                          title: Text(e.attributes.name["en"] ?? "Unknown genre tag")))
                      .toList())
            ]))
        : _FilterResultPage(mangaFilterParams);
  }
}

class _LatestTab extends ConsumerStatefulWidget {
  const _LatestTab();

  @override
  ConsumerState<_LatestTab> createState() => _LatestTabState();
}

class _LatestTabState extends ConsumerState<_LatestTab> {
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
                itemBuilder: (context, manga, index) => _MangaCard(manga))));
  }
}

class _PopularTab extends ConsumerStatefulWidget {
  const _PopularTab();

  @override
  ConsumerState<_PopularTab> createState() => _PopularTabState();
}

class _PopularTabState extends ConsumerState<_PopularTab> {
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
                itemBuilder: (context, manga, index) => _MangaCard(manga))));
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

class _MangaCard extends ConsumerWidget {
  final mgd.Manga manga;
  const _MangaCard(this.manga);

  Future<mgd.Cover?> _getCover(WidgetRef ref) async {
    if (manga.coverArt == null) return null;
    return ref.read(coverProvider(manga.coverArt!.id).future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return FutureBuilder<mgd.Cover?>(
        future: _getCover(ref),
        builder: (context, snapshot) {
          return GestureDetector(
              onTap: () => context.go("/home/search/manga/${manga.id}"),
              child: Container(
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
                  ])));
        });
  }
}
