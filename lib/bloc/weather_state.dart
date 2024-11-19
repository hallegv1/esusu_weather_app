part of 'weather_bloc.dart';

class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherStateInitial extends WeatherState {}

class WeatherStateLoading extends WeatherState {}

class WeatherStateSuccess extends WeatherState {
  final Weather weather;

  const WeatherStateSuccess(this.weather);

  @override
  List<Object> get props => [weather];
}

class WeatherStateFailure extends WeatherState {}
