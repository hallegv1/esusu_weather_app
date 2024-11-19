import 'package:esusu_weather_app/pages/weather_page.dart';
import 'package:esusu_weather_app/repository/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final WeatherRepository weatherRepository = OpenMeteoWeatherRepository();

  runApp(
    MultiProvider(
      providers: [
        Provider<WeatherRepository>.value(value: weatherRepository),
      ],
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WeatherPage(),
    );
  }
}
