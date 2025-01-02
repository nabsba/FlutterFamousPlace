import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Place.dart';

// Create a provider for PlacesNotifier
final placesProvider = StateNotifierProvider<PlacesNotifier, List<dynamic>>(
  (ref) => PlacesNotifier(),
);

class PlacesNotifier extends StateNotifier<List<dynamic>> {
  PlacesNotifier() : super([]);
  // Add a place to the list
  void addPlace(Place place) {
    state = [...state, place];
  }

  // Add multiple places
  void addPlaces(List<dynamic> places) {
    state = [...state, ...places];
  }

  // Clear the list
  void clearPlaces() {
    state = [];
  }
}
