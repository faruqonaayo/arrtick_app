import 'package:flutter/material.dart';

void main() {
  runApp(const ArrtickApp());
}

class ArrtickApp extends StatelessWidget {
  const ArrtickApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arrtick App',
      home: Scaffold(
        appBar: AppBar(title: const Text('Arrtick Home Page')),
        body: const Center(child: Text('Welcome to Arrtick!')),
      ),
    );
  }
}
