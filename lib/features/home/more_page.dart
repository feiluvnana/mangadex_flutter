import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MorePage extends ConsumerWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(padding: EdgeInsets.zero, children: [
      const Divider(),
      ListTile(
          leading: const Icon(Icons.cloud_off),
          title: const Text("Downloaded only"),
          subtitle: const Text("Filters all entries in your library"),
          trailing: Switch(value: true, onChanged: (value) {})),
      ListTile(
          leading: const Icon(Icons.history_toggle_off),
          title: const Text("Incognito mode"),
          subtitle: const Text("Pause reading history"),
          trailing: Switch(value: true, onChanged: (value) {})),
      const Divider(),
      const ListTile(
          leading: Icon(Icons.download), title: Text("Download queue")),
      const ListTile(leading: Icon(Icons.category), title: Text("Categories")),
      const ListTile(
          leading: Icon(Icons.query_stats), title: Text("Statistics")),
      const ListTile(
          leading: Icon(Icons.settings_backup_restore),
          title: Text("Backup and restore")),
      const Divider(),
      const ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
      const ListTile(leading: Icon(Icons.info), title: Text("About")),
      const ListTile(leading: Icon(Icons.help), title: Text("Help")),
    ]);
  }
}
