import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';
import 'package:weather/views/city_screen/widgets/WindCard.dart';

class CityWeatherScreen extends StatelessWidget {
  CityWeatherScreen({super.key, required this.weatherModel});

  final cityWeather = [
    {'cityVisi': 30} // Example visibility data for demonstration
  ];
  final int cityIndex = 0;
  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/images/04n.jpeg'), // Replace with your background image path
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // City Name and Weather Info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Matosinhos',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icons/04d.png', // Replace with your icon path
                          width: 40,
                          height: 40,
                        ),
                        SizedBox(width: 8),
                        Text(
                          '74° | Clouds',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text(
                      'H: 80° | L: 72°',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),

                // Wind and Visibility Section (side by side)

                // Alerts Section
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
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
                      Divider(color: Colors.white, thickness: 1),
                      SizedBox(height: 8),
                      Text(
                        'Yellow Rain Warning\nShowers, sometimes heavy and accompanied by ...',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                // 24-Hours Forecast Section
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.access_time, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            '24-HOURS FORECAST',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white, thickness: 1),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildWeatherHour(
                              '14', '72°', 'assets/icons/04d.png'),
                          _buildWeatherHour(
                              '15', '73°', 'assets/icons/04d.png'),
                          _buildWeatherHour(
                              '16', '72°', 'assets/icons/04d.png'),
                          _buildWeatherHour(
                              '17', '74°', 'assets/icons/04d.png'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),

                // 8-Day Forecast Section
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            '8-DAY FORECAST',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ],
                      ),
                      Divider(color: Colors.white, thickness: 1),
                      SizedBox(height: 10),
                      _buildForecastDay(
                          'Fri', '74°', '19°', 'assets/icons/04d.png'),
                      Divider(color: Colors.white, thickness: 1),
                      _buildForecastDay(
                          'Sat', '68°', '18°', 'assets/icons/04d.png'),
                      Divider(color: Colors.white, thickness: 1),
                      _buildForecastDay(
                          'Sun', '68°', '18°', 'assets/icons/04d.png'),
                      Divider(color: Colors.white, thickness: 1),
                      _buildForecastDay(
                          'Mon', '67°', '17°', 'assets/icons/04d.png'),
                      Divider(color: Colors.white, thickness: 1),
                      _buildForecastDay(
                          'Tue', '66°', '16', 'assets/icons/04d.png'),
                      Divider(color: Colors.white, thickness: 1),
                      _buildForecastDay(
                          'Wed', '67°', '17°', 'assets/icons/04d.png'),
                      Divider(color: Colors.white, thickness: 1),
                      _buildForecastDay(
                          'Thu', '68', '18°', 'assets/icons/04d.png'),
                      Divider(color: Colors.white, thickness: 1),
                      _buildForecastDay(
                          'Fri', '66°', '18°', 'assets/icons/04d.png'),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // WindCard
                    WindCard(),

                    // Visibility Widget
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 6, right: 22),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                  child: Container(
                                    height: 180,
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SleekCircularSlider(
                                                  min: 0,
                                                  max: 50,
                                                  initialValue:
                                                      cityWeather[cityIndex]
                                                              ['cityVisi']!
                                                          .toDouble(),
                                                  appearance:
                                                      CircularSliderAppearance(
                                                          infoProperties:
                                                              InfoProperties(
                                                            mainLabelStyle: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                            modifier:
                                                                (percentage) {
                                                              final roundedValue =
                                                                  percentage
                                                                      .ceil()
                                                                      .toInt()
                                                                      .toString();
                                                              return '$roundedValue km';
                                                            },
                                                          ),
                                                          animationEnabled:
                                                              true,
                                                          angleRange: 360,
                                                          startAngle: 90,
                                                          size: 140,
                                                          customWidths:
                                                              CustomSliderWidths(
                                                                  progressBarWidth:
                                                                      5,
                                                                  handlerSize:
                                                                      2),
                                                          customColors:
                                                              CustomSliderColors(
                                                                  hideShadow:
                                                                      true,
                                                                  trackColor:
                                                                      Colors
                                                                          .white54,
                                                                  progressBarColors: [
                                                                Colors.red,
                                                                Colors.blueGrey
                                                              ])),
                                                ))),
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
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                  child: Container(
                                    height: 180,
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SleekCircularSlider(
                                                  min: -100,
                                                  max: 100,
                                                  appearance:
                                                      CircularSliderAppearance(
                                                          angleRange: 360,
                                                          spinnerMode: false,
                                                          infoProperties:
                                                              InfoProperties(
                                                                  mainLabelStyle: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          22,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  modifier:
                                                                      (percentage) {
                                                                    final roundedValue = percentage
                                                                        .ceil()
                                                                        .toInt()
                                                                        .toString();
                                                                    return '$roundedValue' +
                                                                        '\u00B0';
                                                                  },
                                                                  bottomLabelText:
                                                                      "Feels Like",
                                                                  bottomLabelStyle: TextStyle(
                                                                      letterSpacing:
                                                                          0.1,
                                                                      fontSize:
                                                                          14,
                                                                      height:
                                                                          1.5,
                                                                      color:
                                                                          Colors
                                                                              .white70,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                          animationEnabled:
                                                              true,
                                                          size: 140,
                                                          customWidths:
                                                              CustomSliderWidths(
                                                                  progressBarWidth:
                                                                      8,
                                                                  handlerSize:
                                                                      3),
                                                          customColors:
                                                              CustomSliderColors(
                                                                  hideShadow:
                                                                      true,
                                                                  trackColor:
                                                                      Colors
                                                                          .white54,
                                                                  progressBarColors: [
                                                                Colors
                                                                    .amber[600]!
                                                                    .withOpacity(
                                                                        0.54),
                                                                Colors.blueGrey
                                                                    .withOpacity(
                                                                        0.54)
                                                              ])),
                                                ))),
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
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                  child: Container(
                                    height: 180,
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SleekCircularSlider(
                                                  min: 0,
                                                  max: 2000,
                                                  appearance:
                                                      CircularSliderAppearance(
                                                          infoProperties: InfoProperties(
                                                              mainLabelStyle: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 22,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                              bottomLabelText:
                                                                  "hPa",
                                                              bottomLabelStyle: TextStyle(
                                                                  fontSize: 14,
                                                                  height: 1.5,
                                                                  color: Colors
                                                                      .white70,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                          animationEnabled:
                                                              true,
                                                          size: 140,
                                                          customWidths:
                                                              CustomSliderWidths(
                                                                  progressBarWidth:
                                                                      7,
                                                                  handlerSize:
                                                                      6),
                                                          customColors:
                                                              CustomSliderColors(
                                                                  hideShadow:
                                                                      true,
                                                                  trackColor:
                                                                      Colors
                                                                          .white54,
                                                                  progressBarColors: [
                                                                Colors.white
                                                                    .withOpacity(
                                                                        1),
                                                                Colors.white
                                                                    .withOpacity(
                                                                        0.54),
                                                                Colors
                                                                    .transparent,
                                                                Colors
                                                                    .transparent
                                                              ])),
                                                ))),
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
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                  child: Container(
                                    height: 180,
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.drop_fill,
                                                size: 18,
                                                color: Colors.white54,
                                              ),
                                              Text(
                                                ' HUMIDITY',
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                            child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SleekCircularSlider(
                                                  min: 0,
                                                  max: 100,
                                                  appearance:
                                                      CircularSliderAppearance(
                                                          infoProperties:
                                                              InfoProperties(
                                                                  mainLabelStyle: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          22,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                                  modifier:
                                                                      (percentage) {
                                                                    final roundedValue = percentage
                                                                        .ceil()
                                                                        .toInt()
                                                                        .toString();
                                                                    return '$roundedValue%';
                                                                  },
                                                                  bottomLabelText:
                                                                      "Humidity",
                                                                  bottomLabelStyle: TextStyle(
                                                                      letterSpacing:
                                                                          0.1,
                                                                      fontSize:
                                                                          14,
                                                                      height:
                                                                          1.5,
                                                                      color:
                                                                          Colors
                                                                              .white70,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700)),
                                                          animationEnabled:
                                                              true,
                                                          size: 140,
                                                          customWidths:
                                                              CustomSliderWidths(
                                                                  progressBarWidth:
                                                                      8,
                                                                  handlerSize:
                                                                      3),
                                                          customColors:
                                                              CustomSliderColors(
                                                                  hideShadow:
                                                                      true,
                                                                  trackColor:
                                                                      Colors
                                                                          .white54,
                                                                  progressBarColors: [
                                                                Colors.blueGrey,
                                                                Colors.black54
                                                              ])),
                                                ))),
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
                            const EdgeInsets.only(left: 22, right: 6, top: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: double.infinity,
                            height: 180,
                            child: Stack(
                              children: [
                                BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 10, sigmaY: 51),
                                  child: Container(
                                    height: 180,
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.drop_fill,
                                                size: 18,
                                                color: Colors.white54,
                                              ),
                                              Text(
                                                ' UV INDEX',
                                                style: TextStyle(
                                                    color: Colors.white54,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Flexible(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SleekCircularSlider(
                                              min: 0,
                                              max: 11,
                                              initialValue:
                                                  5, // Make sure to provide a valid initial value.
                                              appearance:
                                                  CircularSliderAppearance(
                                                infoProperties: InfoProperties(
                                                  mainLabelStyle: TextStyle(
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
                                                    return '$roundedValue';
                                                  },
                                                  bottomLabelText: "UV ",
                                                  bottomLabelStyle: TextStyle(
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
                                                    Colors.purple,
                                                    Colors.redAccent,
                                                    Colors.orange,
                                                    Colors.yellow,
                                                    Colors.green,
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
                    SizedBox(height: 30), // Increased space between sections
                  ],
                ),
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
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        SizedBox(height: 4),
        Image.asset(
          iconPath,
          width: 30,
          height: 30,
        ),
        SizedBox(height: 4),
        Text(
          temperature,
          style: TextStyle(color: Colors.white, fontSize: 18),
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
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Image.asset(
          iconPath,
          width: 30,
          height: 30,
        ),
        Text(
          highTemp,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        Text(
          lowTemp,
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ],
    );
  }
}
