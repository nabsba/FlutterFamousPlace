import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/famousPlaces/services/providers/indexMenu.dart';
import 'package:flutter_famous_places/features/famousPlaces/services/providers/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite_common/sqlite_api.dart';
import '../../../client/providers/clientProvider.dart';
import '../../../common/services/functions.dart';
import '../../../connectivityState/providers/connectivityHelper.dart';
import '../../../graphql/client.dart';
import '../../../graphql/services/response.dart';
import '../../../sqllite/createDatabase.dart';
import '../../offline/services/getPlaces.dart';
import '../../offline/services/savePlace.dart';
import '../graphql/graphQlQuery.dart';
import 'pagination.dart';

final placesNotifierProvider =
    StateNotifierProvider<PlacesNotifier, List<dynamic>>(
  (ref) => PlacesNotifier(),
);

class PlacesNotifier extends StateNotifier<List<dynamic>> {
  PlacesNotifier() : super([]);

  Future<void> fetchPlaces(WidgetRef ref, context) async {
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
      final connectivityState = ref.watch(connectivityProvider);
      var dbInstance = await DatabaseHelper.instance.database;
      final result =
          (connectivityState.value != null && connectivityState.value == true)
              ? await placeRepository.fetchPlaces(
                  language: index.toString(),
                  type: filterProvider.toString(),
                  userId: userInfos.userId,
                  page: paginationState[menuSelectedd.toString()]!
                      .actualPage
                      .toString(),
                )
              : ResponseGraphql<String>.fromMap({
                  'status': 200,
                  'messageKey': 'ok',
                  'isError': false,
                  'data': {
                    'page': 1,
                    'rowPerPage': 5,
                    'totalRows': 5,
                    'places': await getPlaces(dbInstance),
                  }
                });

      final List<dynamic> placesReceivedFromServer =
          (result.data?['places'] != null && result.data?['places'].isNotEmpty)
              ? result.data!['places']
              : [];

      if (result.isError) {
        ref
            .read(paginationProvider.notifier)
            .setIsError(menuSelectedd.toString(), result.messageKey);
      } else if (placesReceivedFromServer.isNotEmpty) {
        if (connectivityState.value != null &&
            connectivityState.value == true) {
          final db = await DatabaseHelper.instance.database;
          await savePlaces(placesReceivedFromServer, db);
        }

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
      debugPrint('PlacesNotifier Error fetching data: $error');
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
        final place = ref.watch(placesProvider)[menuSelectedd.toString()];
        if (place!.isNotEmpty) {
          ref
              .read(placesProvider.notifier)
              .clearPlaces(menuSelectedd.toString());
        }

        ref
            .read(placesProvider.notifier)
            .addPlaces([placesReceivedFromServer], menuSelectedd.toString());
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
