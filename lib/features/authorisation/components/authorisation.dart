import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/error/components/error.dart';
import 'package:flutter_famous_places/pages/signIn/sign_in.dart';
import '../../authentification/services/authentication.dart';
import '../../graphql/services/response.dart';
import '../../success/services/success.dart';

class AuthorizationWrapper extends StatelessWidget {
  final Widget signedInWidget;
  const AuthorizationWrapper({
    super.key,
    required this.signedInWidget,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData && snapshot.data != null) {
          final user = snapshot.data!;

          AuthenticationClass authenticationClass = AuthenticationClass();
          return FutureBuilder<ResponseGraphql<String>>(
            future: authenticationClass.handleAuthentification(
                _mapUserToData(user)), // The future you are waiting for
            builder: (context, tokenSnapshot) {
              // Check the connection state of the future
              if (tokenSnapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (tokenSnapshot.hasError) {
                return ErrorComponent(errorKey: 'defaultError');
              }

              if (tokenSnapshot.hasData) {
                final result = tokenSnapshot.data!;
                if (result.status == successStatus['OK'] && !result.isError) {
                  return signedInWidget;
                } else {
                  return ErrorComponent(errorKey: result.messageKey);
                }
              }
              return ErrorComponent(errorKey: 'defaultError');
            },
          );
        } else {
          return SignIn(); // Redirect to sign-in page
        }
      },
    );
  }

  Map<String, dynamic> _mapUserToData(User user) {
    return {
      'id': user.providerData[0].uid,
      'userName': user.displayName,
      'email': user.providerData[0].email,
      'provider': user.providerData[0].providerId,
      'type': "providers",
      'providerAccountId': user.providerData[0].providerId,
    };
  }
}
