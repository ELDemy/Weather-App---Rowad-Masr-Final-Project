import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/views/home_screen/providers/CityProvider.dart';

class SearchCityTextField extends StatefulWidget {
  const SearchCityTextField({super.key});

  @override
  State<SearchCityTextField> createState() => _SearchCityTextFieldState();
}

class _SearchCityTextFieldState extends State<SearchCityTextField> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            onPressed: () async {
              if (searchController.text.isNotEmpty) {
                CityProvider cityProvider =
                    Provider.of<CityProvider>(context, listen: false);
                await cityProvider.fetchCityWeather(
                    searchController.text, context);
                searchController.clear();
              }
            },
          ),
        ),
        onSubmitted: (value) async {
          if (value.isNotEmpty) {
            CityProvider cityProvider =
                Provider.of<CityProvider>(context, listen: false);
            await cityProvider.fetchCityWeather(value, context);
            searchController.clear();
          }
        },
      ),
    );
  }
}
