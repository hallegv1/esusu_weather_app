import 'dart:ui';

import 'package:esusu_weather_app/bloc/weather_bloc.dart';
import 'package:esusu_weather_app/models/daily.dart';
import 'package:esusu_weather_app/models/weather.dart';
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
    bool showMonth = false,
  }) {
    final dateTime = DateTime.parse(date).toLocal();
    final format = showMonth ? 'MMMM dd yyyy' : 'EE dd';
    return DateFormat(format).format(dateTime);
  }

  String _formatDateTime({
    required String date,
  }) {
    final dateTime = DateTime.parse(date).toLocal();
    return DateFormat('h:mm a').format(dateTime);
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

  List<Widget> _gradientBackgroundItems() => [
        _circleDecoration(
          alignmentStart: 3,
          alignmentY: -0.5,
          circleColor: Colors.lightBlue,
        ),
        _circleDecoration(
          alignmentStart: -3,
          alignmentY: -0.5,
          circleColor: Colors.lightBlue,
        ),
        _circleDecoration(
          alignmentStart: 0,
          alignmentY: -2.5,
          circleColor: Colors.yellow,
          circleSize: 600,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
          ),
        ),
      ];

  Widget _dailyItemsList({
    required Daily daily,
  }) {
    int count = daily.time.length;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (context, index) {
        String time = daily.time[index];
        double tempMax = daily.temperature2mMax[index];
        double tempMin = daily.temperature2mMin[index];
        String sunrise = daily.sunrise[index];
        String sunset = daily.sunset[index];

        return _dailyItem(
          time: time,
          tempMax: tempMax,
          tempMin: tempMin,
          sunrise: sunrise,
          sunset: sunset,
        );
      },
    );
  }

  Widget _dailyItem({
    required String time,
    required double tempMax,
    required double tempMin,
    required String sunrise,
    required String sunset,
  }) =>
      Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(
              _formatDate(date: time),
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('High: ${tempMax.toString()}'),
                      Text('Low: ${tempMin.toString()}'),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      Text('Sunrise: ${_formatDateTime(date: sunrise)}'),
                      Text('Sunset: ${_formatDateTime(date: sunset)}'),
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
          'Week of\n${_formatDate(
            date: date,
            showMonth: true,
          )}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
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
              ..._gradientBackgroundItems(),
              if (widget.weather != null)
                _dailyItemsList(daily: widget.weather!.daily),
            ],
          ),
        ),
      ),
    );
  }
}
