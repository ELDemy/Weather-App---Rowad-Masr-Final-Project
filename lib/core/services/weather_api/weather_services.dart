import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';

class WeatherService {
  final Dio dio = Dio();

  WeatherService();

  final String baseUrl = "https://api.weatherapi.com/v1";
  final String apiKey = "fee25c97813442f58e2195947240108";
  Future<WeatherModel> getCurrentWeather({required String location}) async {
    try {
      Response response = await dio.get(
          '$baseUrl/forecast.json?key=$apiKey&q=$location&days=1&aqi=no&alerts=no');
      print(response);

      WeatherModel weatherDM = WeatherModel.fromJson(response.data);
      log(weatherDM.location?.name ?? "");
      return weatherDM;
    } on DioException catch (e) {
      final String errMessage = e.response?.data['error']['message'] ??
          "Oops There was an error. try again later!!";
      log(errMessage);
      throw (errMessage);
    } catch (e) {
      log(e.toString());
      const String errMessage = "Oops There was an error. try again later!!";
      throw Exception(errMessage);
    }
  }
}
