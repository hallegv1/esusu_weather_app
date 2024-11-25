import 'package:esusu_weather_app/models/current.dart';
import 'package:esusu_weather_app/models/daily.dart';

class Weather {
  final double latitude;
  final double longitude;
  final double generationTimeMs;
  final int utcOffsetSeconds;
  final String timezone;
  final String timezoneAbbreviation;
  final double elevation;
  final DailyUnits dailyUnits;
  final Daily daily;
  final Current current;
  final CurrentUnits currentUnits;

  Weather({
    required this.latitude,
    required this.longitude,
    required this.generationTimeMs,
    required this.utcOffsetSeconds,
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.elevation,
    required this.dailyUnits,
    required this.daily,
    required this.current,
    required this.currentUnits,
  });

  factory Weather.fromJson(Map<String, dynamic> data) {
    return Weather(
      latitude: data['latitude'],
      longitude: data['longitude'],
      generationTimeMs: data['generationtime_ms'],
      utcOffsetSeconds: data['utc_offset_seconds'],
      timezone: data['timezone'],
      timezoneAbbreviation: data['timezone_abbreviation'],
      elevation: data['elevation'],
      dailyUnits: DailyUnits.fromJson(data['daily_units']),
      daily: Daily.fromJson(data['daily']),
      current: Current.fromJson(data['current']),
      currentUnits: CurrentUnits.fromJson(data['current_units']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'generationtime_ms': generationTimeMs,
      'utc_offset_seconds': utcOffsetSeconds,
      'timezone': timezone,
      'timezone_abbreviation': timezoneAbbreviation,
      'elevation': elevation,
      'daily_units': dailyUnits.toJson(),
      'daily': daily.toJson(),
      'current': current.toJson(),
      'current_units': currentUnits.toJson(),
    };
  }
}
