import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/views/home_screen/providers/CityCard.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';

class CitySelectionPage extends StatelessWidget {
  const CitySelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cityProvider = Provider.of<CityProvider>(context);

    final TextEditingController searchController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Weather App',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
              child: CupertinoSearchTextField(
                controller: searchController,
                itemSize: 18,
                placeholder: 'Search for a city',
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white,
                    inherit: false),
                onChanged: (value) {
                  cityProvider.filterCities(value);
                },
              ),
            ),
            if (!cityProvider.isSearching) ...[
              CityCard(
                cityName: 'My Location',
                adminLevel: 'Current Area',
                country: 'Current Country',
                temperature: '25°',
                highLow: 'H: 28° L: 18°',
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
                        temperature: '25°',
                        highLow: 'H: 28° L: 18°',
                        isRemovable: true,
                      ),
                    );
                  },
                ),
              ),
            ],
            if (cityProvider.isSearching &&
                cityProvider.filteredCities.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: cityProvider.filteredCities.length,
                  itemBuilder: (context, index) {
                    final city = cityProvider.filteredCities[index];
                    return ListTile(
                      title: Text(
                        '${city['owm_city_name']}, ${city['country_long']}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        cityProvider.selectCity(city);

                        FocusScope.of(context).unfocus();

                        searchController.clear();
                      },
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
