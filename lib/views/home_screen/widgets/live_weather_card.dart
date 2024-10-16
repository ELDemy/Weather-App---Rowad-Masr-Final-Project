import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/views/home_screen/providers/CityCard.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';

class LiveWeatherCard extends StatefulWidget {
  const LiveWeatherCard({
    super.key,
  });

  @override
  State<LiveWeatherCard> createState() => _LiveWeatherCardState();
}

class _LiveWeatherCardState extends State<LiveWeatherCard> {
  late CityProvider cityProvider = Provider.of<CityProvider>(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (cityProvider.myLocationWeather == null) {
      cityProvider.fetchCurrentLocationWeather(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return cityProvider.myLocationWeather != null
        ? CityCard(
            cityName: "My Location",
            weatherModel: cityProvider.myLocationWeather!,
            isRemovable: false,
          )
        : const Center(child: CircularProgressIndicator());
  }
}
