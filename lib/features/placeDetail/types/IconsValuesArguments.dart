class IconValueArguments {
  final String city;
  final int popularity;
  final String hoursTravel;

  const IconValueArguments({
    required this.city,
    required this.popularity,
    required this.hoursTravel,
  });

  @override
  String toString() {
    return 'IconValueArguments(city: $city, popularity: $popularity)';
  }
}
