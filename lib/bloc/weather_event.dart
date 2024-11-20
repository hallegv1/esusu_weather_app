part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetchWeather extends WeatherEvent {
  final double? latitude;
  final double? longitude;

  const FetchWeather({
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [];
}
