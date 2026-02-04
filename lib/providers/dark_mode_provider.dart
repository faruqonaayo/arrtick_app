import 'package:flutter_riverpod/flutter_riverpod.dart';

class DarkModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    return false;
  }

  void toggleDarkMode() {
    state = !state;
  }
}

final darkModeProvider = NotifierProvider<DarkModeNotifier, bool>(
  () => DarkModeNotifier(),
);
