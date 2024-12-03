import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  static const routeName = "/favorite";
  @override
  Widget build(BuildContext context) {
    return const Center(
        child: Text(
      'Hello favorite page',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    ));
  }
}
