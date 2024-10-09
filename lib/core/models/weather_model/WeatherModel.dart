import 'helper_classes/Alerts.dart';
import 'helper_classes/Current.dart';
import 'helper_classes/Forecast.dart';
import 'helper_classes/Location.dart';

class WeatherModel {
  WeatherModel({
    this.location,
    this.current,
    this.forecast,
    this.alerts,
  });

  WeatherModel.fromJson(dynamic json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    current =
        json['current'] != null ? Current.fromJson(json['current']) : null;
    forecast =
        json['forecast'] != null ? Forecast.fromJson(json['forecast']) : null;
    alerts = json['alerts'] != null ? Alerts.fromJson(json['alerts']) : null;
  }
  Location? location;
  Current? current;
  Forecast? forecast;
  Alerts? alerts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    if (current != null) {
      map['current'] = current?.toJson();
    }
    if (forecast != null) {
      map['forecast'] = forecast?.toJson();
    }
    if (alerts != null) {
      map['alerts'] = alerts?.toJson();
    }
    return map;
  }
}
