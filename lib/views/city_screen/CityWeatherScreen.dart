import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';

class CityWeatherScreen extends StatelessWidget {
  const CityWeatherScreen({super.key, required this.weatherModel});

  final WeatherModel weatherModel;

  String? get alert {
    List? alerts = weatherModel.alerts?.alert;
    if (alerts != null && alerts.isNotEmpty) {
      return alerts[0]['headline'];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(_getWeatherImage()),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 16, right: 16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      weatherModel.location?.name ?? 'Unknown City',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/04d.png',
                          width: 40,
                          height: 40,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            '${weatherModel.current?.temp} | ${weatherModel.current?.condition?.text}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                            softWrap: true,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'H: ${weatherModel.forecast?.forecastday?[0].day?.maxTemp}° | L: ${weatherModel.forecast?.forecastday?[0].day?.minTemp}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Alerts Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.alarm, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'ALERTS',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white, thickness: 1),
                      const SizedBox(height: 8),
                      if (alert != null && alert!.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            alert!,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      else
                        const Text(
                          'No Alerts',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 24-Hours Forecast Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            '24-HOURS FORECAST',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white, thickness: 1),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: weatherModel
                                  .forecast?.forecastday?[0].hour?.length ??
                              0,
                          itemBuilder: (context, index) {
                            final hourData = weatherModel
                                .forecast?.forecastday?[0].hour?[index];
                            final hourTime =
                                hourData?.time?.split(' ')[1].substring(0, 2) ??
                                    'N/A';
                            final temperature = hourData?.temp != null
                                ? '${hourData!.temp}°'
                                : 'N/A';

                            String weatherCondition =
                                hourData?.condition?.text ?? 'Clear';
                            String iconPath;
                            if (weatherCondition.contains('Rain')) {
                              iconPath = 'assets/icons/09d.png';
                            } else if (weatherCondition.contains('Cloud')) {
                              iconPath = 'assets/icons/04d.png';
                            } else if (weatherCondition.contains('Sunny')) {
                              iconPath = 'assets/icons/02d.png';
                            } else if (weatherCondition.contains('Clear')) {
                              iconPath = 'assets/icons/03d.png';
                            } else if (weatherCondition
                                .contains('Partly cloudy')) {
                              iconPath = 'assets/icons/10d.png';
                            } else {
                              iconPath = 'assets/icons/50d.png';
                            }

                            return Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: _buildWeatherHour(
                                hourTime,
                                temperature,
                                iconPath,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 3-Day Forecast Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            '3-DAY FORECAST',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.white, thickness: 1),
                      _buildForecastDay(
                        'Today',
                        '${weatherModel.forecast?.forecastday?[0].day?.maxTemp ?? 0}°',
                        '${weatherModel.forecast?.forecastday?[0].day?.minTemp ?? 0}°',
                        _getWeatherIcon(weatherModel
                            .forecast?.forecastday?[0].day?.condition2?.text),
                      ),
                      const Divider(color: Colors.white, thickness: 1),
                      _buildForecastDay(
                        'Tomorrow',
                        '${weatherModel.forecast?.forecastday?[1].day?.maxTemp ?? 0}°',
                        '${weatherModel.forecast?.forecastday?[1].day?.minTemp ?? 0}°',
                        _getWeatherIcon(weatherModel
                            .forecast?.forecastday?[1].day?.condition2?.text),
                      ),
                      const Divider(color: Colors.white, thickness: 1),
                      _buildForecastDay(
                        'Day after',
                        '${weatherModel.forecast?.forecastday?[2].day?.maxTemp ?? 0}°',
                        '${weatherModel.forecast?.forecastday?[2].day?.minTemp ?? 0}°',
                        _getWeatherIcon(weatherModel
                            .forecast?.forecastday?[2].day?.condition2?.text),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 22, right: 6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: double.infinity,
                            height: 180,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                  child: Container(
                                    height: 180,
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.wind,
                                                size: 18,
                                                color: Colors.white54,
                                              ),
                                              Text(
                                                ' WIND',
                                                style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              height: 120,
                                              width: 120,
                                              decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/compass.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              child: Stack(
                                                children: [
                                                  const Align(
                                                    alignment: Alignment.center,
                                                    child: CustomPaint(
                                                      size: Size(150, 150),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 1, top: 1.5),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.center,
                                                      child: Stack(
                                                        children: [
                                                          BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaY:
                                                                          10,
                                                                      sigmaX:
                                                                          10)),
                                                          Container(
                                                            width: 45,
                                                            height: 45,
                                                            decoration:
                                                                const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                            child: Center(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Text(
                                                                    '${weatherModel.current?.windKph ?? 0} km/h',
                                                                    style: TextStyle(
                                                                        color: Colors.white.withOpacity(
                                                                            0.90),
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.w900),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 2,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Visibility Widget
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6, right: 22),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: double.infinity,
                            height: 180,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                  child: Container(
                                    height: 180,
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.eye_fill,
                                                size: 18,
                                                color: Colors.white54,
                                              ),
                                              Text(
                                                ' VISIBILITY',
                                                style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SleekCircularSlider(
                                              min: 0,
                                              max: 50,
                                              initialValue: weatherModel
                                                      .current?.visKm
                                                      ?.toDouble() ??
                                                  0.0,
                                              appearance:
                                                  CircularSliderAppearance(
                                                infoProperties: InfoProperties(
                                                  mainLabelStyle:
                                                      const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  modifier: (percentage) {
                                                    final roundedValue =
                                                        percentage
                                                            .ceil()
                                                            .toInt()
                                                            .toString();
                                                    return '$roundedValue km';
                                                  },
                                                ),
                                                animationEnabled: true,
                                                angleRange: 360,
                                                startAngle: 90,
                                                size: 140,
                                                customWidths:
                                                    CustomSliderWidths(
                                                  progressBarWidth: 5,
                                                  handlerSize: 2,
                                                ),
                                                customColors:
                                                    CustomSliderColors(
                                                  hideShadow: true,
                                                  trackColor: Colors.white54,
                                                  progressBarColors: [
                                                    Colors.red,
                                                    Colors.blueGrey,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 22, right: 6, top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: double.infinity,
                            height: 180,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                  child: Container(
                                    height: 180,
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.thermometer,
                                                size: 18,
                                                color: Colors.white54,
                                              ),
                                              Text(
                                                ' FEELS LIKE',
                                                style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SleekCircularSlider(
                                              min: -100,
                                              max: 100,
                                              initialValue: weatherModel
                                                      .current?.feelslikeC
                                                      ?.toDouble() ??
                                                  0,
                                              appearance:
                                                  CircularSliderAppearance(
                                                angleRange: 360,
                                                spinnerMode: false,
                                                infoProperties: InfoProperties(
                                                  mainLabelStyle:
                                                      const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  modifier: (percentage) {
                                                    final roundedValue =
                                                        percentage
                                                            .ceil()
                                                            .toInt()
                                                            .toString();
                                                    return '$roundedValue\u00B0';
                                                  },
                                                  bottomLabelText: "Feels Like",
                                                  bottomLabelStyle:
                                                      const TextStyle(
                                                    letterSpacing: 0.1,
                                                    fontSize: 14,
                                                    height: 1.5,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                animationEnabled: true,
                                                size: 140,
                                                customWidths:
                                                    CustomSliderWidths(
                                                  progressBarWidth: 8,
                                                  handlerSize: 3,
                                                ),
                                                customColors:
                                                    CustomSliderColors(
                                                  hideShadow: true,
                                                  trackColor: Colors.white54,
                                                  progressBarColors: [
                                                    Colors.amber[600]!
                                                        .withOpacity(0.54),
                                                    Colors.blueGrey
                                                        .withOpacity(0.54),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 22, top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: double.infinity,
                            height: 180,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                  child: Container(
                                    height: 180,
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.gauge,
                                                size: 18,
                                                color: Colors.white54,
                                              ),
                                              Text(
                                                ' PRESSURE',
                                                style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SleekCircularSlider(
                                              min: 0,
                                              max: 2000,
                                              initialValue: weatherModel
                                                      .current?.pressureMb
                                                      ?.toDouble() ??
                                                  0,
                                              appearance:
                                                  CircularSliderAppearance(
                                                infoProperties: InfoProperties(
                                                  mainLabelStyle:
                                                      const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  bottomLabelText: "hPa",
                                                  bottomLabelStyle:
                                                      const TextStyle(
                                                    fontSize: 14,
                                                    height: 1.5,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                animationEnabled: true,
                                                size: 140,
                                                customWidths:
                                                    CustomSliderWidths(
                                                  progressBarWidth: 7,
                                                  handlerSize: 6,
                                                ),
                                                customColors:
                                                    CustomSliderColors(
                                                  hideShadow: true,
                                                  trackColor: Colors.white54,
                                                  progressBarColors: [
                                                    Colors.white.withOpacity(1),
                                                    Colors.white
                                                        .withOpacity(0.54),
                                                    Colors.transparent,
                                                    Colors.transparent,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 22, right: 6, top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: double.infinity,
                            height: 180,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                  child: Container(
                                    height: 180,
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.drop_fill,
                                                size: 18,
                                                color: Colors.white54,
                                              ),
                                              Text(
                                                'Humidity',
                                                style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SleekCircularSlider(
                                              min: 0,
                                              max: 100,
                                              initialValue: weatherModel
                                                      .current?.humidity
                                                      ?.toDouble() ??
                                                  0,
                                              appearance:
                                                  CircularSliderAppearance(
                                                infoProperties: InfoProperties(
                                                  mainLabelStyle:
                                                      const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  modifier: (percentage) {
                                                    final roundedValue =
                                                        percentage
                                                            .ceil()
                                                            .toInt()
                                                            .toString();
                                                    return '$roundedValue%';
                                                  },
                                                  bottomLabelText: "Humidity",
                                                  bottomLabelStyle:
                                                      const TextStyle(
                                                    letterSpacing: 0.1,
                                                    fontSize: 14,
                                                    height: 1.5,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                animationEnabled: true,
                                                size: 140,
                                                customWidths:
                                                    CustomSliderWidths(
                                                  progressBarWidth: 8,
                                                  handlerSize: 3,
                                                ),
                                                customColors:
                                                    CustomSliderColors(
                                                  hideShadow: true,
                                                  trackColor: Colors.white54,
                                                  progressBarColors: [
                                                    Colors.blueGrey,
                                                    Colors.black54,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(left: 6, right: 22, top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                            width: double.infinity,
                            height: 180,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                  child: Container(
                                    height: 180,
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.wind,
                                                size: 18,
                                                color: Colors.white54,
                                              ),
                                              Text(
                                                ' Wind Speed',
                                                style: TextStyle(
                                                  color: Colors.white54,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SleekCircularSlider(
                                              min: 0,
                                              max: 100,
                                              initialValue: (weatherModel
                                                          .current?.windKph ??
                                                      0)
                                                  .toDouble(),
                                              appearance:
                                                  CircularSliderAppearance(
                                                infoProperties: InfoProperties(
                                                  mainLabelStyle:
                                                      const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  modifier: (percentage) {
                                                    final roundedValue =
                                                        percentage
                                                            .ceil()
                                                            .toInt()
                                                            .toString();
                                                    return '$roundedValue km/h';
                                                  },
                                                  bottomLabelText: "Wind Speed",
                                                  bottomLabelStyle:
                                                      const TextStyle(
                                                    letterSpacing: 0.1,
                                                    fontSize: 14,
                                                    height: 1.5,
                                                    color: Colors.white70,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                ),
                                                animationEnabled: true,
                                                size: 140,
                                                customWidths:
                                                    CustomSliderWidths(
                                                  progressBarWidth: 8,
                                                  handlerSize: 3,
                                                ),
                                                customColors:
                                                    CustomSliderColors(
                                                  hideShadow: true,
                                                  trackColor: Colors.white54,
                                                  progressBarColors: [
                                                    Colors.blue,
                                                    Colors.cyan,
                                                    Colors.greenAccent,
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherHour(String hour, String temperature, String iconPath) {
    return Column(
      children: [
        Text(
          hour,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        const SizedBox(height: 4),
        Image.asset(
          iconPath,
          width: 30,
          height: 30,
        ),
        const SizedBox(height: 4),
        Text(
          temperature,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ],
    );
  }

  Widget _buildForecastDay(
      String day, String highTemp, String lowTemp, String iconPath) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          day,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        Image.asset(
          iconPath,
          width: 30,
          height: 30,
        ),
        Text(
          highTemp,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
        Text(
          lowTemp,
          style: const TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }

  String _getWeatherImage() {
    String conditionText = weatherModel.current?.condition?.text ?? 'clear';
    switch (conditionText.toLowerCase()) {
      case 'sunny':
        return 'assets/images/01d.jpeg';
      case 'cloudy':
        return 'assets/images/02d.jpeg';
      case 'rain':
        return 'assets/images/09n.jpeg';
      case 'snow':
        return 'assets/images/13n.jpeg';
      case 'storm':
        return 'assets/images/04d.jpeg';
      case 'fog':
        return 'assets/images/fog.png';
      case 'partly cloudy':
        return 'assets/images/50d.jpeg';
      default:
        return 'assets/images/01n.jpeg';
    }
  }

  String _getWeatherIcon(String? condition) {
    if (condition == null) return 'assets/icons/04d.png';

    if (condition.contains('Rain')) {
      return 'assets/icons/10d.png';
    } else if (condition.contains('Cloud')) {
      return 'assets/icons/04d.png';
    } else if (condition.contains('Sunny')) {
      return 'assets/icons/02d.png';
    } else if (condition.contains('Clear')) {
      return 'assets/icons/03n.png';
    } else if (condition.contains('Partly cloudy')) {
      return 'assets/icons/10d.png';
    } else {
      return 'assets/icons/50d.png';
    }
  }
}
