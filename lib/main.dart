import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:arrtick_app/screens/app_layout.dart';

void main() {
  runApp(ArrtickApp());
}

class ArrtickApp extends StatelessWidget {
  ArrtickApp({super.key});

  final _router = GoRouter(
    initialLocation: "/",
    routes: [GoRoute(path: "/", builder: (context, state) => AppLayout())],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(title: 'Arrtick App', routerConfig: _router);
  }
}
