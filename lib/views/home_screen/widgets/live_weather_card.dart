import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';

import 'CityCard.dart';

class LiveWeatherCard extends StatefulWidget {
  const LiveWeatherCard({super.key});

  @override
  State<LiveWeatherCard> createState() => _LiveWeatherCardState();
}

class _LiveWeatherCardState extends State<LiveWeatherCard> {
  late CityProvider cityProvider = Provider.of<CityProvider>(context);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (cityProvider.userCity == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        cityProvider.fetchUserCity(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return cityProvider.userCity != null
        ? CityCard(
            cityProvider: cityProvider,
            cityName: cityProvider.userCity!,
            isRemovable: false,
          )
        : const Center(child: CircularProgressIndicator());
  }
}
