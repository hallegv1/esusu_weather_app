class Daily {
  final List<String> time;
  final List<double> temperature2mMax;
  final List<double> temperature2mMin;
  final List<int> weatherCode;

  Daily({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.weatherCode,
  });

  factory Daily.fromJson(Map<String, dynamic> data) {
    return Daily(
      time: List<String>.from(data['time']),
      temperature2mMax: List<double>.from(data['temperature_2m_max']),
      temperature2mMin: List<double>.from(data['temperature_2m_min']),
      weatherCode: List<int>.from(data['weather_code']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m_max': temperature2mMax,
      'temperature_2m_min': temperature2mMin,
      'weather_code': weatherCode,
    };
  }
}

class DailyUnits {
  final String? time;
  final String? temperature2mMax;
  final String? temperature2mMin;
  final String? weatherCode;

  DailyUnits({
    required this.time,
    required this.temperature2mMax,
    required this.temperature2mMin,
    required this.weatherCode,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> data) {
    return DailyUnits(
      time: data['time'],
      temperature2mMax: data['temperature_2m_max'],
      temperature2mMin: data['temperature_2m_min'],
      weatherCode: data['weather_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'temperature_2m_max': temperature2mMax,
      'temperature_2m_min': temperature2mMin,
      'weather_code': weatherCode,
    };
  }
}
