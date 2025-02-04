import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../placeDetail/services/Place.dart';
import '../data/constant.dart';

final placesProvider =
    StateNotifierProvider<PlacesNotifier, Map<String, List<dynamic>>>(
  (ref) => PlacesNotifier(),
);

class PlacesNotifier extends StateNotifier<Map<String, List<dynamic>>> {
  PlacesNotifier()
      : super({
          menus[0]: [],
          menus[1]: [],
          menus[2]: [],
          menus[3]: [],
        });

  // Add a place to the specified array
  void addPlace(Place place, String type) {
    if (state.containsKey(type)) {
      state = {
        ...state,
        type: [...state[type]!, place],
      };
    }
  }

  // Add multiple places to the specified array
  void addPlaces(List<dynamic> places, String type) {
    if (state.containsKey(type)) {
      state = {
        ...state,
        type: [...state[type]!, ...places],
      };
    }
  }

  // Clear a specific array
  void clearPlaces(String type) {
    if (state.containsKey(type)) {
      state = {
        ...state,
        type: [],
      };
    }
  }

  // Clear all arrays
  void clearAllPlaces() {
    state = {"mostViewed": [], "nearby": [], "latest": [], "onSelection": []};
  }
}
