import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_famous_places/features/styles/services/size.dart';

import '../../features/authentification/components/button_signIn.dart';
import '../../features/authentification/services/methods.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sign In"),
        ),
        body: Column(
          children: [
            SignInButton(
              onPressed: () async {
                await signInWithGoogle();
              },
              iconType: 'google',
            ),
            SizedBox(height: AppStylesSpace.largeSpacing),
            SignInButton(
              onPressed: () async {
                await signInWithGit();
              },
              iconType: 'git',
            )
          ],
        ));
  }
}
