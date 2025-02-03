import 'package:sqflite/sqflite.dart';

import '../../../placeDetail/services/Place.dart';

Future<List<Place>> getPlaces(Database db) async {
  try {
    // Execute the raw query
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT 
        Place.id AS placeId,
        Place.popularity,
        Place.price,
        Place.hoursTravel,
        Address.id AS addressId,
        Address.number,
        Address.street,
        Address.postcode,
        City.id AS cityId,
        City.name AS cityName,
        Country.id AS countryId,
        Country.name AS countryName,
        PlaceDetail.id AS placeDetailId,
        PlaceDetail.name AS placeDetailName,
        PlaceDetail.description,
        PlaceDetail.languageId
      FROM Place
      INNER JOIN Address ON Place.addressId = Address.id
      INNER JOIN City ON Address.cityId = City.id
      INNER JOIN Country ON City.countryId = Country.id
      INNER JOIN PlaceDetail ON Place.id = PlaceDetail.placeId
    ''');

    // Map the results to a list of Place objects
    return List.generate(maps.length, (i) {
      return Place(
        id: maps[i]['placeId'],
        popularity: maps[i]['popularity'],
        price: maps[i]['price'],
        hoursTravel: maps[i]['hoursTravel'],
        images: [],
        isFavoritePlace: false,
        address: Address(
          id: maps[i]['addressId'],
          number: maps[i]['number'],
          street: maps[i]['street'],
          postcode: maps[i]['postcode'],
          city: City(
            id: maps[i]['cityId'],
            name: maps[i]['cityName'],
            country: Country(
              id: maps[i]['countryId'],
              name: maps[i]['countryName'],
            ),
          ),
        ),
        placeDetail: PlaceDetail(
          id: maps[i]['placeDetailId'],
          name: maps[i]['placeDetailName'],
          description: maps[i]['description'],
          languageId: maps[i]['languageId'],
        ),
      );
    });
  } catch (e) {
    // Handle any errors that occur during the database operation
    print('Error fetching places: $e');

    // Return an empty list or rethrow the exception, depending on your use case
    return [];
    // Alternatively, you can rethrow the exception:
    // throw e;
  }
}
