class Place {
  final String id;
  final int popularity;
  final Address address;
  final PlaceDetail placeDetail;
  final List<String?> images;
  final bool isFavoritePlace;

  Place(
      {required this.id,
      required this.popularity,
      required this.address,
      required this.placeDetail,
      required this.images,
      required this.isFavoritePlace});

  // Convert a Place instance into a Map.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'popularity': popularity,
      'address': address.toMap(),
      'placeDetail': placeDetail.toMap(),
      'images': images,
      'isFavoritePlace': isFavoritePlace
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
        isFavoritePlace: map['isFavoritePlace']);
  }

  // Override toString to make it easier to print information about a Place.
  @override
  String toString() {
    return '{id: $id, popularity: $popularity, address: $address, placeDetail: $placeDetail, images: $images, isFavoritePlace: $isFavoritePlace}';
  }
}

class Address {
  final int number;
  final String street;
  final String postcode;
  final City city;

  Address({
    required this.number,
    required this.street,
    required this.postcode,
    required this.city,
  });

  // Convert an Address instance into a Map.
  Map<String, Object?> toMap() {
    return {
      'number': number,
      'street': street,
      'postcode': postcode,
      'city': city.toMap(),
    };
  }

  // Convert a Map to an Address instance.
  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      number: map['number'],
      street: map['street'],
      postcode: map['postcode'],
      city: City.fromMap(map['city']),
    );
  }

  @override
  String toString() {
    return '{number: $number, street: $street, postcode: $postcode, city: $city}';
  }
}

class City {
  final String name;
  final Country country;

  City({
    required this.name,
    required this.country,
  });

  // Convert a City instance into a Map.
  Map<String, Object?> toMap() {
    return {
      'name': name,
      'country': country.toMap(),
    };
  }

  // Convert a Map to a City instance.
  factory City.fromMap(Map<String, dynamic> map) {
    return City(
      name: map['name'],
      country: Country.fromMap(map['country']),
    );
  }

  @override
  String toString() {
    return '{name: $name, country: $country}';
  }
}

class Country {
  final String name;

  Country({required this.name});

  // Convert a Country instance into a Map.
  Map<String, Object?> toMap() {
    return {
      'name': name,
    };
  }

  // Convert a Map to a Country instance.
  factory Country.fromMap(Map<String, dynamic> map) {
    return Country(
      name: map['name'],
    );
  }

  @override
  String toString() {
    return '{name: $name}';
  }
}

class PlaceDetail {
  final String name;
  final String description;

  PlaceDetail({
    required this.name,
    required this.description,
  });

  // Convert a PlaceDetail instance into a Map.
  Map<String, Object?> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }

  // Convert a Map to a PlaceDetail instance.
  factory PlaceDetail.fromMap(Map<String, dynamic> map) {
    return PlaceDetail(
      name: map['name'],
      description: map['description'],
    );
  }

  @override
  String toString() {
    return '{name: $name, description: $description}';
  }
}
