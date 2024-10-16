import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';
import 'package:weather/core/services/errors/failure_class.dart';
import 'package:weather/core/services/errors/location_failure.dart';
import 'package:weather/core/services/location/get_location.dart';
import 'package:weather/core/services/weather_api/weather_services.dart';

class CityProvider with ChangeNotifier {
  String? userCity;
  List<String> selectedCities = [];
  bool isLoading = false;
  bool isSearching = false;

  WeatherService weatherService = WeatherService();
  MyLocation locationService = MyLocation();

  get filteredCities => null;

  Future<void> fetchUserCity(BuildContext context) async {
    try {
      showMaterialBanner(context, "getting user Location..");
      Either<LocationFailure, String?> cityResult =
          await locationService.getCurrentCity();

      cityResult.fold(
        (failure) {
          showSnackBar(context, failure.errMsg);
        },
        (city) async {
          userCity = city;
          notifyListeners();
        },
      );
    } catch (e) {
      showSnackBar(context, 'Unexpected error: $e');
    }
    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
  }

  Future<WeatherModel?> updateWeatherModel(
      String cityName, BuildContext context) async {
    showMaterialBanner(context, "Looking for $cityName");
    WeatherModel? weatherModel = await _fetchWeatherModel(cityName, context);

    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    return weatherModel;
  }

  Future<void> addCity(String cityName, BuildContext context) async {
    WeatherModel? weatherModel = await _fetchWeatherModel(cityName, context);
    if (weatherModel != null) {
      selectedCities.add(cityName);
      notifyListeners();
    }
  }

  void removeCity(int index, BuildContext context) {
    String cityName = selectedCities[index];
    selectedCities.removeAt(index);
    showSnackBar(context, "removed $cityName");
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
          showSnackBar(context,
              'Error fetching weather for $cityName: ${failure.errMsg}');
        },
        (weather) {
          weatherModel = weather;
        },
      );
    } catch (e) {
      showSnackBar(context, 'Error fetching weather for $cityName');
    }

    return weatherModel;
  }
}

showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(text)),
  );
}

showMaterialBanner(BuildContext context, String text) async {
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
