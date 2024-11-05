import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
        appBar: AppBar(
            leading:
                IconButton(onPressed: context.pop, icon: const Icon(Icons.arrow_back)),
            title: const Text("Appearance")),
        body: ListView(children: [
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Display",
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.primary))),
          const ListTile(
              title: Text("Items per row (TODO)"),
              subtitle: Text("Portrait: Default, Landscape: Default")),
          Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text("Categories",
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.primary))),
          const ListTile(
              title: Text("Edit categories (TODO)"), subtitle: Text("0 categories")),
          Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text("Global update",
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.primary))),
          const ListTile(
              title: Text("Automatic updates (TODO)"), subtitle: Text("Daily")),
          const ListTile(
              title: Text("Automatic updates device restrictions (TODO)"),
              subtitle: Text("Restrictions: Only on Wi-Fi")),
          const ListTile(
              title: Text("Skip updating entries (TODO)"), subtitle: Text("None")),
          const ListTile(
              title: Text("Categories (TODO)"),
              subtitle: Text("Include: All\nExclude: None")),
          ListTile(
              title: const Text("Automatically refresh metadata (TODO)"),
              subtitle:
                  const Text("Check for new cover and details when updating library"),
              trailing: Switch(value: false, onChanged: (value) {})),
        ]));
  }
}
