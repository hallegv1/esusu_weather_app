import 'dart:ui';

import 'package:esusu_weather_app/bloc/weather_bloc.dart';
import 'package:esusu_weather_app/models/current.dart';
import 'package:esusu_weather_app/models/daily.dart';
import 'package:esusu_weather_app/models/weather.dart';
import 'package:esusu_weather_app/models/weather_code.dart';
import 'package:esusu_weather_app/repository/weather_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(
        repository: context.read<WeatherRepository>(),
      )..add(
          const FetchWeather(),
        ),
      child: WeatherPageListener(
        onFetchWeather: () {},
        onLoading: () {},
        onSuccess: () {},
        onFailure: () {},
        child: const WeatherPageBlocBuilder(),
      ),
    );
  }
}

class WeatherPageListener extends StatelessWidget {
  final Widget child;
  final void Function() onFetchWeather;
  final void Function() onLoading;
  final void Function() onSuccess;
  final void Function() onFailure;

  const WeatherPageListener({
    super.key,
    required this.child,
    required this.onFetchWeather,
    required this.onLoading,
    required this.onSuccess,
    required this.onFailure,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherBloc, WeatherState>(
      listener: (context, state) {
        switch (state) {
          case WeatherStateInitial():
            onFetchWeather();
          case WeatherStateLoading():
            onLoading();
          case WeatherStateSuccess():
            onSuccess();
          case WeatherStateFailure():
            onFailure();
        }
      },
      child: child,
    );
  }
}

class WeatherPageBlocBuilder extends StatelessWidget {
  const WeatherPageBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      bloc: context.read<WeatherBloc>(),
      builder: (context, state) {
        if (state is WeatherStateInitial ||
            state is WeatherStateLoading ||
            state is WeatherStateFailure) {
          return const WeatherView();
        } else if (state is WeatherStateSuccess) {
          return WeatherView(
            weather: state.weather,
          );
        } else {
          return const WeatherView();
        }
      },
    );
  }
}

class WeatherView extends StatefulWidget {
  final Weather? weather;

  const WeatherView({
    super.key,
    this.weather,
  });

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  String _formatDate({
    required String date,
    required String format,
  }) {
    final dateTime = DateTime.parse(date).toLocal();
    return DateFormat(format).format(dateTime);
  }

  String _formatDateTime({
    required String date,
    required String format,
  }) {
    final dateTime = DateTime.parse(date).toLocal();
    return DateFormat(format).format(dateTime);
  }

  PreferredSizeWidget _appBar() => AppBar(
        backgroundColor: Colors.transparent,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
        title: widget.weather != null
            ? _title(date: widget.weather!.daily.time.first)
            : null,
      );

  Widget _circleDecoration({
    required double alignmentStart,
    required double alignmentY,
    required Color circleColor,
    double circleSize = 300,
  }) =>
      Align(
        alignment: AlignmentDirectional(alignmentStart, alignmentY),
        child: Container(
          width: circleSize,
          height: circleSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: circleColor,
          ),
        ),
      );

  List<Widget> _gradientBackgroundItems({
    required int weatherCode,
  }) {
    final Color baseColor =
        weatherCode < 3 ? Colors.lightBlue : Colors.blueGrey;
    final Color accentColor = weatherCode < 3 ? Colors.yellow : Colors.grey;

    return [
      _circleDecoration(
        alignmentStart: 3,
        alignmentY: -0.5,
        circleColor: baseColor,
      ),
      _circleDecoration(
        alignmentStart: -3,
        alignmentY: -0.5,
        circleColor: baseColor,
      ),
      _circleDecoration(
        alignmentStart: 0,
        alignmentY: -5.5,
        circleColor: accentColor,
        circleSize: 600,
      ),
      BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
        child: Container(
          decoration: const BoxDecoration(color: Colors.transparent),
        ),
      ),
    ];
  }

  Widget _weatherInfo({
    required Daily daily,
    required Current current,
    required CurrentUnits units,
  }) =>
      SingleChildScrollView(
        child: Column(
          children: [
            _currentInfo(current: current, units: units),
            _dailyItemsList(daily: daily, temperatureUnit: units.temperature2m),
          ],
        ),
      );

  Widget _currentInfo({
    required Current current,
    required CurrentUnits units,
  }) =>
      Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "It's ${weatherDescriptionMap[current.weatherCode.toWeatherCode()]} today.",
              style: const TextStyle(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            Icon(
              weatherIconMap[current.weatherCode.toWeatherCode()],
              size: 80,
              color: Colors.white,
            ),
            Text(
              'Humidity is ${current.relativeHumidity2m}${units.relativeHumidity2m}.\nWind speed is ${current.windSpeed10m}${units.windSpeed10m}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            Text(
              '${current.temperature2m.toString()} ${units.temperature2m}',
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

  Widget _dailyItemsList({
    required Daily daily,
    required String temperatureUnit,
  }) {
    int count = daily.time.length;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: count,
      itemBuilder: (context, index) {
        String time = daily.time[index];
        double tempMax = daily.temperature2mMax[index];
        double tempMin = daily.temperature2mMin[index];
        return _dailyItem(
          time: time,
          tempMax: tempMax,
          tempMin: tempMin,
          temperatureUnit: temperatureUnit,
        );
      },
    );
  }

  Widget _dailyItem({
    required String time,
    required double tempMax,
    required double tempMin,
    required String temperatureUnit,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDate(
                date: time,
                format: 'EE d',
              ),
              style: const TextStyle(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_upward,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            '$tempMax $temperatureUnit',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.arrow_downward,
                            size: 20,
                            color: Colors.white,
                          ),
                          Text(
                            '$tempMin $temperatureUnit',
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _title({
    required String date,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Text(
          _formatDateTime(
            date: date,
            format: 'MMMEd',
          ),
          style: const TextStyle(
            fontSize: 25,
            color: Colors.white,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final backgroundColor =
        widget.weather != null && widget.weather!.current.weatherCode > 2
            ? Colors.blueGrey
            : Colors.blue;

    return Scaffold(
      backgroundColor: backgroundColor,
      extendBody: true,
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              ..._gradientBackgroundItems(
                weatherCode: widget.weather?.current.weatherCode ?? 2,
              ),
              if (widget.weather != null)
                _weatherInfo(
                  daily: widget.weather!.daily,
                  current: widget.weather!.current,
                  units: widget.weather!.currentUnits,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
