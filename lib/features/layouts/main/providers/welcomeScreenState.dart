import 'package:flutter_riverpod/flutter_riverpod.dart';

class WelcomeScreenStateNotifier extends StateNotifier<bool> {
  WelcomeScreenStateNotifier() : super(true);

  // Set the welcome screen as seen
  void displayWelcomeScreen() {
    state = true;
  }

  void doNotDisplayWelcomeScreenAgain() {
    state = false;
  }
}

final welcomeScreenProvider =
    StateNotifierProvider<WelcomeScreenStateNotifier, bool>(
  (ref) => WelcomeScreenStateNotifier(),
);
