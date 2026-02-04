import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:arrtick_app/providers/provider.dart';
import 'package:arrtick_app/providers/dark_mode_provider.dart';
import 'package:arrtick_app/screens/project_details.dart';
import 'package:arrtick_app/screens/settings.dart';
import 'package:arrtick_app/screens/add_project.dart';
import 'package:arrtick_app/theme.dart';
import 'package:arrtick_app/screens/app_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPrefInstance = await SharedPreferences.getInstance();
  runApp(
    ProviderScope(
      overrides: [sharedPrefProvider.overrideWith((ref) => sharedPrefInstance)],
      child: ArrtickApp(),
    ),
  );
}

class ArrtickApp extends ConsumerWidget {
  ArrtickApp({super.key});

  final _router = GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(path: "/", builder: (context, state) => AppLayout()),
      GoRoute(path: "/project/new", builder: (context, state) => AddProject()),
      GoRoute(
        path: "/project/:id",
        builder: (context, state) {
          final projectId = state.pathParameters['id']!;
          // Return the project detail screen with the given projectId
          return ProjectDetails(projectId: projectId);
        },
      ),
      GoRoute(
        path: "/project/edit/:id",
        builder: (context, state) {
          final projectId = state.pathParameters['id']!;
          return AddProject(projectId: projectId);
        },
      ),
      GoRoute(path: "/settings", builder: (context, state) => const Settings()),
    ],
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = ref.watch(darkModeProvider);
    return MaterialApp.router(
      title: 'Arrtick App',
      routerConfig: _router,
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: buildThemeData(kColorScheme),
      darkTheme: buildThemeData(kDarkColorScheme),
    );
  }
}
