import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangadex_flutter/core/services/local/sp_service.dart';
import 'package:mangadex_flutter/features/home/home_page.dart';
import 'package:mangadex_flutter/features/search/pages/filter_result_manga_page.dart';
import 'package:mangadex_flutter/features/search/pages/search_page.dart';
import 'package:mangadex_flutter/features/settings/appearance_page.dart';
import 'package:mangadex_flutter/features/settings/general_page.dart';
import 'package:mangadex_flutter/features/settings/library_page.dart';
import 'package:mangadex_flutter/features/settings/settings_page.dart';
import 'package:mangadex_flutter/features/settings/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SPService.initialize();
  runApp(const ProviderScope(child: Mangadex()));
}

class Mangadex extends ConsumerStatefulWidget {
  const Mangadex({super.key});

  @override
  ConsumerState<Mangadex> createState() => _MangadexState();
}

class _MangadexState extends ConsumerState<Mangadex> {
  final router = GoRouter(initialLocation: "/home", routes: [
    GoRoute(path: "/home", builder: (context, state) => const HomePage(), routes: [
      GoRoute(
          path: "/settings",
          builder: (context, state) => const SettingsPage(),
          routes: [
            GoRoute(
                path: "general",
                builder: (context, state) => const GeneralSettingsPage()),
            GoRoute(
                path: "appearance",
                builder: (context, state) => const AppearanceSettingsPage()),
            GoRoute(
                path: "library", builder: (context, state) => const LibrarySettingsPage())
          ]),
      GoRoute(path: "/search", builder: (context, state) => const SearchPage(), routes: [
        GoRoute(
            path: "manga/:mangaId",
            builder: (context, state) =>
                FilterResultMangaPage(mangaId: state.pathParameters["mangaId"]!))
      ])
    ])
  ]);

  @override
  void initState() {
    super.initState();
    ref.read(settingsProvider);
  }

  @override
  Widget build(BuildContext context) {
    final (darkTheme, pureBlackTheme) = ref.watch(
        settingsProvider.select((state) => (state.darkTheme, state.pureBlackTheme)));
    final lightColorScheme = ColorScheme.fromSeed(
        seedColor: Colors.lightBlueAccent, brightness: Brightness.light);
    final darkColorScheme = ColorScheme.fromSeed(
        seedColor: Colors.lightBlueAccent,
        brightness: Brightness.dark,
        surface: pureBlackTheme ? Colors.black : null);
    final textTheme = GoogleFonts.interTextTheme(TextTheme(
        labelSmall: const TextStyle(fontSize: 8, fontWeight: FontWeight.w500),
        labelMedium: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
        labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.lerp(FontWeight.w300, FontWeight.normal, 0.5)!),
        bodyMedium: const TextStyle(fontSize: 14),
        bodyLarge: const TextStyle(fontSize: 16),
        titleSmall: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        titleMedium: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        titleLarge: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)));
    final lightTextTheme = textTheme.apply(
        bodyColor: lightColorScheme.onSurface, displayColor: lightColorScheme.onSurface);
    final darkTextTheme = textTheme.apply(
        bodyColor: darkColorScheme.onSurface, displayColor: darkColorScheme.onSurface);

    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        themeMode: darkTheme ? ThemeMode.dark : ThemeMode.light,
        scrollBehavior: ScrollConfiguration.of(context)
            .copyWith(dragDevices: {PointerDeviceKind.touch, PointerDeviceKind.mouse}),
        theme: ThemeData(
            textTheme: lightTextTheme,
            appBarTheme: AppBarTheme(titleTextStyle: lightTextTheme.titleLarge),
            expansionTileTheme:
                const ExpansionTileThemeData(shape: RoundedRectangleBorder()),
            segmentedButtonTheme: SegmentedButtonThemeData(
                selectedIcon: Icon(Icons.check,
                    size: 16, color: lightColorScheme.onPrimaryContainer),
                style: SegmentedButton.styleFrom(
                    textStyle: lightTextTheme.titleSmall,
                    selectedBackgroundColor: lightColorScheme.primaryContainer,
                    selectedForegroundColor: lightColorScheme.onPrimaryContainer)),
            listTileTheme: ListTileThemeData(
                iconColor: lightColorScheme.primary,
                titleTextStyle: lightTextTheme.titleMedium,
                subtitleTextStyle: lightTextTheme.bodySmall),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: lightColorScheme.primary,
                unselectedItemColor: lightColorScheme.onSurface,
                showUnselectedLabels: true,
                backgroundColor: lightColorScheme.surfaceDim,
                type: BottomNavigationBarType.fixed),
            colorScheme: lightColorScheme),
        darkTheme: ThemeData(
            textTheme: darkTextTheme,
            appBarTheme: AppBarTheme(titleTextStyle: darkTextTheme.titleLarge),
            expansionTileTheme:
                const ExpansionTileThemeData(shape: RoundedRectangleBorder()),
            segmentedButtonTheme: SegmentedButtonThemeData(
                selectedIcon: Icon(Icons.check,
                    size: 16, color: darkColorScheme.onPrimaryContainer),
                style: SegmentedButton.styleFrom(
                    textStyle: darkTextTheme.titleSmall,
                    selectedBackgroundColor: darkColorScheme.primaryContainer,
                    selectedForegroundColor: darkColorScheme.onPrimaryContainer)),
            listTileTheme: ListTileThemeData(
                iconColor: darkColorScheme.primary,
                titleTextStyle: darkTextTheme.titleMedium,
                subtitleTextStyle: darkTextTheme.bodySmall),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: darkColorScheme.primary,
                unselectedItemColor: darkColorScheme.onSurface,
                showUnselectedLabels: true,
                backgroundColor: darkColorScheme.surfaceBright,
                type: BottomNavigationBarType.fixed),
            colorScheme: darkColorScheme),
        routerConfig: router);
  }
}
