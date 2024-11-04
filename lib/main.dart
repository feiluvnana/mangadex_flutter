import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangadex_flutter/core/services/local/sp_service.dart';
import 'package:mangadex_flutter/features/home/home_page.dart';
import 'package:mangadex_flutter/features/settings/general_page.dart';
import 'package:mangadex_flutter/features/settings/settings_page.dart';
import 'package:mangadex_flutter/features/settings/settings_provider.dart';

void main() async {
  usePathUrlStrategy();
  await SPService.initialize();
  runApp(const ProviderScope(child: Mangadex()));
}

class Mangadex extends ConsumerStatefulWidget {
  const Mangadex({super.key});

  @override
  ConsumerState<Mangadex> createState() => _MangadexState();
}

class _MangadexState extends ConsumerState<Mangadex> {
  @override
  void initState() {
    super.initState();
    ref.read(settingsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final lightColorScheme =
        ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent, brightness: Brightness.light);
    final darkColorScheme =
        ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent, brightness: Brightness.dark);
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: lightColorScheme.onSurface),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: lightColorScheme.primary,
                unselectedItemColor: lightColorScheme.onSurface,
                showUnselectedLabels: true,
                backgroundColor: lightColorScheme.surfaceDim,
                type: BottomNavigationBarType.fixed),
            colorScheme: lightColorScheme),
        darkTheme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme().apply(bodyColor: darkColorScheme.onSurface),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: darkColorScheme.primary,
                unselectedItemColor: darkColorScheme.onSurface,
                showUnselectedLabels: true,
                backgroundColor: darkColorScheme.surfaceBright,
                type: BottomNavigationBarType.fixed),
            colorScheme: darkColorScheme),
        routerConfig: GoRouter(initialLocation: "/home", routes: [
          GoRoute(
              path: "/home",
              builder: (context, state) {
                final initialTab = state.uri.queryParameters["t"] == null
                    ? 0
                    : int.tryParse(state.uri.queryParameters["t"]!) ?? 0;
                return HomePage(initialTab: initialTab);
              },
              routes: [
                GoRoute(
                    path: "/settings",
                    builder: (context, state) => const SettingsPage(),
                    routes: [
                      GoRoute(path: "/general", builder: (context, state) => const GeneralPage()),
                    ])
              ])
        ]));
  }
}
