import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';

import 'widgets/dismissible_card.dart';
import 'widgets/live_weather_card.dart';
import 'widgets/search_text_field.dart';

class CitySelectionPage extends StatefulWidget {
  const CitySelectionPage({super.key});

  @override
  State<CitySelectionPage> createState() => _CitySelectionPageState();
}

class _CitySelectionPageState extends State<CitySelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar(),
      body: Column(
        children: [
          const SearchCityTextField(),
          Expanded(
            child: ListView.builder(
              itemCount:
                  Provider.of<CityProvider>(context).selectedCities.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const LiveWeatherCard();
                } else {
                  return DismissibleCard(index: index - 1);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.black,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          setState(() {});
        },
        icon: const Icon(Icons.refresh),
        color: Colors.white,
      ),
      title: const Text(
        'Weather App',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
