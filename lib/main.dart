import 'package:arrtick_app/screens/project_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:arrtick_app/screens/add_project.dart';
import 'package:arrtick_app/theme.dart';
import 'package:arrtick_app/screens/app_layout.dart';

void main() {
  runApp(ProviderScope(child: ArrtickApp()));
}

class ArrtickApp extends StatelessWidget {
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
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Arrtick App',
      routerConfig: _router,
      themeMode: ThemeMode.light,
      theme: buildThemeData(kColorScheme),
      darkTheme: buildThemeData(kDarkColorScheme),
    );
  }
}
