import 'package:flutter_famous_places/features/famousPlaces/services/graphql/graphQlQuery.dart';
import 'package:flutter_famous_places/features/graphql/client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../client/services/clientProvider.dart';
import '../../../graphql/services/response.dart';

final placesProviderGraphQL =
    FutureProvider.family<ResponseGraphql<String>, String>(
  (ref, language) async {
    final userInfos = ref.watch(userInfosProvider);
    final placeRepository = PlaceRepository(GraphQLClientSingleton().client);
    final places = await placeRepository.fetchPlaces(
      language: language,
      type: 'all',
      userId: userInfos!.userId,
    );
    return places;
  },
);
