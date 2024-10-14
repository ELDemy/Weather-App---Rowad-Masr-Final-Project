import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/views/home_screen/providers/CityCard.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';


class CitySelectionPage extends StatelessWidget {
  const CitySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cityProvider = Provider.of<CityProvider>(context);
    final TextEditingController searchController = TextEditingController();

    // Fetch current location weather when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (cityProvider.myLocationWeather == null) {
        cityProvider.fetchCurrentLocationWeather(context);
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          'Weather App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search for a city',
                  hintStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.grey[800],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                ),
                style: const TextStyle(color: Colors.white),
                onSubmitted: (value) {
                  cityProvider.fetchCityWeather(value, context);
                },
              ),
            ),
            const SizedBox(height: 10),
            // عرض كارد "My Location" في أعلى القائمة
            CityCard(
              cityName: 'My Location',
              adminLevel: cityProvider.myLocationWeather?.location?.region ??
                  'Loading...',
              country: cityProvider.myLocationWeather?.location?.country ??
                  'Loading...',
              temperature:
                  cityProvider.myLocationWeather?.current?.tempC?.toString() ??
                      'N/A',
              highLow:
                  'H: ${cityProvider.myLocationWeather?.forecast?.forecastday?[0].day?.maxtempC}° L: ${cityProvider.myLocationWeather?.forecast?.forecastday?[0].day?.mintempC}°',
              isRemovable: false,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: cityProvider.selectedCities.length,
                itemBuilder: (context, index) {
                  final city = cityProvider.selectedCities[index];

                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      cityProvider.removeCity(index);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    child: CityCard(
                      cityName: city['owm_city_name'],
                      adminLevel: city['admin_level_1_long'],
                      country: city['country_long'],
                      temperature: city['temp_c'],
                      highLow: city['highLow'],
                      isRemovable: true,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
