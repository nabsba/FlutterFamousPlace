import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});
  static const routeName = "/userProfile";
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Hello user profile page',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ));
  }
}
