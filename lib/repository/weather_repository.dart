import 'dart:convert';
import 'package:esusu_weather_app/endpoints.dart';
import 'package:esusu_weather_app/models/weather.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRepository {
  Future<Weather> fetchWeather({
    required double latitude,
    required double longitude,
  });
}

class OpenMeteoWeatherRepository implements WeatherRepository {
  OpenMeteoWeatherRepository();

  @override
  Future<Weather> fetchWeather({
    required double latitude,
    required double longitude,
  }) async {
    final queryParameters = {
      "latitude": latitude.toString(),
      "longitude": longitude.toString(),
      "current": [
        "temperature_2m",
        "weather_code",
        "relative_humidity_2m",
        "wind_speed_10m",
      ],
      "daily": [
        "temperature_2m_max",
        "temperature_2m_min",
        "weather_code",
      ],
      "temperature_unit": "fahrenheit",
      "wind_speed_unit": "mph",
      "precipitation_unit": "inch",
    };

    final uri = Uri.https(
      Endpoints.weatherBaseUrl,
      '/v1/forecast',
      queryParameters,
    );

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Weather weather = Weather.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );

      return weather;
    } else {
      throw Exception(response.body);
    }
  }
}
