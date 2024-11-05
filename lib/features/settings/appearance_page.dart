import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mangadex_flutter/features/settings/settings_provider.dart';

class AppearanceSettingsPage extends ConsumerWidget {
  const AppearanceSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final (darkTheme, pureBlackTheme, relativeTimestamp, dateFormat) = ref.watch(
        settingsProvider.select((state) => (
              state.darkTheme,
              state.pureBlackTheme,
              state.relativeTimestamp,
              state.dateFormat
            )));
    final settingsNotifier = ref.watch(settingsProvider.notifier);

    return Scaffold(
        appBar: AppBar(
            leading:
                IconButton(onPressed: context.pop, icon: const Icon(Icons.arrow_back)),
            title: const Text("Appearance")),
        body: ListView(children: [
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text("Theme",
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.primary))),
          ListTile(
              title: const Text("Dark theme"),
              trailing: Switch(
                  value: darkTheme,
                  onChanged: (value) => settingsNotifier.setDarkTheme(value))),
          if (darkTheme)
            ListTile(
                title: const Text("Pure black theme"),
                trailing: Switch(
                    value: pureBlackTheme,
                    onChanged: (value) => settingsNotifier.setPureBlackTheme(value))),
          Padding(
              padding: const EdgeInsets.only(left: 16, top: 16),
              child: Text("Timestamps",
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: theme.colorScheme.primary))),
          ListTile(
              title: const Text("Relative timestamp (TODO)"),
              subtitle: Text(relativeTimestamp)),
          ListTile(title: const Text("Date format (TODO)"), subtitle: Text(dateFormat))
        ]));
  }
}
