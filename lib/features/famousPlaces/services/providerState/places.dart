import 'package:flutter_famous_places/features/famousPlaces/services/graphql/graphQlQuery.dart';
import 'package:flutter_famous_places/features/graphql/client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../graphql/services/response.dart';

final placesProviderGraphQL =
    FutureProvider<ResponseGraphql<String>>((ref) async {
  try {
    final placeRepository = PlaceRepository(GraphQLClientSingleton().client);
    final places = await placeRepository.fetchPlaces();
    return places;
  } catch (error) {
    rethrow;
  }
});
