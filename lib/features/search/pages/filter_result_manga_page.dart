import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex_flutter/main_provider.dart';
import 'package:mangadexapi_flutter/mangadexapi_flutter.dart' as mgd;

class FilterResultMangaPage extends ConsumerStatefulWidget {
  final String mangaId;
  const FilterResultMangaPage({super.key, required this.mangaId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FilterResultMangaPageState();
}

class _FilterResultMangaPageState extends ConsumerState<FilterResultMangaPage> {
  Future<mgd.Manga> _getManga() async {
    return ref.read(mangaProvider(widget.mangaId).future);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<mgd.Manga>(
            future: _getManga(),
            builder: (context, snapshot) {
              final manga = snapshot.data;
              if (manga == null) {
                return CustomScrollView(slivers: [
                  SliverAppBar.large(
                      leading: IconButton(
                          onPressed: context.pop, icon: const Icon(Icons.arrow_back))),
                  SliverFillRemaining(
                      child: Center(
                          child: snapshot.hasError
                              ? Text(snapshot.error.toString())
                              : const CircularProgressIndicator()))
                ]);
              }
              return CustomScrollView(slivers: [
                SliverAppBar(
                    pinned: true,
                    expandedHeight: MediaQuery.sizeOf(context).height / 3,
                    flexibleSpace: _FlexibleSpaceBar(manga: manga),
                    actions: [
                      IconButton(onPressed: () {}, icon: const Icon(Icons.favorite)),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
                    ]),
                SliverList.builder(
                    itemBuilder: (context, index) => const Text("1"), itemCount: 50)
              ]);
            }));
  }
}

class _FlexibleSpaceBar extends ConsumerWidget {
  final mgd.Manga manga;
  const _FlexibleSpaceBar({required this.manga});

  Future<mgd.Cover?> _getCover(WidgetRef ref) async {
    if (manga.coverArt == null) return null;
    return ref.read(coverProvider(manga.coverArt!.id).future);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
    final deltaExtent = settings.maxExtent - settings.minExtent;
    final opacity = (1.0 - (settings.maxExtent - settings.currentExtent) / deltaExtent)
        .clamp(0.0, 1.0);

    return SizedBox(
        height: settings.maxExtent,
        width: MediaQuery.sizeOf(context).width,
        child: Stack(children: [
          Positioned.fill(
              child: FutureBuilder<mgd.Cover?>(
                  future: _getCover(ref),
                  builder: (context, snapshot) => Image(
                      opacity: AlwaysStoppedAnimation(opacity / 4),
                      image: CachedNetworkImageProvider(snapshot.data?.url ?? "",
                          imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet),
                      fit: BoxFit.cover))),
          Positioned.fill(
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom: 16,
                      top: 16 + kToolbarHeight * opacity,
                      left: 56 - 40 * opacity,
                      right: 56 - 40 * opacity),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(manga.attributes.title["en"] ?? "Unknown title",
                        style: theme.textTheme.titleLarge),
                    if (opacity > 0.1)
                      Opacity(
                          opacity: opacity,
                          child: Text(manga.attributes.status.toString(),
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w200))),
                    if (opacity > 0.1)
                      Expanded(
                          child: Opacity(
                              opacity: opacity,
                              child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                      color:
                                          theme.colorScheme.surfaceBright.withAlpha(128)),
                                  child: SingleChildScrollView(
                                      child: Text(
                                          manga.attributes.description["en"] ?? "",
                                          style: theme.textTheme.bodyMedium?.copyWith(
                                              fontWeight: FontWeight.w200)))))),
                    if (opacity > 0.2)
                      Opacity(
                          opacity: (1 + (opacity - 1) * 1.5).clamp(0.0, 1.0),
                          child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                  children: manga.attributes.tags
                                      .map((e) => Container(
                                          margin: const EdgeInsets.only(right: 4),
                                          padding:
                                              const EdgeInsets.symmetric(horizontal: 4),
                                          decoration: BoxDecoration(
                                              color: theme.colorScheme.primaryContainer,
                                              borderRadius: BorderRadius.circular(20)),
                                          child: Text(e.attributes.name["en"] ?? "",
                                              style: theme.textTheme.labelLarge?.copyWith(
                                                  color: theme
                                                      .colorScheme.onPrimaryContainer))))
                                      .toList())))
                  ])))
        ]));
  }
}
