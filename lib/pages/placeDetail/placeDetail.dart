import 'package:flutter/material.dart';
import '../../features/placeDetail/components/imageAndDetail.dart';

class PlaceDetailPage extends StatelessWidget {
  final Map<String, dynamic> place;
  static const routeName = "/placeDetail";
  const PlaceDetailPage({required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Top Widget: ImageAndDetail
          Expanded(
            flex: 3,
            child: ImageAndDetail(
              imageUrl: place['images'].isNotEmpty ? place['images'][0] : null,
              iconLeft: Icons.arrow_back,
              iconRight: Icons.menu,
              menuItems: ['Home', 'Profile', 'Settings'],
            ),
          ),
          // Bottom Widgets
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey[100],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Additional Content',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
