import 'package:esusu_weather_app/bloc/weather_bloc.dart';
import 'package:esusu_weather_app/models/current.dart';
import 'package:esusu_weather_app/models/daily.dart';
import 'package:esusu_weather_app/models/weather.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WeatherState', () {
    group('initializes', () {
      test('can initialize', () {
        expect(
          WeatherStateInitial(),
          isNotNull,
        );
      });

      test('FetchWeather success', () {
        final weather = Weather(
          latitude: 20,
          longitude: 20,
          generationTimeMs: 20,
          utcOffsetSeconds: 20,
          timezone: 'PST',
          timezoneAbbreviation: 'PST',
          elevation: 20,
          dailyUnits: DailyUnits(
            time: "20:00",
            temperature2mMax: "F",
            temperature2mMin: "F",
            weatherCode: "",
          ),
          daily: Daily(
            time: [],
            temperature2mMax: [],
            temperature2mMin: [],
            weatherCode: [],
          ),
          current: Current(
            time: "20:00",
            temperature2m: 20,
            interval: 1,
            relativeHumidity2m: 2,
            windSpeed10m: 20,
            weatherCode: 1,
          ),
          currentUnits: CurrentUnits(
            time: "20:00",
            interval: "",
            temperature2m: "F",
            relativeHumidity2m: "F",
            windSpeed10m: "mp/h",
            weatherCode: "",
          ),
        );

        final state = WeatherStateSuccess(weather);

        expect(
          state.weather,
          weather,
        );
      });
    });
  });
}
