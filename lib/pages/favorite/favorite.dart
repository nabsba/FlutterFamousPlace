import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  static const routeName = "/favorite";
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Your favorite places will appear here'),
      ],
    );
  }
}
