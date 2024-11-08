import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangadex_flutter/common/widgets/tab_chip_skeleton.dart';
import 'package:mangadex_flutter/features/search/search_provider.dart';
import 'package:mangadex_flutter/features/search/tabs/filter_result_tab.dart';
import 'package:mangadex_flutter/features/search/tabs/latest_tab.dart';
import 'package:mangadex_flutter/features/search/tabs/popular_tab.dart';
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
                TabChipSkeleton(
                    icon: Icons.favorite,
                    label: "Popular",
                    selected: currentTab == 0,
                    onSelected: (value) => setState(() => currentTab = 0)),
                const SizedBox(width: 8),
                TabChipSkeleton(
                    icon: Icons.new_releases,
                    label: "Latest",
                    selected: currentTab == 1,
                    onSelected: (value) => setState(() => currentTab = 1)),
                const SizedBox(width: 8),
                TabChipSkeleton(
                    icon: Icons.filter_alt,
                    label: "Filter",
                    selected: currentTab == 2,
                    onSelected: (value) => setState(() => currentTab = 2))
              ]),
              const SizedBox(height: 16),
              Expanded(
                  child: switch (currentTab) {
                0 => const PopularTab(),
                1 => const LatestTab(),
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
        : FilterResultTab(mangaFilterParams: mangaFilterParams);
  }
}
