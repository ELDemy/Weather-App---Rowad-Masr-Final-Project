import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';
import 'package:weather/views/home_screen/widgets/CityCard.dart';

class DismissibleCard extends StatelessWidget {
  const DismissibleCard({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    CityProvider cityProvider = Provider.of<CityProvider>(context);
    String cityName = cityProvider.selectedCities[index];
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        cityProvider.removeCity(index, context);
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: CityCard(
        cityName: cityName,
        cityProvider: cityProvider,
        isRemovable: true,
      ),
    );
  }
}
