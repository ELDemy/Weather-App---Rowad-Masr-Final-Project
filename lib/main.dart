import 'package:flutter/material.dart';
import 'package:weather/core/services/location/get_location.dart';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: TestLocation(),
      ),
    );
  }
}

class TestLocation extends StatefulWidget {
  const TestLocation({super.key});

  @override
  State<TestLocation> createState() => _TestLocationState();
}

class _TestLocationState extends State<TestLocation> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCity();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          getCity();
        },
        child: Text("Press"),
      ),
    );
  }
}
