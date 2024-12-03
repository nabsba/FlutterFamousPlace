import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Hello Home',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ));
  }
}
