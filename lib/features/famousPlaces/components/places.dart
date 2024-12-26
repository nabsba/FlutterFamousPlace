import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/famousPlaces/services/providerState/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../error/components/error.dart';
import 'cardPlace/CardPlace.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import '../services/providerDogs.dart';

class Places extends ConsumerWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the dogsProvider, which is a FutureProvider
    final famousPlacesProvider = ref.watch(placesProviderGraphQL);

    return famousPlacesProvider.when(
      data: (response) {
        final places = response.data?['places'];
        // // If the data is available, display the list of places
        if (places.isEmpty) {
          return Center(
              child: Text(AppLocalizations.of(context)!.noPlaceFound));
        }
        if (response.isError) {
          return ErrorComponent(
            errorKey: response.messageKey,
          );
        }
        return Flexible(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.43,
            // Specify the desired height
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: places.length,
              itemBuilder: (context, index) {
                final place = places[index];
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: CardPlace(
                      backgroundImage: place['images'].isNotEmpty
                          ? place['images'][0]
                          : null,
                      name: place['placeDetail']['name'],
                      location: place['address']?['city']?['name'],
                      country: place['address']?['city']?['country']?['name'],
                      rating: place['popularity'],
                    ));
              },
            ),
          ),
        );
      },
      loading: () {
        // While the data is loading, show a loading spinner
        return Center(child: CircularProgressIndicator());
      },
      error: (error, stack) {
        // If there is an error, display an error message
        return ErrorComponent(
          errorKey: 'defaultError',
        );
      },
    );
  }
}
