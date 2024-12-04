import 'package:flutter/material.dart';
import 'package:flutter_famous_places/pages/booking/booking.dart';
import 'package:flutter_famous_places/features/layouts/default/default.dart';
import 'package:flutter_famous_places/pages/favorite/favorite.dart';
import 'package:flutter_famous_places/pages/home/home.dart';
import 'package:flutter_famous_places/pages/userProfile/userProfile.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MainApp());
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyDefaultPage(),
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Favorite Place',
      routerConfig: _router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        splashColor:
            Colors.transparent, // renmove the wave effect on button clicked
        useMaterial3: true,
      ),
    );
  }
}
