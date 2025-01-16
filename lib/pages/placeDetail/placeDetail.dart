import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class PlaceDetailPage extends StatelessWidget {
  final Map<String, dynamic> place;
  static const routeName = "/placeDetail";
  const PlaceDetailPage({required this.place, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place['placeDetail']['name']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to ${place['placeDetail']['name']}!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (context.canPop()) {
                  context.pop(); // Go back to the previous route
                } else {
                  context.go(
                      '/'); // Navigate to the main route or another fallback
                }
              },
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
