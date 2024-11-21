import 'package:bloc_test/bloc_test.dart';
import 'package:esusu_weather_app/bloc/weather_bloc.dart';
import 'package:esusu_weather_app/pages/weather_page.dart';
import 'package:esusu_weather_app/repository/location_repository.dart';
import 'package:esusu_weather_app/repository/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockWeatherRepository extends Mock implements WeatherRepository {}

class MockLocationRepository extends Mock implements LocationRepository {}

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  group('WeatherView', () {
    testWidgets('renders correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: WeatherView(isLoading: false),
        ),
      );

      expect(find.byType(AppBar), findsOne);
      expect(find.byType(Stack), findsWidgets);
      expect(find.byType(Container), findsWidgets);
    });
  });

  group('WeatherBlocListener', () {
    late WeatherBloc weatherBloc;

    setUp(() {
      weatherBloc = MockWeatherBloc();
    });

    testWidgets('Weather UI is hidden on [initial]', (tester) async {
      when(
        () => weatherBloc.state,
      ).thenReturn(WeatherStateInitial());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: weatherBloc,
            child: const WeatherView(isLoading: true),
          ),
        ),
      );

      expect(find.text('Show Map'), findsNothing);
      expect(find.text('Humidity is'), findsNothing);
      expect(find.text('Wind speed is'), findsNothing);
      expect(find.byKey(const Key("Current Info")), findsNothing);
      expect(find.byKey(const Key("Weather Info")), findsNothing);
    });
  });
}
