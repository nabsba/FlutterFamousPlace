import 'package:flutter/material.dart';
import 'package:flutter_famous_places/pages/booking/booking.dart';
import 'package:flutter_famous_places/pages/favorite/favorite.dart';
import 'package:flutter_famous_places/pages/userProfile/userProfile.dart';
import '../../pages/home/home.dart';

class MyDefaultPage extends StatefulWidget {
  const MyDefaultPage({super.key});

  @override
  State<MyDefaultPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyDefaultPage> {
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPageIndex], // Show the selected widget
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: const <NavigationDestination>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.info),
            icon: Icon(Icons.info_outline),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.contact_page),
            icon: Icon(Icons.contact_page_outlined),
            label: '',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.contact_page),
            icon: Icon(Icons.contact_page_outlined),
            label: '',
          ),
        ],
      ),
    );
  }
}
