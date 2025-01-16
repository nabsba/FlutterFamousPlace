import 'dart:ffi';

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

Map<String, String> manageDisplay(String name, String location, int maxLength,
    {int truncateLength = 17}) {
  // Resulting Map to store name and location
  Map<String, String> result = {};

  int totalLength = name.length + location.length;

  // If the combined length exceeds the maxLength, we need to truncate
  if (totalLength > maxLength) {
    // Calculate how much space is available for the location after the name is displayed
    int remainingLength = maxLength - name.length;

    // Truncate the location based on the remaining space and append "..."
    String truncatedLocation = remainingLength > 0
        ? '${truncateString(location, remainingLength)}...'
        : ''; // If no space for location, leave it empty

    // Set the name and truncated location in the result map
    result['name'] = name;
    result['location'] = truncatedLocation;
  } else {
    // If the total length is within the limit, return both name and location as is
    result['name'] = name;
    result['location'] = location;
  }

  return result;
}

String truncateString(String input, int maxLength, {int truncateLength = 9}) {
  // Truncate the string to the maxLength and add "..." if necessary
  if (input.length > maxLength) {
    return '${input.substring(0, truncateLength)}...';
  }
  return input;
}
