import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mangadex_flutter/common/widgets.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const CachedImage(imageUrl: "https://picsum.photos/200/300", cacheKey: "def");
  }
}
