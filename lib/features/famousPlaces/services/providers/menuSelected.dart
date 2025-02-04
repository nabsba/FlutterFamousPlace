import 'package:riverpod/riverpod.dart';

import '../data/constant.dart';

class MenuSelected {
  final String menuOnSelection;

  MenuSelected({required this.menuOnSelection});
}

// StateNotifier to manage MenuSelected
class SelectMenu extends StateNotifier<MenuSelected> {
  SelectMenu() : super(MenuSelected(menuOnSelection: menus[0]));

  // Method to update the indices
  void updateIndex(String menuOnSelection) {
    state = MenuSelected(menuOnSelection: menuOnSelection);
  }
}

// Provider for the SelectMenu
final menuSelected = StateNotifierProvider<SelectMenu, MenuSelected>(
  (ref) => SelectMenu(),
);
