import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';
import 'package:weather/core/services/errors/location_failure.dart';
import 'package:weather/core/services/errors/server_failure.dart';
import 'package:weather/core/services/location/get_location.dart';
import 'package:weather/core/services/weather_api/weather_services.dart';

class CityProvider with ChangeNotifier {
  WeatherModel? myLocationWeather;
  List<Map<String, dynamic>> selectedCities = [];
  bool isLoading = false;
  bool isSearching = false;

  WeatherService weatherService = WeatherService();
  MyLocation locationService = MyLocation();

  Future<void> fetchCurrentLocationWeather(BuildContext context) async {
    try {
      Either<LocationFailure, String?> cityResult =
          await locationService.getCurrentCity();

      cityResult.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(failure.message ?? 'Error fetching location')),
          );
        },
        (city) async {
          if (city != null) {
            Either<Failure, WeatherModel> weatherResult =
                await weatherService.getWeatherForCity(city);

            weatherResult.fold(
              (failure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content:
                          Text(failure.message ?? 'Error fetching weather')),
                );
              },
              (weather) {
                myLocationWeather = weather;
                notifyListeners();
              },
            );
          }
        },
      );
    } catch (e) {
      print('Error fetching location or weather: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unexpected error: $e')),
      );
    }
  }

  Future<void> fetchCityWeather(String cityName, BuildContext context) async {
    try {
      Either<Failure, WeatherModel> weatherResult =
          await weatherService.getWeatherForCity(cityName);

      weatherResult.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    'Error fetching weather for $cityName: ${failure.message}')),
          );
        },
        (weather) {
          selectedCities.add({
            'owm_city_name': cityName,
            'admin_level_1_long': weather.location?.region ?? 'Unknown',
            'country_long': weather.location?.country ?? 'Unknown',
            'temp_c': weather.current?.tempC?.toString() ?? 'N/A',
            'highLow':
                'H: ${weather.forecast?.forecastday?[0].day?.maxtempC}° L: ${weather.forecast?.forecastday?[0].day?.mintempC}°',
          });
          notifyListeners();
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching weather for $cityName')),
      );
    }
  }

  void removeCity(int index) {
    selectedCities.removeAt(index);
    notifyListeners();
  }
}
