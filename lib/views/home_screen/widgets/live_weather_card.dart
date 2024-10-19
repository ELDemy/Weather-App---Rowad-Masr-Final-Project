import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/utiles/helpers.dart';
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
  void initState() {
    super.initState();
    _getUserLocation();
  }

  _getUserLocation() {
    SchedulerBinding.instance.addPostFrameCallback(
      (_) async {
        if (cityProvider.userCity == null) {
          Helpers.showMaterialBanner(context, "getting user Location..");
          await cityProvider.fetchUserCity(context);
          if (mounted) {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          }
        }
        loading = false;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    cityProvider = Provider.of<CityProvider>(context);
    if (loading) {
      return const Center(
          child: CircularProgressIndicator(color: Colors.white));
    } else {
      return CityCard(
        cityProvider: cityProvider,
        cityName: cityProvider.userCity ?? '',
        isRemovable: false,
      );
    }
  }
}
