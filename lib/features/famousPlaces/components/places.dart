import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/famousPlaces/services/providerState/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../services/providerDogs.dart';

class Places extends ConsumerWidget {
  const Places({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the dogsProvider, which is a FutureProvider
    // final dogListState = ref.watch(dogsProvider);
    final dogListState = ref.watch(placesProviderGraphQL);
    return dogListState.when(
      data: (places) {
        // If the data is available, display the list of places
        if (places.isEmpty) {
          return Center(child: Text('No places found.'));
        }
        return Expanded(
          child: ListView.builder(
            itemCount: places.length,
            itemBuilder: (context, index) {
              final place = places[index];
              return ListTile(
                title: Text(place.id),
                subtitle: Text('${place.popularity.toString()}'),
              );
            },
          ),
        );
      },
      loading: () {
        // While the data is loading, show a loading spinner
        return Center(child: CircularProgressIndicator());
      },
      error: (error, stack) {
        // If there is an error, display an error message
        return Center(child: Text('Error: $error'));
      },
    );
  }
}
