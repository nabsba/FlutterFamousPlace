import 'package:flutter_famous_places/features/famousPlaces/services/Place.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PlaceRepository {
  final GraphQLClient client;
  PlaceRepository(this.client);
  Future<List<Place>> fetchPlaces() async {
    final QueryOptions options = QueryOptions(
      document: gql("""
        query {
          places {
            id
            popularity
          }
        }
      """),
      fetchPolicy: FetchPolicy.noCache,
    );

    final QueryResult result = await client.query(options);

    if (result.hasException) {
      throw result.exception!;
    }

    // Mapping the GraphQL response data to Place instances
    return (result.data?['places'] as List)
        .map((dogData) => Place.fromMap(dogData as Map<String, dynamic>))
        .toList();
  }
}
