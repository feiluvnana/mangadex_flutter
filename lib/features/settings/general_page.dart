import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex_flutter/features/settings/settings_provider.dart';

class GeneralPage extends ConsumerWidget {
  const GeneralPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsState = ref.watch(settingsProvider);
    final settingsNotifier = ref.watch(settingsProvider.notifier);

    return Scaffold(
        appBar: AppBar(
            leading: IconButton(onPressed: context.pop, icon: const Icon(Icons.arrow_back)),
            title: const Text("General")),
        body: ListView(children: [
          ListTile(
              title: const Text("Show unread count on update icon"),
              trailing: Switch(
                  value: settingsState.showUnreadCountOnUpdateIcon,
                  onChanged: (value) => settingsNotifier.setShowUnreadCountOnUpdateIcon(value))),
          if (!kIsWeb && Platform.isAndroid)
            ListTile(
                title: const Text("Confirm exit"),
                subtitle: const Text("Double tap the Back button to exit"),
                trailing: Switch(
                    value: settingsState.confirmExit,
                    onChanged: (value) => settingsNotifier.setConfirmExit(value))),
          if (!kIsWeb) const ListTile(title: Text("Manage notifications")),
          ListTile(title: const Text("App language"), subtitle: Text(settingsState.appLanguage))
        ]));
  }
}
