import 'package:flutter_famous_places/features/graphql/services/response.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../error/services/MyLogger.dart';
import '../PreselectonName.dart';

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
                price
                hoursTravel
                address {
                  id
                  number
                  street
                  postcode
                  city {
                    id
                    name
                    country {
                      name
                      id
                    }
                  }
                }
                placeDetail {
                  id
                  name
                  description
                  languageId
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
      MyLogger.logError('PlaceRepository.fetchingPlace: $error');

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

  Future<ResponseGraphql<PreselectionNameData>> preselectionNames(
      String text, String language, String type, String userId) async {
    try {
      final MutationOptions options = MutationOptions(
        document: gql("""
        query PreselectionName(\$text: String!, \$language: String!, \$type: String!, \$userId: String!) {
          preselectionName(text: \$text, language: \$language, type: \$type, userId: \$userId) {
            status
            isError
            messageKey
            data {
              selections {
                name
                id
              }
            }
          }
        }
      """),
        variables: {
          "text": text,
          "language": language,
          "type": type,
          "userId": userId,
        },
        fetchPolicy: FetchPolicy.noCache,
      );

      final QueryResult result = await client.mutate(options);

      if (result.hasException) {
        throw result.exception!;
      }

      final response = ResponseGraphql<PreselectionNameData>.fromMap(
          result.data?['preselectionName']);

      if (!response.isError) {
        return response;
      }

      throw (response);
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> fetchPlace({
    required String placeId,
  }) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql("""
        query FetchPlace(\$placeId: String) {
          place(placeId: \$placeId) {
            status
            isError
            messageKey
            data {
              page
              rowPerPage
              totalRows
              place {
                id
                popularity
                price
                hoursTravel
                address {
                  id
                  number
                  street
                  postcode
                  city {
                    id
                    name
                    country {
                      name
                      id
                    }
                  }
                }
                placeDetail {
                  name
                  description
                  id
                  languageId
                }
                images
                isFavoritePlace
              }
            }
          }
        }
      """),
        variables: {
          "placeId": placeId,
        },
        fetchPolicy: FetchPolicy.noCache,
      );
      final QueryResult result = await client.query(options);

      if (result.hasException) {
        throw result.exception!;
      }

      final response = ResponseGraphql<String>.fromMap(result.data?['place']);
      if (response.isError == false) {
        return response;
      }

      throw (response);
      // Mapping the GraphQL response data to Place instances
    } catch (error) {
      MyLogger.logError('PlaceRepository.fetchPlace: $error');
      rethrow;
    }
  }
}
