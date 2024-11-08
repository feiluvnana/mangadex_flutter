import 'package:cached_network_image/cached_network_image.dart';
import 'package:cached_network_image_platform_interface/cached_network_image_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangadex_flutter/main_provider.dart';
import 'package:mangadexapi_flutter/mangadexapi_flutter.dart' as mgd;

enum MangaCardSkeletonThumbnailSize { original, x256, x512 }

class MangaCardSkeleton extends ConsumerWidget {
  final mgd.Manga manga;
  final void Function() onTap;
  final MangaCardSkeletonThumbnailSize thumbnailSize;
  const MangaCardSkeleton(
      {required this.manga,
      required this.onTap,
      this.thumbnailSize = MangaCardSkeletonThumbnailSize.x256,
      super.key});

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
          return InkWell(
              onTap: onTap,
              child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  child: Stack(children: [
                    Positioned.fill(
                        child: CachedNetworkImage(
                            imageUrl: switch (thumbnailSize) {
                                  MangaCardSkeletonThumbnailSize.original =>
                                    snapshot.data?.url,
                                  MangaCardSkeletonThumbnailSize.x256 =>
                                    snapshot.data?.url256,
                                  MangaCardSkeletonThumbnailSize.x512 =>
                                    snapshot.data?.url512,
                                } ??
                                "",
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
