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
  late CityProvider cityProvider;
  bool loading = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    cityProvider = Provider.of<CityProvider>(context);
    _getUserLocation();
  }

  _getUserLocation() {
    if (cityProvider.userCity == null) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        await cityProvider.fetchUserCity(context);
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    } else {
      String? cityName = cityProvider.userCity;
      return CityCard(
        cityProvider: cityProvider,
        cityName: cityName ?? '',
        isRemovable: false,
      );
    }
  }
}
