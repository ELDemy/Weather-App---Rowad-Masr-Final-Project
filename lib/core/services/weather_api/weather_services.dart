import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';
import 'package:weather/core/services/errors/location_failure.dart';
import 'package:weather/core/services/errors/server_failure.dart';
import 'package:weather/core/services/location/get_location.dart';

class WeatherService {
  final Dio dio = Dio();

  String apiKey = "fee25c97813442f58e2195947240108";
  String baseUrl = "http://api.weatherapi.com/v1";

  String? errMsg;

  Future<Either<Failure, WeatherModel>> getUserWeather() async {
    Either<LocationFailure, String?> currentCity =
        await MyLocation().getCurrentCity();

    return currentCity.fold(
      (failure) => left(failure),
      (cityName) async => await getWeather(cityName),
    );
  }

  Future<Either<Failure, WeatherModel>> getWeather(cityName) async {
    try {
      Response response = await dio.get(
          "$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=3&aqi=yes&alerts=yes");

      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return right(weatherModel);
    } on DioException catch (dioException) {
      return left(ServerFailure.fromDioException(dioException));
    } catch (e) {
      return left(ServerFailure("Unexpected error!!"));
    }
  }

  testWeatherService() async {
    Either<Failure, WeatherModel> userLocationWeather =
        await WeatherService().getUserWeather();

    userLocationWeather.fold(
      (failure) {
        log("Failure Message: ${failure.errMsg}");
      },
      (weatherModel) {
        log("user location is: ${weatherModel.location?.name}");
      },
    );
  }
}
