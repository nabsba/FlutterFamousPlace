import 'package:flutter/material.dart';

class IconHeart extends StatelessWidget {
  final Function onClick;
  final int popularity;

  IconHeart({required this.onClick, required this.popularity});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.favorite,
        color: popularity > 0 ? Colors.red : Colors.white,
      ),
      onPressed: () => onClick(),
    );
  }
}
