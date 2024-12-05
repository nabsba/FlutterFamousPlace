import 'package:graphql_flutter/graphql_flutter.dart';
import '../../graphql/client.dart';

class AuthentificationClass {
  // Method to update a dog's information
  Future returnToken(
      String id, String provider, String userName, String email) async {
    final MutationOptions options = MutationOptions(
      document: gql("""
        mutation registerToken(\$id: String!, \$provider: String!,\$email: String!, \$userName: String!) {
       registerToken(id: \$id, provider: \$provider, email: \$email, userName: \$userName,) {
        status
        anError
        message
          }
        }
      """),
      variables: {
        'id': id,
        'provider': provider,
        'email': email,
        'userName': userName,
      },
      fetchPolicy: FetchPolicy.noCache,
    );
    final QueryResult result =
        await GraphQLClientSingleton().client.mutate(options);

    if (result.hasException) {
      throw result.exception!;
    }
    return result;
    // Mapping the GraphQL response to a Dog instance
    // final updatedDogData = result.data?['returnToken'];
    // return Dog.fromMap(updatedDogData as Map<String, dynamic>);
  }
}
