class Hourly {
  final List<dynamic>? time;
  final List<dynamic>? temperature2m;
  final List<dynamic>? relativeHumidity2m;
  final List<dynamic>? dewPoint2m;
  final List<dynamic>? precipitation;
  final List<dynamic>? rain;
  final List<dynamic>? showers;
  final List<dynamic>? snowfall;
  final List<dynamic>? windSpeed10m;
  final List<dynamic>? windDirection10m;
  final List<dynamic>? temperature80m;

  Hourly({
    required this.time,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.dewPoint2m,
    required this.precipitation,
    required this.rain,
    required this.showers,
    required this.snowfall,
    required this.windSpeed10m,
    required this.windDirection10m,
    required this.temperature80m,
  });

  factory Hourly.fromJson(Map<String, dynamic> data) {
    final List<dynamic>? time = data['time'];
    final List<dynamic>? temperature2m = data['temperature_2m'];
    final List<dynamic>? relativeHumidity2m = data['relative_humidity_2m'];
    final List<dynamic>? dewPoint2m = data['dew_point_2m'];
    final List<dynamic>? precipitation = data['precipitation'];
    final List<dynamic>? rain = data['rain'];
    final List<dynamic>? showers = data['showers'];
    final List<dynamic>? snowfall = data['snowfall'];
    final List<dynamic>? windSpeed10m = data['wind_speed_10m'];
    final List<dynamic>? windDirection10m = data['wind_direction_10m'];
    final List<dynamic>? temperature80m = data['temperature_80m'];

    return Hourly(
      time: time,
      temperature2m: temperature2m,
      relativeHumidity2m: relativeHumidity2m,
      dewPoint2m: dewPoint2m,
      precipitation: precipitation,
      rain: rain,
      showers: showers,
      snowfall: snowfall,
      windSpeed10m: windSpeed10m,
      windDirection10m: windDirection10m,
      temperature80m: temperature80m,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m': temperature2m,
      'relative_humidity_2m': relativeHumidity2m,
      'dew_point_2m': dewPoint2m,
      'precipitation': precipitation,
      'rain': rain,
      'showers': showers,
      'snowfall': snowfall,
      'wind_speed_10m': windSpeed10m,
      'wind_direction_10m': windDirection10m,
      'temperature_80m': temperature80m,
    };
  }
}
