import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../features/authentification/services/methods.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In"),
      ),
      body: ElevatedButton(
        onPressed: () async {
          await signInWithGoogle();
        },
        child: const Text('Sign in using google'),
      ),
    );
  }
}
