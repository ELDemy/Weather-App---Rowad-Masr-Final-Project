import 'package:flutter/material.dart';
import 'package:weather/core/services/location/get_location.dart';

class TestLocationView extends StatefulWidget {
  const TestLocationView({super.key});

  @override
  State<TestLocationView> createState() => _TestLocationViewState();
}

class _TestLocationViewState extends State<TestLocationView> {
  String? city = 'Loading';

  @override
  void initState() {
    updateCity();
    super.initState();
  }

  updateCity() async {
    city = await (Location().getCurrentCity()) as String;

    print("city: $city");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          updateCity();
        },
        child: Text("$city"),
      ),
    );
  }
}
