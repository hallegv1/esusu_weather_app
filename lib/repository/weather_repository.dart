import 'dart:convert';
import 'package:esusu_weather_app/endpoints.dart';
import 'package:esusu_weather_app/models/weather.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRepository {
  Future<Weather> fetchWeather();
}

class OpenMeteoWeatherRepository implements WeatherRepository {
  OpenMeteoWeatherRepository();

  @override
  Future<Weather> fetchWeather() async {
    final queryParameters = {
      "latitude": "52.52",
      "longitude": "13.41",
      "hourly": [
        "temperature_2m",
        "relative_humidity_2m",
        "precipitation",
        "rain",
        "showers",
        "snowfall",
        "wind_speed_10m",
      ],
      "daily": [
        "temperature_2m_max",
        "temperature_2m_min",
        "sunrise",
        "sunset",
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
      final weather = Weather.fromJson(
        jsonDecode(response.body) as Map<String, dynamic>,
      );
      debugPrint(response.body);

      return weather;
    } else {
      throw Exception(response.body);
    }
  }
}
