import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../client/services/clientProvider.dart';
import '../../error/components/error.dart';
import '../../error/services/errors.dart';
import '../../loaders/components/timeLoadingWidget.dart';
import '../../loaders/services/constant.dart';
import '../services/function.dart';
import '../services/providers/fetchPlaces.dart';
import '../services/providers/indexMenu.dart';
import '../services/providers/pagination.dart';
import '../services/providers/places.dart';
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
        ref.read(placesNotifierProvider.notifier).fetchMoreData(ref, context);
      }
    });

    // Fetch initial data after the widget is fully mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userInfos = ref.read(userInfosProvider);
      if (userInfos?.userId != null) {
        ref.read(placesNotifierProvider.notifier).fetchMoreData(ref, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final paginationState = ref.watch(paginationProvider);
    final userInfos = ref.watch(userInfosProvider);
    final menuSelectedd = ref.watch(menuSelected).newIndex;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userInfos != null && userInfos.userId.isNotEmpty) {
        ref.read(placesNotifierProvider.notifier).fetchMoreData(ref, context);
      }
    });

    final places = ref.watch(placesProvider)[menuSelectedd.toString()];

    if (places!.isEmpty) {
      if (paginationState[menuSelectedd.toString()]!.isLoading) {
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
        height: MediaQuery.of(context).size.height * 0.43,
        child: paginationState[menuSelectedd.toString()]!
                    .messageKey
                    .isNotEmpty &&
                places.isEmpty
            ? Center(
                child: ErrorComponent(
                  errorKey:
                      paginationState[menuSelectedd.toString()]!.messageKey,
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: places.length +
                    (paginationState[menuSelectedd.toString()]!.isLoading
                        ? 1
                        : 0),
                controller: _scrollController,
                itemBuilder: (context, index) {
                  if (index == places.length) {
                    return LoadingWidget(
                        errorKey: errorMessagesKeys['CANNOT_LOAD_MORE_DATA']!,
                        loadingType: LoaderMessagesKeys.skelaton);
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
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
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
