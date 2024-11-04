import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangadex_flutter/features/home/home_page.dart';

void main() {
  runApp(const ProviderScope(child: Mangadex()));
}

class Mangadex extends StatelessWidget {
  const Mangadex({super.key});

  @override
  Widget build(BuildContext context) {
    final lightColorScheme = ColorScheme.fromSeed(
        seedColor: Colors.lightBlueAccent, brightness: Brightness.light);
    final darkColorScheme = ColorScheme.fromSeed(
        seedColor: Colors.lightBlueAccent, brightness: Brightness.dark);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: ThemeMode.dark,
        theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme()
                .apply(bodyColor: lightColorScheme.onSurface),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: lightColorScheme.primary,
                unselectedItemColor: lightColorScheme.onSurface,
                showUnselectedLabels: true,
                backgroundColor: lightColorScheme.surfaceDim,
                type: BottomNavigationBarType.fixed),
            colorScheme: lightColorScheme),
        darkTheme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme()
                .apply(bodyColor: darkColorScheme.onSurface),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: darkColorScheme.primary,
                unselectedItemColor: darkColorScheme.onSurface,
                showUnselectedLabels: true,
                backgroundColor: darkColorScheme.surfaceBright,
                type: BottomNavigationBarType.fixed),
            colorScheme: darkColorScheme),
        onGenerateRoute: (settings) {
          final defaultRoute = MaterialPageRoute(
              settings: const RouteSettings(name: "/home"),
              builder: (context) => const HomePage());

          if (settings.name == null) return defaultRoute;

          final homeMatch = RegExp(r"/home\?t=(.*)").firstMatch(settings.name!);
          if (homeMatch != null) {
            int initialTab = homeMatch.group(1) != null
                ? (int.tryParse(homeMatch.group(1)!) ?? 0)
                : 0;
            if (initialTab > 3) initialTab = 3;
            if (initialTab < 0) initialTab = 0;
            return MaterialPageRoute(
                settings: settings,
                builder: (context) => HomePage(initialTab: initialTab));
          }

          return defaultRoute;
        },
        initialRoute: "/home?t=0");
  }
}
