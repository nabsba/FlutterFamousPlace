import 'package:riverpod/riverpod.dart';

class IndexState {
  final int newIndex;

  IndexState({required this.newIndex});
}

// StateNotifier to manage IndexState
class SelectMenu extends StateNotifier<IndexState> {
  SelectMenu() : super(IndexState(newIndex: 0));

  // Method to update the indices
  void updateIndex(int newIndex) {
    state = IndexState(newIndex: newIndex);
  }
}

// Provider for the SelectMenu
final menuSelected = StateNotifierProvider<SelectMenu, IndexState>(
  (ref) => SelectMenu(),
);
