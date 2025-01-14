import 'package:flutter_famous_places/features/jwt/services/token.dart';
import 'package:flutter_famous_places/features/security/securedStorage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../common/services/variables.dart';
import '../../graphql/client.dart';
import '../../graphql/services/response.dart';
import '../../success/services/success.dart';

class AuthenticationClass {
  Future<ResponseGraphql<String>> registerUser(
      Map<String, dynamic> data) async {
    try {
      final TokenService tokenService =
          TokenService(SecuredStorageService(), AuthenticationClass());
      final MutationOptions options = MutationOptions(
        document: gql("""
        mutation registerUser(\$data: RegisterUserInput!) {
          registerUser(data: \$data) {
            status
            isError
            messageKey
            data {
              token
            }
          }
        }
      """),
        variables: {'data': data},
        fetchPolicy: FetchPolicy.noCache,
      );

      final QueryResult result =
          await GraphQLClientManager(isAuthorizationNeeded: false)
              .client
              .mutate(options);
      // Check for exceptions first, before attempting to parse the result
      if (result.hasException) {
        throw result.exception!;
      }

      // Parse the response data into the ResponseGraphql object
      final response =
          ResponseGraphql<String>.fromMap(result.data?['registerUser']);

      if (response.isError == false) {
        // Store the token if the registration was successful
        await tokenService.storeToken(response.data?['token']);
        return response;
      }

      return response;
    } catch (e) {
      // Handle exceptions gracefully
      print('Error during user registration: $e');
      rethrow; // Optionally rethrow the error to propagate it further
    }
  }

  Future<ResponseGraphql<String>> handleAuthentification(
      Map<String, dynamic> data) async {
    try {
      final TokenService tokenService =
          TokenService(SecuredStorageService(), AuthenticationClass());
      final token = await tokenService.getToken();
      if (token != null && !tokenService.isTokenExpired(token)) {
        final resultGetToken = ResponseGraphql<String>(
          status: successStatus['OK']!,
          isError: false,
          messageKey: successMessagesKeys['TOKEN']!,
          data: null,
        );
        return resultGetToken;
      }
      if (token != null) {
        return await tokenService.refreshToken(data);
      }
      if (data["userName"] == null) {
        data["userName"] = defaultName; // Assign "name" if "userName" is null
      }
      final result = await registerUser(data);
      if (result.isError == false) {
        tokenService.storeToken(result.data?['token']);
        return result;
      }
      throw Exception("User registration failed.");
    } catch (error) {
      rethrow;
    }
  }
}
