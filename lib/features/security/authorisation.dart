import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_famous_places/pages/signIn/sign_in.dart';

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
          // Show a loading indicator while waiting for the auth state
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data != null) {
          // User is signed in
          final user = snapshot.data!;
          print(user.uid); // You can log or use the user's UID as needed
          return signedInWidget; // Return the main app widget for authenticated users
        } else {
          // User is not signed in
          print("salamoualeykoum");
          return SignIn(); // Redirect to sign-in page
        }
      },
    );
  }
}
