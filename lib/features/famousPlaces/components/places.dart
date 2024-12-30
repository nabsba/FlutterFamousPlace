import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/famousPlaces/services/function.dart';
import 'package:flutter_famous_places/features/famousPlaces/services/providerState/places.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/services/functions.dart';
import '../../error/components/error.dart';
import 'cardPlace/CardPlace.dart';

class Places extends ConsumerWidget {
  const Places({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = Localizations.localeOf(context);
    int index = getIndexOfLanguage(locale.toString());
    final famousPlacesProvider = ref.watch(
      placesProviderGraphQL(index.toString()),
    );

    return famousPlacesProvider.when(
      data: (response) {
        final places = response.data?['places'];
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
                if (place['isFavoritePlace']) {
                  Future.microtask(() {
                    ref
                        .read(favoritePlacesProvider.notifier)
                        .addFavorite(place['id']);
                  });
                }
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: CardPlace(
                      id: place['id'],
                      backgroundImage: place['images'].isNotEmpty
                          ? place['images'][0]
                          : null,
                      name: place['placeDetail']['name'],
                      location: place['address']?['city']?['name'],
                      country: place['address']?['city']?['country']?['name'],
                      rating: place['popularity'],
                      isFavoritePlace: place['isFavoritePlace'],
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
