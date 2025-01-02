import 'package:flutter_famous_places/features/graphql/services/response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class PlaceRepository {
  final GraphQLClient client;
  PlaceRepository(this.client);
  Future<dynamic> fetchPlaces(
      {required String language,
      required String type,
      required String userId,
      required String page}) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql("""
        query FetchPlaces(\$language: String!, \$type: String!, \$userId: String!, \$page: String!) {
          places(language: \$language, type: \$type, userId: \$userId, page: \$page) {
            status
            isError
            messageKey
            data {
              page
              rowPerPage
              totalRows
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
                isFavoritePlace
              }
            }
          }
        }
      """),
        variables: {
          "language": language,
          "type": type,
          "userId": userId,
          "page": page
        },
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
      print(error);
      rethrow;
    }
  }

  Future<ResponseGraphql<String>> toggleFavoritePlace(
      String placeId, String userId) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql("""
    mutation ToggleFavoritePlace(\$placeId: String!, \$userId: String!) {
      toggleFavoritePlace(placeId: \$placeId, userId: \$userId) {
        status
        isError
        messageKey
        data {
          placeId
        }
      }
    }
  """),
        variables: {
          "placeId": placeId,
          "userId": userId,
        },
        fetchPolicy: FetchPolicy.noCache,
      );
      final QueryResult result = await client.mutate(options);
      if (result.hasException) {
        throw result.exception!;
      }
      final response =
          ResponseGraphql<String>.fromMap(result.data?['toggleFavoritePlace']);
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
