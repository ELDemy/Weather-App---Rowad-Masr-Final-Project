import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';
import 'package:weather/core/services/errors/failure_class.dart';
import 'package:weather/core/services/errors/location_failure.dart';
import 'package:weather/core/services/location/get_location.dart';
import 'package:weather/core/services/weather_api/weather_services.dart';

class CityProvider with ChangeNotifier {

  CityProvider() {
    loadSelectedCities();
  }

  List<String> selectedCities = [];
  String? userCity;

  WeatherService weatherService = WeatherService();
  MyLocation locationService = MyLocation();

  get filteredCities => null;


  Future<void> loadSelectedCities() async {
    final prefs = await SharedPreferences.getInstance();
    selectedCities = prefs.getStringList('selectedCities') ?? [];
    notifyListeners();
  }

  Future<void> saveSelectedCities() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('selectedCities', selectedCities);
  }

  Future<void> fetchUserCity(BuildContext context) async {
    try {
      _showMaterialBanner(context, "getting user Location..");

      Either<LocationFailure, String?> cityResult =
          await locationService.getCurrentCity();

      cityResult.fold(
        (failure) {
          _showSnackBar(context, failure.errMsg);
        },
        (city) async {
          userCity = city;
          notifyListeners();
        },
      );
    } catch (e) {
      _showSnackBar(context, 'Unexpected error: $e');
    }
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }

  Future<WeatherModel?> updateWeatherModel(
      String cityName, BuildContext context) async {

    _showMaterialBanner(context, "Looking for $cityName");

    WeatherModel? weatherModel = await _fetchWeatherModel(cityName, context);

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    return weatherModel;
  }

  Future<void> addCity(String cityName, BuildContext context) async {

    if (!selectedCities.contains(cityName.toLowerCase())) {
      WeatherModel? weatherModel = await _fetchWeatherModel(cityName, context);
      if (weatherModel != null) {
        selectedCities.add(cityName.toLowerCase());
        await saveSelectedCities();
        notifyListeners();
      }
    } else {
      _showSnackBar(
          context, "City $cityName is already in the list."); // Notify user
    }
  }

  void removeCity(int index, BuildContext context) async {
    String cityName = selectedCities[index];
    selectedCities.removeAt(index);
    _showSnackBar(context, "removed $cityName");
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
          _showSnackBar(context,
              'Error fetching weather for $cityName: ${failure.errMsg}');
        },
        (weather) {
          weatherModel = weather;
        },
      );
    } catch (e) {
      _showSnackBar(context, 'Error fetching weather for $cityName');
    }
    return weatherModel;
  }

  _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  _showMaterialBanner(BuildContext context, String text) async {
    ScaffoldMessenger.of(context).clearMaterialBanners();
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.transparent,
        dividerColor: Colors.transparent,
        content: Row(
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            const SizedBox(
                height: 16,
                width: 16,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                )),
          ],
        ),
        actions: const [SizedBox()],
      ),
    );
  }
}
