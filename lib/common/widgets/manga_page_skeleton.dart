import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangadex_flutter/common/widgets/tag_chip_skeleton.dart';
import 'package:mangadexapi_flutter/mangadexapi_flutter.dart' as mgd;

class MangaPageSkeleton extends ConsumerStatefulWidget {
  final String? mangaTitle;
  final String? mangaDescription;
  final String? mangaAuthor;
  final mgd.Status? mangaStatus;
  final String? mangaCoverUrl;
  final List<String>? mangaTags;
  final void Function()? onAuthorTap;
  final void Function()? onFavoriteTap;
  final void Function()? onMoreTap;

  const MangaPageSkeleton(
      {required this.mangaTitle,
      required this.mangaDescription,
      required this.mangaAuthor,
      required this.mangaStatus,
      required this.mangaCoverUrl,
      required this.mangaTags,
      this.onAuthorTap,
      this.onFavoriteTap,
      this.onMoreTap,
      super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MangaPageSkeletonState();
}

class _MangaPageSkeletonState extends ConsumerState<MangaPageSkeleton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: [
      SliverAppBar(
          pinned: true,
          stretch: true,
          expandedHeight: MediaQuery.sizeOf(context).height / 3,
          flexibleSpace: _FlexibleSpaceBar(
              mangaTitle: widget.mangaTitle,
              mangaDescription: widget.mangaDescription,
              mangaAuthor: widget.mangaAuthor,
              mangaStatus: widget.mangaStatus,
              mangaTags: widget.mangaTags,
              mangaCoverUrl: widget.mangaCoverUrl,
              onAuthorTap: widget.onAuthorTap),
          actions: [
            IconButton(onPressed: widget.onFavoriteTap, icon: const Icon(Icons.favorite)),
            IconButton(onPressed: widget.onMoreTap, icon: const Icon(Icons.more_vert))
          ]),
      SliverList.builder(itemBuilder: (context, index) => const Text("1"), itemCount: 50)
    ]));
  }
}

class _FlexibleSpaceBar extends ConsumerWidget {
  final String? mangaTitle;
  final String? mangaDescription;
  final String? mangaAuthor;
  final mgd.Status? mangaStatus;
  final List<String>? mangaTags;
  final String? mangaCoverUrl;
  final void Function()? onAuthorTap;

  const _FlexibleSpaceBar(
      {required this.mangaTitle,
      required this.mangaDescription,
      required this.mangaAuthor,
      required this.mangaStatus,
      required this.mangaTags,
      required this.mangaCoverUrl,
      this.onAuthorTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
    final deltaExtent = settings.maxExtent - settings.minExtent;
    final opacity = (1.0 - (settings.maxExtent - settings.currentExtent) / deltaExtent)
        .clamp(0.0, 1.0);
    final opacityOfNonTitle = (1 + (opacity - 1) * 1.5).clamp(0.0, 1.0);

    return LayoutBuilder(builder: (context, constraints) {
      final backgroundScale =
          max((constraints.maxHeight / settings.maxExtent) - 1, 0) / 2 + 1.0;

      return Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
          height: constraints.maxHeight,
          width: MediaQuery.sizeOf(context).width,
          child: Stack(children: [
            Positioned.fill(
                child: Transform.scale(
                    scale: backgroundScale,
                    child: mangaCoverUrl != null
                        ? Image(
                            opacity: AlwaysStoppedAnimation(opacity / 4),
                            image: CachedNetworkImageProvider(mangaCoverUrl!,
                                imageRenderMethodForWeb: ImageRenderMethodForWeb.HttpGet),
                            fit: BoxFit.cover)
                        : const SizedBox())),
            Positioned.fill(
                child: Padding(
                    padding: EdgeInsets.only(
                        bottom: 16,
                        top: 16 + kToolbarHeight * opacity,
                        left: 56 - 40 * opacity,
                        right: 56 - 40 * opacity),
                    child:
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(mangaTitle ?? "Unknown title",
                          style: theme.textTheme.titleLarge),
                      if (opacityOfNonTitle > 0)
                        Opacity(
                            opacity: opacityOfNonTitle,
                            child: switch (mangaStatus) {
                              mgd.Status.ongoing => Row(children: [
                                  const Icon(Icons.play_arrow_rounded, size: 20),
                                  Text("Ongoing", style: theme.textTheme.bodyMedium)
                                ]),
                              mgd.Status.completed => Row(children: [
                                  const Icon(Icons.check_rounded, size: 20),
                                  Text("Completed", style: theme.textTheme.bodyMedium)
                                ]),
                              mgd.Status.hiatus => Row(children: [
                                  const Icon(Icons.pause_rounded, size: 20),
                                  Text("Hiatus", style: theme.textTheme.bodyMedium)
                                ]),
                              mgd.Status.cancelled => Row(children: [
                                  const Icon(Icons.cancel_rounded, size: 20),
                                  Text("Cancelled", style: theme.textTheme.bodyMedium)
                                ]),
                              null => const SizedBox()
                            }),
                      if (opacityOfNonTitle > 0)
                        Opacity(
                            opacity: opacityOfNonTitle,
                            child: InkWell(
                              onTap: onAuthorTap,
                              child: Text(mangaAuthor ?? "Unknown author",
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(fontStyle: FontStyle.italic)),
                            )),
                      if (opacityOfNonTitle > 0)
                        Expanded(
                            child: Opacity(
                                opacity: opacityOfNonTitle,
                                child: Container(
                                    clipBehavior: Clip.antiAlias,
                                    margin: const EdgeInsets.symmetric(vertical: 8),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: theme.colorScheme.surfaceBright
                                            .withAlpha(200)),
                                    child: SingleChildScrollView(
                                        child: Text(
                                            mangaDescription ?? "Unknown description",
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                                fontWeight: FontWeight.w200)))))),
                      if (opacityOfNonTitle > 0)
                        Opacity(
                            opacity: opacityOfNonTitle,
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: mangaTags != null
                                    ? Row(
                                        children: mangaTags!
                                            .map((e) => TagChipSkeleton(tagName: e))
                                            .toList())
                                    : const SizedBox())),
                    ])))
          ]));
    });
  }
}
