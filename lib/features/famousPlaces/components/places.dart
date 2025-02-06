import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../pages/placeDetail/placeDetail.dart';
import '../../client/providers/clientProvider.dart';
import '../../connectivityState/providers/connectivityHelper.dart';
import '../../error/components/error.dart';
import '../../error/services/errors.dart';
import '../../loaders/components/timeLoadingWidget.dart';
import '../../loaders/services/constant.dart';
import '../../placeDetail/services/Place.dart';
import '../services/data/constant.dart';
import '../services/function.dart';
import '../services/providers/fetchPlaces.dart';
import '../services/providers/menuSelected.dart';
import '../services/providers/pagination.dart';
import '../services/providers/places.dart';
import 'cardPlace/CardPlace.dart';

class Places extends ConsumerStatefulWidget {
  const Places({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _InfiniteScrollingPageState createState() => _InfiniteScrollingPageState();
}

class _InfiniteScrollingPageState extends ConsumerState<Places> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Listen to scrolling and fetch more data when near the bottom
    _scrollController.addListener(() {
      final userInfos = ref.read(userInfosProvider); // Read the current value
      if (userInfos?.userId != null &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200) {
        ref.read(placesNotifierProvider.notifier).fetchPlaces(ref, context);
      }
    });

    // Fetch initial data after the widget is fully mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userInfos = ref.read(userInfosProvider);
      final connectivityState = ref.watch(connectivityProvider);

      if (userInfos?.userId != null &&
          connectivityState.value != null &&
          connectivityState.value == true) {
        ref.read(placesNotifierProvider.notifier).fetchPlaces(ref, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final paginationState = ref.watch(paginationProvider);
    final userInfos = ref.watch(userInfosProvider);
    final menuSelectedd = ref.watch(menuSelected).menuOnSelection;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userInfos != null &&
          userInfos.userId.isNotEmpty &&
          menuSelectedd != menus[3]) {
        ref.read(placesNotifierProvider.notifier).fetchPlaces(ref, context);
      }
    });
    final places = ref.watch(placesProvider)[menuSelectedd];

    if (places == null || places.isEmpty) {
      if (paginationState[menuSelectedd]!.isLoading) {
        return LoadingWidget(loadingType: LoaderMessagesKeys.skelaton);
      }
      return Padding(
        padding: const EdgeInsets.only(top: 20.0), // Add top margin here
        child: Center(
          child: Text(AppLocalizations.of(context)!.noPlaceFound),
        ),
      );
    }
    return Flexible(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.83,
        child: paginationState[menuSelectedd]!.messageKey.isNotEmpty &&
                places.isEmpty
            ? Center(
                child: ErrorComponent(
                  errorKey: paginationState[menuSelectedd]!.messageKey,
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (places.length) +
                    ((paginationState[menuSelectedd]?.isLoading ?? false)
                        ? 1
                        : 0),
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index >= places.length) {
                    return LoadingWidget(
                        errorKey: errorMessagesKeys['CANNOT_LOAD_MORE_DATA']!,
                        loadingType: LoaderMessagesKeys.skelaton);
                  }
                  final Place place = places[index] is Place
                      ? places[index]
                      : Place(
                          id: places[index]['id'],
                          popularity: places[index]['popularity'],
                          price: places[index]['price'],
                          hoursTravel: places[index]['hoursTravel'],
                          images: places[index]['images'],
                          isFavoritePlace:
                              places[index]['isFavoritePlace'] ?? false,
                          address: Address(
                            id: places[index]['address']['id'],
                            number: places[index]['address']['number'],
                            street: places[index]['address']['street'],
                            postcode: places[index]['address']['postcode'],
                            city: City(
                              id: places[index]['address']['city']['id'],
                              name: places[index]['address']['city']['name'],
                              country: Country(
                                id: places[index]['address']['city']['country']
                                    ['id'],
                                name: places[index]['address']['city']
                                    ['country']['name'],
                              ),
                            ),
                          ),
                          placeDetail: PlaceDetail(
                            id: places[index]['placeDetail']['id'],
                            name: places[index]['placeDetail']['name'],
                            description: places[index]['placeDetail']
                                ['description'],
                            languageId: places[index]['placeDetail']
                                ['languageId'],
                          ),
                        );

                  if (place.isFavoritePlace) {
                    Future.microtask(() {
                      ref
                          .read(favoritePlacesProvider.notifier)
                          .addFavorite(place.id);
                    });
                  }
                  return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      child: GestureDetector(
                        onTap: () => context.go(
                          PlaceDetailPage.routeName,
                          extra: place, // Pass the place object as an argument
                        ),
                        child: CardPlace(
                          id: place.id,
                          backgroundImage:
                              place.images.isNotEmpty ? place.images[0] : null,
                          name: place.placeDetail.name,
                          location: place.address.city.name,
                          country: place.address.city.country.name,
                          rating: place.popularity,
                          isFavoritePlace: place.isFavoritePlace,
                        ),
                      ));
                },
              ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
