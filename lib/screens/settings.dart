import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import 'package:arrtick_app/providers/dark_mode_provider.dart';

class Settings extends ConsumerStatefulWidget {
  const Settings({super.key});

  @override
  ConsumerState<Settings> createState() => _SettingsState();
}

class _SettingsState extends ConsumerState<Settings> {
  late bool _darkModeOn;

  @override
  void initState() {
    super.initState();
    _darkModeOn = ref.read(darkModeProvider);
  }

  @override
  Widget build(BuildContext context) {
    final darkModeNotifier = ref.read(darkModeProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.dark_mode),
            title: Text('Dark Mode'),
            trailing: Switch(
              value: _darkModeOn,
              onChanged: (value) {
                setState(() {
                  _darkModeOn = value;
                  darkModeNotifier.toggleDarkMode();
                });
              },
            ),
            onTap: () {
              setState(() {
                _darkModeOn = !_darkModeOn;
                darkModeNotifier.toggleDarkMode();
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About'),
            onTap: () {
              // Handle about tap
            },
          ),
        ],
      ),
    );
  }
}
