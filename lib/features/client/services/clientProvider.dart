import 'package:flutter_riverpod/flutter_riverpod.dart';

class Place {
  final String name;
  final String photoURL;

  Place({required this.name, required this.photoURL});

  @override
  String toString() {
    return 'Place(name: $name, photoURL: $photoURL)';
  }
}

final placeProvider = StateProvider<Place?>((ref) => null);
