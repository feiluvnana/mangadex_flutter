import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(centerTitle: false, title: const Text("Library"), actions: [
          IconButton(
              onPressed: () {
                context.go("/home/search");
              },
              icon: const Icon(Icons.search))
        ]),
        body: const Center(
            child: Text("The library is empty. Add some mangas to continue.")));
  }
}
