import 'package:flutter_famous_places/features/graphql/services/response.dart';
import 'package:flutter_famous_places/features/security/securedStorage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:jwt_decode/jwt_decode.dart';
import '../../authentification/services/authentication.dart';
import '../../error/services/errors.dart';
import '../../graphql/client.dart';
import '../../success/services/success.dart';

class TokenService {
  final SecuredStorageService secureStorage;
  final AuthenticationClass authenticationClass;

  TokenService(this.secureStorage, this.authenticationClass);

  Future<String?> getToken() async {
    try {
      return await secureStorage.readValue('token');
    } catch (e) {
      print('Error getting token: $e');
      return null;
    }
  }

  Future<void> storeToken(String token) async {
    try {
      await secureStorage.writeValue('token', token);
    } catch (e) {
      rethrow; // Rethrow if you want the caller to handle the error
    }
  }

  bool isTokenExpired(String token) {
    try {
      final decodedToken = Jwt.parseJwt(token);
      final expirationTime = decodedToken['exp'];
      final currentTime = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      return expirationTime < currentTime;
    } catch (e) {
      rethrow;
    }
  }

  Future<ResponseGraphql<String>> refreshToken(
      Map<String, dynamic> data) async {
    try {
      final options = MutationOptions(
        document: gql("""
          mutation refreshToken(\$data: RegisterUserInput!) {
            refreshToken(data: \$data) {
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
      );

      final result = await GraphQLClientManager(isAuthorizationNeeded: false)
          .client
          .mutate(options);
      if (result.hasException) {
        throw Exception('Failed to refresh token: ${result.exception}');
      }

      final response =
          ResponseGraphql<String>.fromMap(result.data?['refreshToken']);

      if (response.status == successStatus['OK'] &&
          response.data?['token'] != null) {
        await storeToken(response.data?['token']);
      }

      return response;
    } catch (e) {
      return ResponseGraphql<String>(
        status: statusServer["SERVER_ERROR"]!,
        isError: true,
        messageKey: 'defaultError',
        data: null,
      );
    }
  }
}
