import 'package:flutter_famous_places/features/famousPlaces/services/Place.dart';
import 'package:flutter_famous_places/features/famousPlaces/services/graphql/graphQlQuery.dart';
import 'package:flutter_famous_places/features/graphql/client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final placesProviderGraphQL = FutureProvider<List<Place>>((ref) async {
  final placeRepository = PlaceRepository(GraphQLClientSingleton().client);
  final places = await placeRepository.fetchPlaces();

  return places;
});
