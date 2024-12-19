import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/animations/conditionalAnimatedSwitch.dart';
import 'package:flutter_famous_places/features/authorisation/components/authorisation.dart';
import 'package:flutter_famous_places/pages/booking/booking.dart';
import 'package:flutter_famous_places/pages/favorite/favorite.dart';
import 'package:flutter_famous_places/pages/userProfile/userProfile.dart';
import 'package:flutter_svg/svg.dart';
import '../../../pages/home/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../covers/mainCover.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MainLayout> {
  int currentPageIndex = 0;
  bool showMainCover = true;

  // List of pages to be displayed
  final List<Widget> _pages = [
    const HomePage(),
    const BookingPage(),
    const FavoritePage(),
    const UserProfilePage(),
  ];

  // Handle tab selection
  void _onDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index; // Update the selected index
    });
  }

  @override
  void initState() {
    super.initState();
    // Schedule the transition after 10 seconds
    Timer(const Duration(seconds: 2), () {
      setState(() {
        showMainCover = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConditionalAnimatedSwitcher(
      firstWidget: const MainCover(),
      secondWidget: AuthorizationWrapper(
        signedInWidget: Scaffold(
          appBar: AppBar(
            // The [AppBar] title text should update its message
            // according to the system locale of the target platform.
            // Switching between English and Spanish locales should
            // cause this text to update.
            title: Text(AppLocalizations.of(context)!.greetingMessage('Nabil')),
          ),
          body: _pages[currentPageIndex], // Show the selected widget
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0), // Add padding to left and right
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ), // Add padding to left and right
              child: NavigationBar(
                indicatorColor: Colors.transparent,
                backgroundColor: Colors.transparent,
                selectedIndex: currentPageIndex,
                elevation: 0.0, // Removes any shadows or elevation
                shadowColor: Colors.transparent,
                onDestinationSelected: _onDestinationSelected,
                labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                destinations: <NavigationDestination>[
                  NavigationDestination(
                    selectedIcon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/navigationBottom/onSelection/home.svg',
                          width: 25,
                          height: 25,
                        ),
                        Positioned(
                          bottom: -20,
                          right: 7,
                          child: Container(
                            width: 10,
                            height: 15,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/navigationBottom/offSelection/home.svg',
                      width: 25,
                      height: 25,
                    ),
                    label: '',
                  ),
                  NavigationDestination(
                    selectedIcon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/navigationBottom/onSelection/time.svg',
                          width: 25,
                          height: 25,
                        ),
                        Positioned(
                          bottom: -17,
                          right: 6,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/navigationBottom/offSelection/time.svg',
                      width: 25,
                      height: 25,
                    ),
                    label: '',
                  ),
                  NavigationDestination(
                    selectedIcon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/navigationBottom/onSelection/heart.svg',
                          width: 25,
                          height: 25,
                        ),
                        Positioned(
                          bottom: -17,
                          right: 7,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/navigationBottom/offSelection/heart.svg',
                      width: 25,
                      height: 25,
                    ),
                    label: '',
                  ),
                  NavigationDestination(
                    selectedIcon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/navigationBottom/onSelection/user.svg',
                          width: 25,
                          height: 25,
                        ),
                        Positioned(
                          bottom: -17,
                          right: 5,
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                    icon: SvgPicture.asset(
                      'assets/icons/navigationBottom/offSelection/user.svg',
                      width: 25,
                      height: 25,
                    ),
                    label: '',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      duration: const Duration(milliseconds: 500),
      condition: showMainCover,
    );
  }
}
