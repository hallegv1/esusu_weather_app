import 'dart:convert';
import 'package:esusu_weather_app/endpoints.dart';
import 'package:esusu_weather_app/models/weather.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRepository {
  Future<Weather> fetchWeather();
  Future<Position> getCurrentLocation();
}

class OpenMeteoWeatherRepository implements WeatherRepository {
  OpenMeteoWeatherRepository();

  @override
  Future<Weather> fetchWeather() async {
    final location = await getCurrentLocation();

    final queryParameters = {
      "latitude": location.latitude.toString(),
      "longitude": location.longitude.toString(),
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
      print(response.body);

      return weather;
    } else {
      throw Exception(response.body);
    }
  }

  @override
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    return await Geolocator.getCurrentPosition(
      locationSettings: locationSettings,
    );
  }
}
