import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';
import 'package:weather/views/city_screen/CityWeatherScreen.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';

class CityCard extends StatefulWidget {
  final String cityName;
  final bool isRemovable;
  final CityProvider cityProvider;

  const CityCard({
    required this.cityProvider,
    required this.cityName,
    this.isRemovable = false,
    super.key,
  });

  @override
  State<CityCard> createState() => _CityCardState();
}

class _CityCardState extends State<CityCard> {
  WeatherModel? weatherModel;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      getWeather();
    });
  }

  getWeather() async {
    weatherModel =
        await widget.cityProvider.updateWeatherModel(widget.cityName, context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Ink.image(
              image: AssetImage(_getWeatherImage()),
              height: 115,
              fit: BoxFit.cover,
              child: InkWell(onTap: () {
                if (weatherModel != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CityWeatherScreen(weatherModel: weatherModel!);
                  }));
                }
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.cityName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Lottie.asset(
                        'assets/animations/greenn.json',
                        repeat: true,
                        reverse: true,
                        height: 20,
                      ),
                    ],
                  ),
                  Wrap(
                    children: [
                      Text(

                        '${weatherModel?.location?.region ?? ''}, ${weatherModel?.location?.country ?? ''}',

                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(

                    'Condition: ${weatherModel?.current?.condition?.text ?? ''}',

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(

                    'Humidity: ${weatherModel?.current?.humidity ?? ''}%',

                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16,
              top: 16,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: 120,
                  height: 70,
                  color: Colors.transparent,
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(color: Colors.white.withOpacity(0.13)),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.15),
                              Colors.white.withOpacity(0.05),
                            ],
                          ),
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(

                                '${weatherModel?.current?.tempC ?? ''}°C',

                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(

                                    'H: ${weatherModel?.forecast?.forecastday?[0].day?.maxtempC ?? ''}°',

                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(

                                    'L: ${weatherModel?.forecast?.forecastday?[0].day?.mintempC ?? ''}°',

                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
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
    );
  }

  String _getWeatherImage() {
    String conditionText = weatherModel?.current?.condition?.text ?? 'clear';
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
}
