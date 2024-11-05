import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex_flutter/features/settings/settings_provider.dart';

class GeneralPage extends ConsumerWidget {
  const GeneralPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (showUnreadCountOnUpdateIcon, confirmExit, appLanguage) = ref.watch(
        settingsProvider.select((state) =>
            (state.showUnreadCountOnUpdateIcon, state.confirmExit, state.appLanguage)));
    final settingsNotifier = ref.watch(settingsProvider.notifier);

    return Scaffold(
        appBar: AppBar(
            leading:
                IconButton(onPressed: context.pop, icon: const Icon(Icons.arrow_back)),
            title: const Text("General")),
        body: ListView(children: [
          ListTile(
              title: const Text("Show unread count on update icon (TODO)"),
              trailing: Switch(
                  value: showUnreadCountOnUpdateIcon,
                  onChanged: (value) =>
                      settingsNotifier.setShowUnreadCountOnUpdateIcon(value))),
          if (!kIsWeb) const ListTile(title: Text("Manage notifications")),
          ListTile(title: const Text("App language (TODO)"), subtitle: Text(appLanguage))
        ]));
  }
}
