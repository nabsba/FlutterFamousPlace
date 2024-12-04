class Place {
  final String id;
  final int popularity;
  Place({
    required this.id,
    required this.popularity,
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {'id': id, "popularity": popularity};
  }

  // Convert a Map to a Dog instance.
  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map['id'],
      popularity: map['popularity'],
    );
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return '{id: $id, popularity: $popularity}';
  }
}
