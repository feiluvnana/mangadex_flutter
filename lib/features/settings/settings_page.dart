import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(onPressed: context.pop, icon: const Icon(Icons.arrow_back)),
            title: const Text("Settings")),
        body: ListView(children: [
          ListTile(
              onTap: () => context.go("/home/settings/general"),
              leading: const Icon(Icons.tune),
              title: const Text("General"),
              subtitle: const Text("App language, notifications")),
        ]));
  }
}
