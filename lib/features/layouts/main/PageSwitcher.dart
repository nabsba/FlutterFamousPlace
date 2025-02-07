import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/animations/conditionalAnimatedSwitch.dart';
import 'package:flutter_famous_places/features/authorisation/components/authorisation.dart';
import 'package:flutter_famous_places/pages/booking/booking.dart';
import 'package:flutter_famous_places/pages/favorite/favorite.dart';
import 'package:flutter_famous_places/pages/userProfile/userProfile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../pages/home/home.dart';
import '../../authorisation/components/ConnectivityStatusBanner.dart';
import '../../covers/WelcomeScreen.dart';
import 'providers/welcomeScreenState.dart';

class PageSwitcher extends ConsumerStatefulWidget {
  const PageSwitcher({super.key});

  @override
  ConsumerState<PageSwitcher> createState() => _PageSwitcherState();
}

class _PageSwitcherState extends ConsumerState<PageSwitcher> {
  int currentPageIndex = 0;

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
    // Schedule the transition after 2 seconds
    Timer(const Duration(seconds: 2), () {
      ref.read(welcomeScreenProvider.notifier).doNotDisplayWelcomeScreenAgain();
    });
  }

  @override
  Widget build(BuildContext context) {
    final showWelcomeScreen = ref.watch(welcomeScreenProvider);
    return Stack(children: [
      ConditionalAnimatedSwitcher(
        firstWidget: const WelcomeScreen(),
        secondWidget: AuthorizationWrapper(
          signedInWidget: Scaffold(
            body: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0, // Horizontal padding
                vertical: 10.0, // Vertical padding
              ),
              child: _pages[currentPageIndex],
            ),
            // Show the selected widget
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
        condition: showWelcomeScreen,
      ),
      ConnectivityStatusBanner()
    ]);
  }
}
