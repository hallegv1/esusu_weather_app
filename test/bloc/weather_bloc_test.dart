import 'package:esusu_weather_app/bloc/weather_bloc.dart';
import 'package:esusu_weather_app/repository/location_repository.dart';
import 'package:esusu_weather_app/repository/weather_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockLocationRepository extends Mock implements LocationRepository {}

void main() {
  late WeatherRepository weatherRepository;
  late LocationRepository locationRepository;

  group('WeatherBloc', () {
    setUp(() {
      weatherRepository = MockWeatherRepository();
      locationRepository = MockLocationRepository();
    });

    test('initialization', () {
      final bloc = WeatherBloc(
        weatherRepository: weatherRepository,
        locationRepository: locationRepository,
      );
      expect(
        bloc.state,
        WeatherStateInitial(),
      );
    });
  });
}
