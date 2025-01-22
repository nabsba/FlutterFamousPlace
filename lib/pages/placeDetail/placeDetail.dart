import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../features/placeDetail/components/IconsValues.dart';
import '../../features/placeDetail/components/Menu.dart';
import '../../features/placeDetail/components/imageAndDetail.dart';
import '../../features/placeDetail/types/DescriptionCardArguments.dart';
import '../../features/placeDetail/types/IconsValuesArguments.dart';

class PlaceDetailPage extends StatelessWidget {
  final Map<String, dynamic> place;
  static const routeName = "/placeDetail";
  const PlaceDetailPage({required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          // Top Widget: ImageAndDetail
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.53, // Set the height you want
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
          MenusPlaceDetail(),
          IconsValuesWidget(
              iconsValuesArguments: IconValueArguments(
                  city: place['address']?['city']?['name'],
                  popularity: place['popularity'],
                  hoursTravel: place['hoursTravel']))
        ],
      ),
    ));
  }
}
