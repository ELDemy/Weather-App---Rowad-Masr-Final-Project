import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';
import 'package:weather/core/services/errors/location_failure.dart';
import 'package:weather/core/services/errors/server_failure.dart';
import 'package:weather/core/services/location/get_location.dart';
import 'package:weather/core/services/weather_api/weather_services.dart';

class CityProvider with ChangeNotifier {
  WeatherModel? myLocationWeather;
  List<WeatherModel> selectedCities = [];
  bool isLoading = false;
  bool isSearching = false;

  WeatherService weatherService = WeatherService();
  MyLocation locationService = MyLocation();

  get filteredCities => null;

  Future<void> fetchCurrentLocationWeather(BuildContext context) async {
    try {
      Either<LocationFailure, String?> cityResult =
      await locationService.getCurrentCity();

      cityResult.fold(
            (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(failure.message ?? 'Error fetching location'),
            ),
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
                    content: Text(failure.message ?? 'Error fetching weather'),
                  ),
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
                'Error fetching weather for $cityName: ${failure.message}',
              ),
            ),
          );
        },
            (weather) {
          selectedCities.add(weather);
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

  Future<WeatherModel?> getWeatherForCity(String cityName) async {
    try {
      Either<Failure, WeatherModel> weatherResult =
      await weatherService.getWeatherForCity(cityName);
      return weatherResult.fold(
            (failure) => null,
            (weather) => weather,
      );
    } catch (e) {
      print('Error fetching weather for city: $e');
      return null;
    }
  }

  getCityWeather(Map<String, dynamic> city) {}

  void selectCity(city) {}

  void filterCities(String value) {}

  getCurrentWeather() {}

  getWeatherModel(city) {}
}

