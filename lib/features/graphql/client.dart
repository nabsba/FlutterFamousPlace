import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../authentification/services/authentication.dart';
import '../jwt/services/token.dart';
import '../security/securedStorage.dart';

class GraphQLClientSingleton {
  static final GraphQLClientSingleton _instance =
      GraphQLClientSingleton._internal();

  late final GraphQLClient client;

  factory GraphQLClientSingleton() {
    return _instance;
  }

  GraphQLClientSingleton._internal() {
    // AuthLink to dynamically add the token to the headers
    final AuthLink authLink = AuthLink(
      getToken: () async {
        final TokenService tokenService =
            TokenService(SecuredStorageService(), AuthenticationClass());
        // Replace with your logic to fetch the token dynamically
        final token = await tokenService.getToken();
        return 'Bearer $token';
      },
      headerKey: 'Authorization', // Defaults to 'Authorization'
    );

    // Base HttpLink for the GraphQL endpoint
    final HttpLink httpLink = HttpLink(
      'http://localhost:4000/graphql',
      defaultHeaders: {
        'AuthorizationSource': 'mobile',
      },
    );

    // Combine AuthLink and HttpLink
    final Link link = authLink.concat(httpLink);

    // Initialize the GraphQL client
    client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );
  }

  // Return a ValueNotifier wrapping the GraphQLClient instance
  ValueNotifier<GraphQLClient> getNotifier() {
    return ValueNotifier(client);
  }
}
