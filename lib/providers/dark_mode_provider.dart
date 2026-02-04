import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:arrtick_app/providers/provider.dart';

class DarkModeNotifier extends Notifier<bool> {
  @override
  bool build() {
    final simpleStorage = ref.read(sharedPrefProvider);
    final isDarkMode = simpleStorage.getBool('isDarkMode');
    if (isDarkMode != null) {
      return isDarkMode;
    }
    return false;
  }

  void toggleDarkMode() {
    state = !state;
    final simpleStorage = ref.read(sharedPrefProvider);
    simpleStorage.setBool("isDarkMode", state);
  }
}

final darkModeProvider = NotifierProvider<DarkModeNotifier, bool>(
  () => DarkModeNotifier(),
);
