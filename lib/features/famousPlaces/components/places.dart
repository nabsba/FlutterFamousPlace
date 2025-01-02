// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_famous_places/features/famousPlaces/services/function.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../common/services/functions.dart';
// import '../../error/components/error.dart';
// import '../services/Place.dart';
// import '../services/providers/fetchPlaces.dart';
// import '../services/providers/places.dart';
// import 'FilterPlace.dart';
// import 'cardPlace/CardPlace.dart';

// class Places extends ConsumerWidget {
//   const Places({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final locale = Localizations.localeOf(context);
//     int index = getIndexOfLanguage(locale.toString());
//     final filterProvider = ref.watch(selectedButtonProvider);
//     final data = {
//       'language': index.toString(),
//       'type': filterProvider.toString(),
//     };
//     final encodedData = jsonEncode(data);
//     final famousPlacesProvider = ref.watch(
//       placesProviderGraphQL(encodedData),
//     );

//     return famousPlacesProvider.when(
//       data: (response) {
//         final List<dynamic> places = ref.watch(placesProvider);

//         if (places.isEmpty) {
//           return Center(
//               child: Text(AppLocalizations.of(context)!.noPlaceFound));
//         }
//         if (response.isError) {
//           return ErrorComponent(
//             errorKey: response.messageKey,
//           );
//         }

//         return Flexible(
//           child: SizedBox(
//             height: MediaQuery.of(context).size.height * 0.43,
//             // Specify the desired height
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: places.length,
//               controller: _BeerListViewState.scrollController,
//               itemBuilder: (context, index) {
//                 final place = places[index];
//                 if (place['isFavoritePlace']) {
//                   Future.microtask(() {
//                     ref
//                         .read(favoritePlacesProvider.notifier)
//                         .addFavorite(place['id']);
//                   });
//                 }
//                 return Container(
//                     margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//                     child: CardPlace(
//                       id: place['id'],
//                       backgroundImage: place['images'].isNotEmpty
//                           ? place['images'][0]
//                           : null,
//                       name: place['placeDetail']['name'],
//                       location: place['address']?['city']?['name'],
//                       country: place['address']?['city']?['country']?['name'],
//                       rating: place['popularity'],
//                       isFavoritePlace: place['isFavoritePlace'],
//                     ));
//               },
//             ),
//           ),
//         );
//       },
//       loading: () {
//         // While the data is loading, show a loading spinner
//         return Center(child: CircularProgressIndicator());
//       },
//       error: (error, stack) {
//         // If there is an error, display an error message
//         return ErrorComponent(
//           errorKey: 'defaultError',
//         );
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../client/services/clientProvider.dart';
import '../../common/services/functions.dart';
import '../../graphql/client.dart';
import '../services/function.dart';
import '../services/graphql/graphQlQuery.dart';
import '../services/providers/pagination.dart';
import '../services/providers/places.dart';
import 'FilterPlace.dart';
import 'cardPlace/CardPlace.dart';

class Places extends ConsumerStatefulWidget {
  const Places({super.key});

  @override
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
        _fetchMoreData();
      }
    });
    // Fetch initial data after the widget is fully mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userInfos = ref.read(userInfosProvider); // Read the current value
      if (userInfos?.userId != null) {
        _fetchMoreData();
      }
    });
  }

  Future<void> _fetchMoreData() async {
    final paginationState = ref.watch(paginationProvider);

    if (paginationState.isLoading) {
      debugPrint('Already loading. Skipping fetch...');
      return;
    }

    if (paginationState.totalPage == paginationState.actualPage &&
        paginationState.totalRows != 0) {
      return;
    }

    final locale = Localizations.localeOf(context);
    final index = getIndexOfLanguage(locale.toString());
    final userInfos = ref.watch(userInfosProvider);
    if (userInfos == null) {
      debugPrint('User info is null. Cannot fetch data.');
      return;
    }

    // Set loading to true
    ref.read(paginationProvider.notifier).setLoading(true);

    try {
      final filterProvider = ref.read(selectedButtonProvider);
      final placeRepository = PlaceRepository(GraphQLClientSingleton().client);
      final result = await placeRepository.fetchPlaces(
          language: index.toString(),
          type: filterProvider.toString(),
          userId: userInfos.userId,
          page: paginationState.actualPage.toString());
      final List<dynamic> placesReceivedFromServer = result.data?['places'];

      if (placesReceivedFromServer.isNotEmpty) {
        ref.read(placesProvider.notifier).addPlaces(placesReceivedFromServer);
        ref
            .read(paginationProvider.notifier)
            .updateRowPerPage(result.data['rowPerPage']);
        ref
            .read(paginationProvider.notifier)
            .updateTotalRows(result.data['totalRows']);
        ref
            .read(paginationProvider.notifier)
            .updateActualPage(paginationState.actualPage + 1);
      }
    } catch (error) {
      debugPrint('Error fetching data: $error');
    } finally {
      // Reset loading state
      ref.read(paginationProvider.notifier).setLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(placesProvider);
    final paginationState = ref.watch(paginationProvider);

    if (places.isEmpty) {
      return Center(
        child: Text('No places found.'),
      );
    }

    return Flexible(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.43,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: places.length +
              (paginationState.isLoading
                  ? 1
                  : 0), // Add one more item if loading
          controller: _scrollController,
          itemBuilder: (context, index) {
            if (index == places.length) {
              // Loader at the end
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircularProgressIndicator(),
                ),
              );
            }

            final place = places[index];
            if (place['isFavoritePlace']) {
              Future.microtask(() {
                ref
                    .read(favoritePlacesProvider.notifier)
                    .addFavorite(place['id']);
              });
            }
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CardPlace(
                id: place['id'],
                backgroundImage:
                    place['images'].isNotEmpty ? place['images'][0] : null,
                name: place['placeDetail']['name'],
                location: place['address']?['city']?['name'],
                country: place['address']?['city']?['country']?['name'],
                rating: place['popularity'],
                isFavoritePlace: place['isFavoritePlace'],
              ),
            );
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
