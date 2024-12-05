import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});
  static const routeName = "/userProfile";
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        const Text(
          'Hello user profile page',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
          },
          child: const Text('Sign out'),
        ),
      ],
    ));
  }
}
