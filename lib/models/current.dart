class Current {
  final String time;
  final int interval;
  final double temperature2m;
  final int relativeHumidity2m;
  final double windSpeed10m;
  final int weatherCode;

  Current({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.windSpeed10m,
    required this.weatherCode,
  });

  factory Current.fromJson(Map<String, dynamic> data) {
    final time = data['time'];
    final interval = data['interval'];
    final temperature2m = data['temperature_2m'];
    final relativeHumidity2m = data['relative_humidity_2m'];
    final windSpeed10m = data['wind_speed_10m'];
    final weatherCode = data['weather_code'];

    return Current(
      time: time,
      interval: interval,
      temperature2m: temperature2m,
      relativeHumidity2m: relativeHumidity2m,
      windSpeed10m: windSpeed10m,
      weatherCode: weatherCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'interval': interval,
      'temperature_2m': temperature2m,
      'relative_humidity_2m': relativeHumidity2m,
      'wind_speed_10m': windSpeed10m,
      'weather_code': weatherCode,
    };
  }
}

class CurrentUnits {
  final String time;
  final String interval;
  final String temperature2m;
  final String relativeHumidity2m;
  final String windSpeed10m;
  final String weatherCode;

  CurrentUnits({
    required this.time,
    required this.interval,
    required this.temperature2m,
    required this.relativeHumidity2m,
    required this.windSpeed10m,
    required this.weatherCode,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> data) {
    final time = data['time'];
    final interval = data['interval'];
    final temperature2m = data['temperature_2m'];
    final relativeHumidity2m = data['relative_humidity_2m'];
    final windSpeed10m = data['wind_speed_10m'];
    final weatherCode = data['weather_code'];

    return CurrentUnits(
      time: time,
      interval: interval,
      temperature2m: temperature2m,
      relativeHumidity2m: relativeHumidity2m,
      windSpeed10m: windSpeed10m,
      weatherCode: weatherCode,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'interval': interval,
      'temperature_2m': temperature2m,
      'relative_humidity_2m': relativeHumidity2m,
      'wind_speed_10m': windSpeed10m,
      'weather_code': weatherCode,
    };
  }
}
