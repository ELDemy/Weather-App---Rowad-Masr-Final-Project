import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';
import 'package:weather/core/services/errors/failure_class.dart';
import 'package:weather/core/services/errors/location_failure.dart';
import 'package:weather/core/services/location/get_location.dart';
import 'package:weather/core/services/weather_api/weather_services.dart';
import 'package:weather/core/utiles/helpers.dart';

class CityProvider with ChangeNotifier {
  CityProvider() {
    loadSelectedCities();
  }

  List<String> selectedCities = [];
  String? userCity;

  WeatherService weatherService = WeatherService();
  MyLocation locationService = MyLocation();

  Future<void> loadSelectedCities() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    selectedCities = prefs.getStringList('selectedCities') ?? [];
    notifyListeners();
  }

  Future<void> fetchUserCity(BuildContext context) async {
    try {
      Either<LocationFailure, String?> cityResult =
          await locationService.getCurrentCity();

      cityResult.fold(
        (failure) {
          Helpers.showSnackBar(context, failure.errMsg);
        },
        (city) async {
          userCity = city;
          notifyListeners();
        },
      );
    } catch (e) {
      Helpers.showSnackBar(context, 'Unexpected error: $e');
    }
  }

  Future<WeatherModel?> updateWeatherModel(
      String cityName, BuildContext context) async {
    WeatherModel? weatherModel = await _fetchWeatherModel(cityName, context);
    return weatherModel;
  }

  Future<void> saveSelectedCities() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedCities', selectedCities);
  }

  Future<void> addCity(String cityName, BuildContext context) async {
    if (!selectedCities.contains(cityName.toLowerCase())) {
      WeatherModel? weatherModel = await _fetchWeatherModel(cityName, context);
      if (weatherModel != null &&
          !selectedCities.contains(cityName.toLowerCase())) {
        selectedCities.add(cityName.toLowerCase());
        await saveSelectedCities();
        notifyListeners();
      }
    } else {
      Helpers.showSnackBar(
          context, "City $cityName is already in the list."); // Notify user
    }
  }

  void removeCity(int index, BuildContext context) async {
    String cityName = selectedCities[index];
    selectedCities.removeAt(index);
    Helpers.showSnackBar(context, "removed $cityName");
    await saveSelectedCities();

    notifyListeners();
  }

  Future<WeatherModel?> _fetchWeatherModel(
      String cityName, BuildContext context) async {
    WeatherModel? weatherModel;
    try {
      Either<Failure, WeatherModel> weatherResult =
          await weatherService.getWeatherForCity(cityName);

      weatherResult.fold(
        (failure) {
          Helpers.showSnackBar(context,
              'Error fetching weather for $cityName: ${failure.errMsg}');
        },
        (weather) {
          weatherModel = weather;
        },
      );
    } catch (e) {
      Helpers.showSnackBar(context, 'Error fetching weather for $cityName');
    }
    return weatherModel;
  }
}
