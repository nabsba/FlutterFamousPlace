import 'package:sqflite/sqflite.dart';

import '../../../error/services/MyLogger.dart';

Future<void> savePlaces(List<dynamic> apiResponse, Database db) async {
  try {
    await db.transaction((txn) async {
      for (var placeData in apiResponse) {
        try {
          int popularity = placeData['popularity'];
          String? price = placeData['price'];
          String? hoursTravel = placeData['hoursTravel'];
          String addressStreet = placeData['address']['street'];
          int addressNumber = placeData['address']['number'];
          String addressPostcode = placeData['address']['postcode'];
          String cityName = placeData['address']['city']['name'];
          String countryName = placeData['address']['city']['country']['name'];
          String placeDetailName = placeData['placeDetail']['name'];
          String placeDetailDescription =
              placeData['placeDetail']['description'];
          String addressId = placeData['address']['id'];
          String placeDetailId = placeData['placeDetail']['id'];
          int placeDetailLanguageId = placeData['placeDetail']['languageId'];
          String placeId = placeData['id'];
          int countryId = placeData['address']['city']['country']['id'];
          int cityId = placeData['address']['city']['id'];

          await _insertOrUpdateCountry(countryName, countryId, txn);
          await _insertOrUpdateCity(cityName, countryId, cityId, txn);
          await _insertOrUpdateAddress(addressId, addressNumber, addressStreet,
              addressPostcode, cityId, txn);
          await _insertOrUpdatePlace(
              placeId, popularity, price, hoursTravel, addressId, txn);
          await _insertOrUpdatePlaceDetail(
              placeDetailId,
              placeId,
              placeDetailName,
              placeDetailDescription,
              placeDetailLanguageId,
              txn);
        } catch (e) {
          MyLogger.logError(e as String);
        }
      }
    });
  } catch (e) {
    MyLogger.logError(e as String);
  }
}

Future<int> _insertOrUpdateCountry(
    String name, int countryId, Transaction txn) async {
  try {
    var result =
        await txn.rawQuery('SELECT * FROM Country WHERE id = ?', [countryId]);
    if (result.isEmpty) {
      await txn.insert('Country', {'name': name, 'id': countryId});
    }
    return countryId;
  } catch (e) {
    return countryId;
  }
}

Future<int> _insertOrUpdateCity(
    String cityName, int countryId, int cityId, Transaction txn) async {
  try {
    var result =
        await txn.rawQuery('SELECT name FROM City WHERE id = ?', [cityId]);
    if (result.isEmpty) {
      await txn.insert(
          'City', {'name': cityName, 'countryId': countryId, 'id': cityId});
    }
    return cityId;
  } catch (e) {
    MyLogger.logError('Error inserting/updating city: $e');

    return cityId;
  }
}

Future<String> _insertOrUpdateAddress(String addressId, int addressNumber,
    String street, String postcode, int cityId, Transaction txn) async {
  try {
    var result = await txn
        .rawQuery('SELECT street FROM Address WHERE id = ?', [addressId]);
    if (result.isEmpty) {
      await txn.insert('Address', {
        'number': addressNumber,
        'street': street,
        'postcode': postcode,
        'cityId': cityId,
        'id': addressId
      });
    }
    return addressId;
  } catch (e) {
    MyLogger.logError('Error inserting/updating city: $e');
    return addressId;
  }
}

Future<String> _insertOrUpdatePlace(
    String placeId,
    int popularity,
    String? price,
    String? hoursTravel,
    String addressId,
    Transaction txn) async {
  try {
    await txn.insert(
      'Place',
      {
        'id': placeId,
        'popularity': popularity,
        'price': price,
        'hoursTravel': hoursTravel,
        'addressId': addressId
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return placeId;
  } catch (e) {
    MyLogger.logError('Error inserting/updating place: $e');
    return placeId;
  }
}

Future<void> _insertOrUpdatePlaceDetail(
    String placeDetailId,
    String placeId,
    String name,
    String description,
    int placeDetailLanguageId,
    Transaction txn) async {
  try {
    await txn.insert(
      'PlaceDetail',
      {
        'id': placeDetailId,
        'placeId': placeId,
        'name': name,
        'description': description,
        'languageId': placeDetailLanguageId
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  } catch (e) {
    MyLogger.logError('Error inserting/updating place detail: $e');
  }
}
