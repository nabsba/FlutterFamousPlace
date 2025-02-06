import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../features/famousPlaces/components/places.dart';
import '../../features/famousPlaces/services/data/constant.dart';
import '../../features/famousPlaces/services/providers/menuSelected.dart';

class FavoritePage extends ConsumerWidget {
  const FavoritePage({super.key});
  static const routeName = "/favorite";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future(() {
      if (ref.watch(menuSelected).menuOnSelection != menus[4]) {
        ref.read(menuSelected.notifier).updateMenuOnSelection(menus[4]);
      }
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment
              .start, // Aligns title and subtitle to the start
          children: [
            Text('Favourite place'),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.all(10.0), // Add padding around contents
            child: Center(
              child: SizedBox(
                height: 400.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Places(),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
