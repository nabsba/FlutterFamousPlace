import 'package:flutter_famous_places/features/placeDetail/services/Place.dart';
import 'package:go_router/go_router.dart';

import '../../../pages/booking/booking.dart';
import '../../../pages/favorite/favorite.dart';
import '../../../pages/home/home.dart';
import '../../../pages/placeDetail/placeDetail.dart';
import '../../../pages/userProfile/userProfile.dart';
import '../../layouts/main/PageSwitcher.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PageSwitcher(),
    ),
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
        path: BookingPage.routeName,
        builder: (context, state) {
          return BookingPage();
        }),
    GoRoute(
        path: FavoritePage.routeName,
        builder: (context, state) {
          return FavoritePage();
        }),
    GoRoute(
      path: UserProfilePage.routeName,
      builder: (context, state) => const UserProfilePage(),
    ),
    GoRoute(
      path: PlaceDetailPage.routeName,
      builder: (context, state) {
        // Extract the 'place' object from the state
        final place = state.extra as Place;
        return PlaceDetailPage(place: place); // Pass the place to the page
      },
    ),
  ],
);

GoRouter get router => _router;
