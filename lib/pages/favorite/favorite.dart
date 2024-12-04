import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/famousPlaces/components/places.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});
  static const routeName = "/favorite";
  @override
  Widget build(BuildContext context) {
    return Places();
  }
}
