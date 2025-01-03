import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../client/services/clientProvider.dart';
import '../../common/services/functions.dart';
import '../../error/components/error.dart';
import '../../error/services/errors.dart';
import '../../graphql/client.dart';
import '../../loaders/components/timeLoadingWidget.dart';
import '../../loaders/services/constant.dart';
import '../services/function.dart';
import '../services/graphql/graphQlQuery.dart';
import '../services/providers/pagination.dart';
import '../services/providers/places.dart';
import 'FilterPlace.dart';
import 'cardPlace/CardPlace.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      final userInfos = ref.read(userInfosProvider);
      if (userInfos?.userId != null) {
        _fetchMoreData();
      }
    });
  }

  Future<void> _fetchMoreData() async {
    final userInfos = ref.watch(userInfosProvider);
    final paginationState = ref.watch(paginationProvider);
    if (userInfos == null ||
        userInfos.userId.isEmpty ||
        paginationState.isLoading ||
        (paginationState.totalPage == paginationState.actualPage &&
            paginationState.totalRows != 0)) {
      return;
    }

    final locale = Localizations.localeOf(context);
    final index = getIndexOfLanguage(locale.toString());
    ref.read(paginationProvider.notifier).setLoading(true);

    try {
      final filterProvider = ref.read(selectedButtonProvider);
      final placeRepository = PlaceRepository(GraphQLClientSingleton().client);
      final result = await placeRepository.fetchPlaces(
        language: index.toString(),
        type: filterProvider.toString(),
        userId: userInfos.userId,
        page: paginationState.actualPage.toString(),
      );

      final List<dynamic> placesReceivedFromServer =
          result.data?['places'] ?? [];

      if (result.isError) {
        ref.read(paginationProvider.notifier).setIsError(result.messageKey);
      } else if (placesReceivedFromServer.isNotEmpty) {
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
    final userInfos = ref.watch(userInfosProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (userInfos != null && userInfos.userId.isNotEmpty) {
        _fetchMoreData();
      }
    });

    if (places.isEmpty) {
      if (paginationState.isLoading) {
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
        child: paginationState.messageKey.isNotEmpty && places.isEmpty
            ? Center(
                child: ErrorComponent(
                  errorKey: paginationState.messageKey,
                ),
              )
            : ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: places.length + (paginationState.isLoading ? 1 : 0),
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
