import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';

class CityCard extends StatelessWidget {
  final String cityName;
  final WeatherModel weatherModel;
  final bool isRemovable;

  const CityCard({
    required this.cityName,
    required this.weatherModel,
    this.isRemovable = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath =
        _getWeatherImage(weatherModel.current?.condition?.text ?? 'clear');

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
              image: AssetImage(imagePath),
              height: 115,
              fit: BoxFit.cover,
              child: InkWell(onTap: () {}),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Lottie.asset(
                    'assets/animations/greenn.json',
                    repeat: true,
                    reverse: true,
                    height: 20,
                  ),
                  const SizedBox(height: 5),
                  Wrap(
                    children: [
                      Text(
                        '${weatherModel.location?.region}, ${weatherModel.location?.country}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Condition: ${weatherModel.current?.condition?.text ?? 'N/A'}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Humidity: ${weatherModel.current?.humidity ?? 'N/A'}%',
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
                  width: 105,
                  height: 82,
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
                                '${weatherModel.current?.tempC}°C',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'H: ${weatherModel.forecast?.forecastday?[0].day?.maxtempC}°',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'L: ${weatherModel.forecast?.forecastday?[0].day?.mintempC}°',
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

  String _getWeatherImage(String conditionText) {
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
