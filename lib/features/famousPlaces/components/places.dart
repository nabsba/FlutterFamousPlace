import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/famousPlaces/services/providerState/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cardPlace/CardPlace.dart';
// import '../services/providerDogs.dart';

class Places extends ConsumerWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the dogsProvider, which is a FutureProvider
    final famousPlacesProvider = ref.watch(placesProviderGraphQL);

    return famousPlacesProvider.when(
      data: (places) {
        // If the data is available, display the list of places
        if (places.isEmpty) {
          return Center(child: Text('No places found.'));
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
                      backgroundImage:
                          place.images.isNotEmpty ? place.images[0] : null,
                      name: place.placeDetail.name,
                      location: place.address.city.name,
                      country: place.address.city.country.name,
                      rating: place.popularity,
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
        return Center(child: Text('Error: $error'));
      },
    );
  }
}
