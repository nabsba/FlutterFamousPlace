import 'package:flutter_famous_places/features/graphql/services/response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PlaceRepository {
  final GraphQLClient client;
  PlaceRepository(this.client);
  Future<ResponseGraphql<String>> fetchPlaces() async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql("""
  query {
  places(language: "1", type: "someType") {
    status
    isError
    messageKey
    data {
      places {
        id
        popularity
        address {
          number
          street
          postcode
          city {
            name
            country {
              name
            }
          }
        }
        placeDetail {
          name
          description
        }
        images
      }
    }
  }
}
"""),
        fetchPolicy: FetchPolicy.noCache,
      );
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw result.exception!;
      }
      final response = ResponseGraphql<String>.fromMap(result.data?['places']);
      if (response.isError == false) {
        return response;
      }

      throw (response);
      // Mapping the GraphQL response data to Place instances
    } catch (error) {
      // print(error);
      rethrow;
    }
  }
}
