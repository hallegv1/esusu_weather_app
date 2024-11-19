import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:esusu_weather_app/models/weather.dart';
import 'package:esusu_weather_app/repository/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository repository;

  WeatherBloc({
    required this.repository,
  }) : super(const WeatherState()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    final weather = await repository.fetchWeather();
    emit(WeatherStateSuccess(weather));
  }
}
