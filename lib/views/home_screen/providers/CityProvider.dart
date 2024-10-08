import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class CityProvider with ChangeNotifier {
  List<Map<String, dynamic>> cities = [];
  List<Map<String, dynamic>> filteredCities = [];
  List<Map<String, dynamic>> selectedCities = [];
  bool isLoading = true;
  bool isSearching = false;

  Future<void> loadCities() async {
    try {
      String data = await rootBundle.loadString('assets/json/citys.json');
      List<dynamic> _cities = json.decode(data);
      cities = _cities.map((city) => Map<String, dynamic>.from(city)).toList();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      // Handle error
      print("Error loading cities: $e");
    }
  }

  void filterCities(String query) {
    filteredCities = cities
        .where((city) =>
        city['owm_city_name'].toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    isSearching = query.isNotEmpty;
    notifyListeners();
  }

  void selectCity(Map<String, dynamic> city) {
    selectedCities.add(city);
    isSearching = false;
    notifyListeners();
  }

  void removeCity(int index) {
    selectedCities.removeAt(index);
    notifyListeners();
  }
}
