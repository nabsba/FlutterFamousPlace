// import 'dart:convert';
// import 'package:flutter_famous_places/features/famousPlaces/services/providers/indexMenu.dart';
// import 'package:flutter_famous_places/features/famousPlaces/services/providers/places.dart';
// import 'package:riverpod/riverpod.dart';
// import '../../../client/services/clientProvider.dart';
// import '../../../graphql/client.dart';
// import '../../../graphql/services/response.dart';
// import '../graphql/graphQlQuery.dart';
// import 'pagination.dart';

// final placesProviderGraphQL =
//     FutureProvider.family<ResponseGraphql<String>, String>(
//   (ref, input) async {
//     final menuIndexSelected = ref.read(menuSelected).newIndex;
//     print('menuIndexSelected');
//     print(menuIndexSelected);

//     final decodedData = jsonDecode(input) as Map<String, dynamic>;
//     final paginationState = ref.watch(paginationProvider);
//     print('paginationState');
//     print(paginationState);
//     final language = decodedData['language'];
//     final type = decodedData['type'];
//     final userInfos = ref.watch(userInfosProvider);

//     final placeRepository = PlaceRepository(GraphQLClientManager().client);
//     final result = await placeRepository.fetchPlaces(
//         language: language,
//         type: type,
//         userId: userInfos!.userId,
//         page: paginationState.actualPage.toString());
//     final List<dynamic> placesReceivedFromServer = result.data?['places'];
//     if (placesReceivedFromServer.isNotEmpty) {
//       Future.microtask(() {
//         ref
//             .read(placesProvider.notifier)
//             .addPlaces(placesReceivedFromServer, menuIndexSelected.toString());
//       });
//     }
//     return result;
//   },
// );

import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/famousPlaces/services/providers/indexMenu.dart';
import 'package:flutter_famous_places/features/famousPlaces/services/providers/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../client/services/clientProvider.dart';
import '../../../common/services/functions.dart';
import '../../../graphql/client.dart';
import '../graphql/graphQlQuery.dart';
import 'pagination.dart';

final placesNotifierProvider =
    StateNotifierProvider<PlacesNotifier, List<dynamic>>(
  (ref) => PlacesNotifier(),
);

class PlacesNotifier extends StateNotifier<List<dynamic>> {
  PlacesNotifier() : super([]);

  Future<void> fetchMoreData(WidgetRef ref, context) async {
    final userInfos = ref.watch(userInfosProvider);
    final paginationState = ref.watch(paginationProvider);
    final menuSelectedd = ref.read(menuSelected).newIndex;

    if (userInfos == null ||
        userInfos.userId.isEmpty ||
        paginationState[menuSelectedd.toString()]!.isLoading ||
        (paginationState[menuSelectedd.toString()]!.totalPage ==
                paginationState[menuSelectedd.toString()]!.actualPage &&
            paginationState[menuSelectedd.toString()]!.totalRows != 0)) {
      return;
    }

    final locale = Localizations.localeOf(context);
    final index = getIndexOfLanguage(locale.toString());
    ref
        .read(paginationProvider.notifier)
        .setLoading(menuSelectedd.toString(), true);

    try {
      final filterProvider = ref.watch(menuSelected).newIndex;
      final placeRepository = PlaceRepository(GraphQLClientManager().client);
      final result = await placeRepository.fetchPlaces(
        language: index.toString(),
        type: filterProvider.toString(),
        userId: userInfos.userId,
        page: paginationState[menuSelectedd.toString()]!.actualPage.toString(),
      );

      final List<dynamic> placesReceivedFromServer =
          result.data?['places'] ?? [];

      if (result.isError) {
        ref
            .read(paginationProvider.notifier)
            .setIsError(menuSelectedd.toString(), result.messageKey);
      } else if (placesReceivedFromServer.isNotEmpty) {
        ref
            .read(placesProvider.notifier)
            .addPlaces(placesReceivedFromServer, filterProvider.toString());
        ref.read(paginationProvider.notifier).updateRowPerPage(
            menuSelectedd.toString(), result.data['rowPerPage']);
        ref.read(paginationProvider.notifier).updateTotalRows(
            menuSelectedd.toString(), result.data['totalRows']);
        ref.read(paginationProvider.notifier).updateActualPage(
            menuSelectedd.toString(),
            paginationState[menuSelectedd.toString()]!.actualPage + 1);
      }
    } catch (error) {
      debugPrint('Error fetching data: $error');
    } finally {
      // Reset loading state
      ref
          .read(paginationProvider.notifier)
          .setLoading(menuSelectedd.toString(), false);
    }
  }

  Future<void> fetchPlace(WidgetRef ref, context, String placeId) async {
    final menuSelectedd = ref.read(menuSelected).newIndex;
    try {
      ref
          .read(paginationProvider.notifier)
          .setLoading(menuSelectedd.toString(), true);
      final placeRepository = PlaceRepository(GraphQLClientManager().client);

      final result = await placeRepository.fetchPlace(
        placeId: placeId,
      );

      final dynamic placesReceivedFromServer = result.data?['place'] ?? [];
      if (result.isError) {
        ref
            .read(paginationProvider.notifier)
            .setIsError(menuSelectedd.toString(), result.messageKey);
      } else if (placesReceivedFromServer.isNotEmpty) {
        final place = ref.watch(placesProvider)['3'];
        if (place!.isNotEmpty) {
          ref.read(placesProvider.notifier).clearPlaces('3');
        }

        ref
            .read(placesProvider.notifier)
            .addPlaces([placesReceivedFromServer], '3');
      }
    } catch (error) {
      print(error);
    } finally {
      // Reset loading state
      ref
          .read(paginationProvider.notifier)
          .setLoading(menuSelectedd.toString(), false);
    }
  }
}
