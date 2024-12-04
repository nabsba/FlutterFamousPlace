import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQLClientSingleton {
  static final GraphQLClientSingleton _instance =
      GraphQLClientSingleton._internal();

  late final GraphQLClient client;

  factory GraphQLClientSingleton() {
    return _instance;
  }

  GraphQLClientSingleton._internal() {
    final HttpLink httpLink = HttpLink(
      'http://localhost:4000/graphql',
      defaultHeaders: {
        'AuthorizationSource': 'API',
      },
    );

    client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );
  }

  // Return a ValueNotifier wrapping the GraphQLClient instance
  ValueNotifier<GraphQLClient> getNotifier() {
    return ValueNotifier(client);
  }
}
