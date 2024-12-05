import 'package:go_router/go_router.dart';

import '../../../pages/booking/booking.dart';
import '../../../pages/favorite/favorite.dart';
import '../../../pages/home/home.dart';
import '../../../pages/userProfile/userProfile.dart';
import '../../layouts/main/mainLayout.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainLayout(),
    ),
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) => const HomePage(),
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
    )
  ],
);

GoRouter get router => _router;
