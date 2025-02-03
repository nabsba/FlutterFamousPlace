import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../features/placeDetail/components/ButtonBook.dart';
import '../../features/placeDetail/components/IconsValues.dart';
import '../../features/placeDetail/components/Menu.dart';
import '../../features/placeDetail/components/elements/Description.dart';
import '../../features/placeDetail/components/imageAndDetail.dart';
import '../../features/placeDetail/services/Place.dart';
import '../../features/placeDetail/types/DescriptionCardArguments.dart';
import '../../features/placeDetail/types/IconsValuesArguments.dart';
import '../../features/styles/services/size.dart';

class PlaceDetailPage extends StatelessWidget {
  final Place place;
  static const routeName = "/placeDetail";
  const PlaceDetailPage({required this.place, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height *
                0.59, // Set the height you want
            child: ImageAndDetail(
              imageUrl: place.images.isNotEmpty ? place.images[0] : null,
              descriptionDetailArgument: DescriptionDetailArgument(
                name: place.placeDetail.name,
                priceLabel: AppLocalizations.of(context)!.price,
                city: place.address.city.name,
                country: place.address.city.country.name,
                priceValue: place.price,
              ),
            ),
          ),
          SizedBox(height: AppStylesSpace.largeSpacing),
          MenusPlaceDetail(),
          SizedBox(height: AppStylesSpace.largeSpacing),
          IconsValuesWidget(
              iconsValuesArguments: IconValueArguments(
                  city: place.address.city.name,
                  popularity: place.popularity,
                  hoursTravel: place.hoursTravel)),
          SizedBox(height: AppStylesSpace.largeSpacing),
          BlurredTextWidget(
            text: place.placeDetail.description,
          ),
          SizedBox(height: AppStylesSpace.largeSpacing),
          IconTextButton(
            onPressed: () {},
          ),
        ],
      ),
    ));
  }
}
