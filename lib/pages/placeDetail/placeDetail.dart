import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../features/placeDetail/components/imageAndDetail.dart';
import '../../features/placeDetail/services/DescriptionCard.dart';

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
              descriptionDetailArgument: DescriptionDetailArgument(
                name: place['placeDetail']['name'],
                priceLabel: AppLocalizations.of(context)!.price,
                city: place['address']?['city']?['name'],
                country: place['address']?['city']?['country']?['name'],
                priceValue: place['price'],
              ),
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
