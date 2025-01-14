import 'package:riverpod/riverpod.dart';
import '../../graphql/client.dart';
import '../../graphql/services/response.dart';
import 'graphql/graphQlQuery.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final placeIdLocaleProvider = StateProvider<List<String>>((ref) => []);

Future<ResponseGraphql<String>> toggleFavoritePlace(
    String placeId, String userId) async {
  try {
    final placeRepository = PlaceRepository(GraphQLClientManager().client);
    return await placeRepository.toggleFavoritePlace(placeId, userId);
  } catch (error) {
    rethrow;
  }
}

// Provider for the FavoritePlacesNotifier
final favoritePlacesProvider =
    StateNotifierProvider<FavoritePlacesNotifier, List<String>>((ref) {
  return FavoritePlacesNotifier();
});

class FavoritePlacesNotifier extends StateNotifier<List<String>> {
  FavoritePlacesNotifier() : super([]);

  /// Adds a place to the favorites list if it's not already there.
  void addFavorite(String placeId) {
    if (!state.contains(placeId)) {
      state = [...state, placeId];
    }
  }

  /// Removes a place from the favorites list if it exists.
  void removeFavorite(String placeId) {
    state = state.where((id) => id != placeId).toList();
  }
}
