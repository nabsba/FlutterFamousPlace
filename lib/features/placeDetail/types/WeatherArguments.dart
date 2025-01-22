class Weather {
  final String city;
  final double temperature;
  final String description;
  final int humidity;
  final double windSpeed;
  final String sunrise;

  Weather({
    required this.city,
    required this.temperature,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.sunrise,
  });

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      city: map['city'],
      temperature: map['temperature'],
      description: map['description'],
      humidity: map['humidity'],
      windSpeed: map['windSpeed'],
      sunrise: map['sunrise'],
    );
  }
}
