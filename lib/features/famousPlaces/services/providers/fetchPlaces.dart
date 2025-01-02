import 'dart:convert';
import 'package:flutter_famous_places/features/famousPlaces/services/providers/places.dart';
import 'package:riverpod/riverpod.dart';
import '../../../client/services/clientProvider.dart';
import '../../../graphql/client.dart';
import '../../../graphql/services/response.dart';
import '../graphql/graphQlQuery.dart';
import 'pagination.dart';

final placesProviderGraphQL =
    FutureProvider.family<ResponseGraphql<String>, String>(
  (ref, input) async {
    final decodedData = jsonDecode(input) as Map<String, dynamic>;
    final paginationState = ref.watch(paginationProvider);
    final language = decodedData['language'];
    final type = decodedData['type'];
    final userInfos = ref.watch(userInfosProvider);

    final placeRepository = PlaceRepository(GraphQLClientSingleton().client);
    final result = await placeRepository.fetchPlaces(
        language: language,
        type: type,
        userId: userInfos!.userId,
        page: paginationState.actualPage.toString());
    final List<dynamic> placesReceivedFromServer = result.data?['places'];
    if (placesReceivedFromServer.isNotEmpty) {
      Future.microtask(() {
        ref.read(placesProvider.notifier).addPlaces(placesReceivedFromServer);
      });
    }
    return result;
  },
);
