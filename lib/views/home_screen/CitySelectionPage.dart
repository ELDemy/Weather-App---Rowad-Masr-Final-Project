import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';
import 'package:weather/views/home_screen/providers/CityCard.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';

class CitySelectionPage extends StatelessWidget {
  const CitySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cityProvider = Provider.of<CityProvider>(context);
    final TextEditingController searchController = TextEditingController();

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
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Search City',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      if (searchController.text.isNotEmpty) {

                        cityProvider.fetchCityWeather(
                            searchController.text, context);
                      }
                    },
                  ),
                ),
                onSubmitted: (value) {

                  if (value.isNotEmpty) {
                    cityProvider.fetchCityWeather(value, context);
                  }
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cityProvider.selectedCities.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return cityProvider.myLocationWeather != null
                        ? CityCard(
                      cityName: "My Location",
                      weatherModel: cityProvider.myLocationWeather!,
                      isRemovable: false,
                    )
                        : Center(child: CircularProgressIndicator());
                  } else {
                    final WeatherModel city =
                    cityProvider.selectedCities[index - 1];
                    return Dismissible(
                      key: Key(city.location?.name ?? 'City'),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        cityProvider.removeCity(index - 1);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("${city.location?.name} removed"),
                          ),
                        );
                      },
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      child: CityCard(
                        cityName: city.location?.name ?? 'Unknown City',
                        weatherModel: city,
                        isRemovable: true,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

