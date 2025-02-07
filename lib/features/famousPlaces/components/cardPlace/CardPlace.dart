import 'package:flutter/material.dart';
import 'package:flutter_famous_places/features/famousPlaces/components/cardPlace/DescriptionCard.dart';
import 'package:flutter_famous_places/features/graphql/services/response.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import '../../../client/providers/clientProvider.dart';
import '../../services/function.dart';

final favoritePlaceProvider = StateProvider.family<bool, String>((ref, id) {
  // Set the initial state for each place based on its id (you can fetch this from a database or API)
  return false; // Assuming it's not a favorite by default
});

class CardPlace extends ConsumerWidget {
  final String? backgroundImage;
  final String name;
  final String id;
  final String location;
  final String country;
  final int rating;
  final bool isFavoritePlace;

  const CardPlace({
    super.key,
    required this.backgroundImage,
    required this.name,
    required this.id,
    required this.location,
    required this.country,
    required this.rating,
    required this.isFavoritePlace,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfos = ref.read(userInfosProvider);

    final List<String> favorites = ref.watch(favoritePlacesProvider);
    bool isIn = favorites.contains(id);

    return Padding(
        padding: const EdgeInsets.only(bottom: 15.0, right: 20, top: 10),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.60,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: backgroundImage is String
                  ? NetworkImage(backgroundImage!)
                  : AssetImage("assets/images/No_Image_Available.jpg")
                      as ImageProvider,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(118, 29, 29, 29), // Shadow color
                offset: Offset(4, 10), // Moves shadow 4 pixels downward
                blurRadius: 12, // Reduces the spread of blur effect
                spreadRadius: -7, // Reduces the width of the shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  width: 50,
                  height: 50,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  decoration: BoxDecoration(
                    color: isIn ? Colors.red : Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async {
                        ResponseGraphql<String> res =
                            await toggleFavoritePlace(id, userInfos!.userId);
                        if (!res.isError) {
                          final notifier =
                              ref.read(favoritePlacesProvider.notifier);
                          if (isIn) {
                            notifier.removeFavorite(id);
                          } else {
                            notifier.addFavorite(id);
                          }
                        }
                      },
                      child: SvgPicture.asset(
                        'assets/icons/divers/heart.svg',
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Color.fromARGB(255, 3, 30, 59).withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DescriptionCard(
                    name: name,
                    location: location,
                    country: country,
                    rating: rating,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
