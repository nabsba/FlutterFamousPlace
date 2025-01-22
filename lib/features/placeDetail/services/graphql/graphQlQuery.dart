import 'package:graphql_flutter/graphql_flutter.dart';

import '../../../graphql/services/response.dart';
import '../../types/WeatherArguments.dart';

class PlaceDetailService {
  final GraphQLClient client;
  PlaceDetailService(this.client);
  Future<ResponseGraphql<Weather>> getWeather(String city) async {
    try {
      final QueryOptions options = QueryOptions(
        document: gql("""
      query GetWeather(\$city: String!) {
        weather(city: \$city) {
          status
          isError
          messageKey
          data {
            city
            temperature
            description
            humidity
            windSpeed
            sunrise
          }
        }
      }
      """),
        variables: {
          "city": city,
        },
        fetchPolicy: FetchPolicy.noCache,
      );

      final QueryResult result = await client.query(options);
      if (result.hasException) {
        throw result.exception!;
      }

      final response =
          ResponseGraphql<Weather>.fromMap(result.data?['weather']);

      if (response.isError == false) {
        return response;
      }

      throw (response);
    } catch (error) {
      rethrow;
    }
  }
}
