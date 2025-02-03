class Place {
  final String id;
  final int popularity;
  final Address address;
  final PlaceDetail placeDetail;
  final List<String?> images;
  final bool isFavoritePlace;
  final String hoursTravel;
  final String? price;

  Place({
    required this.id,
    required this.popularity,
    required this.address,
    required this.placeDetail,
    required this.images,
    required this.isFavoritePlace,
    required this.hoursTravel,
    required this.price,
  });

  // Convert a Place instance into a Map.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'popularity': popularity,
      'address': address.toMap(),
      'placeDetail': placeDetail.toMap(),
      'images': images,
      'isFavoritePlace': isFavoritePlace,
      'price': price
    };
  }

  // Convert a Map to a Place instance.
  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
        id: map['id'],
        popularity: map['popularity'],
        address: Address.fromMap(map['address']),
        placeDetail: PlaceDetail.fromMap(map['placeDetail']),
        images: List<String>.from(map['images']),
        isFavoritePlace: map['isFavoritePlace'],
        hoursTravel: map['hoursTravel'],
        price: map['price']);
  }

  // Override toString to make it easier to print information about a Place.
  @override
  String toString() {
    return '{id: $id, popularity: $popularity, price: $price, hoursTravel: $hoursTravel, address: $address, placeDetail: $placeDetail, images: $images, isFavoritePlace: $isFavoritePlace}';
  }
}

class Address {
  final int number;
  final String street;
  final String postcode;
  final City city;
  final String id;

  Address({
    required this.number,
    required this.street,
    required this.postcode,
    required this.city,
    required this.id,
  });

  // Convert an Address instance into a Map.
  Map<String, Object?> toMap() {
    return {
      'number': number,
      'street': street,
      'postcode': postcode,
      'city': city.toMap(),
      'id': id
    };
  }

  // Convert a Map to an Address instance.
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      number: map['number'],
      street: map['street'],
      postcode: map['postcode'],
      id: map['id'],
      city: City.fromMap(map['city']),
    );
  }

  @override
  String toString() {
    return '{number: $number, street: $street, postcode: $postcode, city: $city, id: $id}';
  }
}

class City {
  final String name;
  final Country country;
  final int id;

  City({
    required this.name,
    required this.country,
    required this.id,
  });

  // Convert a City instance into a Map.
  Map<String, Object?> toMap() {
    return {'name': name, 'country': country.toMap(), 'id': id};
  }

  // Convert a Map to a City instance.
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      name: map['name'],
      country: Country.fromMap(map['country']),
      id: map['id'],
    );
  }

  @override
  String toString() {
    return '{name: $name, country: $country}';
  }
}

class Country {
  final String name;
  final int id;

  Country({required this.name, required this.id});

  // Convert a Country instance into a Map.
  Map<String, Object?> toMap() {
    return {'name': name, 'id': id};
  }

  // Convert a Map to a Country instance.
  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(name: map['name'], id: map['id']);
  }

  @override
  String toString() {
    return '{name: $name, id: $id}';
  }
}

class PlaceDetail {
  final String name;
  final String description;
  final String id;
  final int languageId;

  PlaceDetail({
    required this.name,
    required this.description,
    required this.id,
    required this.languageId,
  });

  // Convert a PlaceDetail instance into a Map.
  Map<String, Object?> toMap() {
    return {
      'name': name,
      'description': description,
      'id': id,
      'languageId': languageId
    };
  }

  // Convert a Map to a PlaceDetail instance.
  factory PlaceDetail.fromMap(Map<String, dynamic> map) {
    return PlaceDetail(
        name: map['name'],
        description: map['description'],
        id: map['id'],
        languageId: map['languageId']);
  }

  @override
  String toString() {
    return '{name: $name, description: $description, id: $id, languageId $languageId}';
  }
}
