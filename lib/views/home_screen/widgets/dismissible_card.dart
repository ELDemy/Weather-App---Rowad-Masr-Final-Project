import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/core/models/weather_model/WeatherModel.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';
import 'package:weather/views/home_screen/widgets/CityCard.dart';

class DismissibleCard extends StatefulWidget {
  const DismissibleCard({super.key, required this.index});
  final int index;

  @override
  State<DismissibleCard> createState() => _DismissibleCardState();
}

class _DismissibleCardState extends State<DismissibleCard> {
  @override
  Widget build(BuildContext context) {
    CityProvider cityProvider = Provider.of<CityProvider>(context);
    WeatherModel city = cityProvider.selectedCities[widget.index];
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cityProvider.removeCity(widget.index, context);
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
}
