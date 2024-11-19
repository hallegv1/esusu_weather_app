class Hourly {
  final List<String> time;
  final List<double> temperature2m;
  final List<double> relativeHumidity2m;
  final List<double> precipitation;
  final List<double> rain;
  final List<double> showers;
  final List<double> snowfall;
  final List<double> windSpeed10m;
  final List<double> windDirection10m;

  Hourly({
    required this.time,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.precipitation,
    required this.rain,
    required this.showers,
    required this.snowfall,
    required this.windSpeed10m,
    required this.windDirection10m,
  });

  factory Hourly.fromJson(Map<String, dynamic> data) {
    final List<String> time = data['time'];
    final List<double> temperature2m = data['temperature_2m'];
    final List<double> relativeHumidity2m = data['relative_humidity_2m'];
    final List<double> precipitation = data['precipitation'];
    final List<double> rain = data['rain'];
    final List<double> showers = data['showers'];
    final List<double> snowfall = data['snowfall'];
    final List<double> windSpeed10m = data['wind_speed_10m'];
    final List<double> windDirection10m = data['wind_direction_10m'];

    return Hourly(
      time: time,
      temperature2m: temperature2m,
      relativeHumidity2m: relativeHumidity2m,
      precipitation: precipitation,
      rain: rain,
      showers: showers,
      snowfall: snowfall,
      windSpeed10m: windSpeed10m,
      windDirection10m: windDirection10m,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m': temperature2m,
      'relative_humidity_2m': relativeHumidity2m,
      'precipitation': precipitation,
      'rain': rain,
      'showers': showers,
      'snowfall': snowfall,
      'wind_speed_10m': windSpeed10m,
      'wind_direction_10m': windDirection10m,
    };
  }
}
