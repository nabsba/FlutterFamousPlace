import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Place.dart';

final placesProvider =
    StateNotifierProvider<PlacesNotifier, Map<String, List<dynamic>>>(
  (ref) => PlacesNotifier(),
);

class PlacesNotifier extends StateNotifier<Map<String, List<dynamic>>> {
  PlacesNotifier() : super({"0": [], "1": [], "2": [], "3": []});

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
    state = {"0": [], "1": [], "2": [], "3": []};
  }
}
