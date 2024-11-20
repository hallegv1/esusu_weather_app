import 'package:esusu_weather_app/bloc/weather_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FetchWeatherEvent', () {
    group('FetchWeather', () {
      test('initalizes', () {
        expect(
          const FetchWeather(),
          isNotNull,
        );
      });

      test('supports equality', () {
        const event = FetchWeather();
        expect(
          event,
          equals(const FetchWeather()),
        );
      });
    });
  });
}
