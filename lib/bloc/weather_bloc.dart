import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esusu_weather_app/models/weather.dart';
import 'package:esusu_weather_app/repository/location_repository.dart';
import 'package:esusu_weather_app/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;
  final LocationRepository locationRepository;

  WeatherBloc({
    required this.weatherRepository,
    required this.locationRepository,
  }) : super(const WeatherState()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    final currentLocation = await locationRepository.getCurrentLocation();

    double latitude = event.latitude ?? currentLocation.latitude;
    double longitude = event.longitude ?? currentLocation.longitude;

    final weather = await weatherRepository.fetchWeather(
      latitude: latitude,
      longitude: longitude,
    );

    emit(WeatherStateSuccess(weather));
  }
}
