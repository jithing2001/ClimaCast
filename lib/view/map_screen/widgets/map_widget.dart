import 'package:flutter/material.dart';
import 'package:weatherapp/controllers/location_controller.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:weatherapp/controllers/weather_controller.dart';

var datas;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

LocationController loc = LocationController();

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      width: double.infinity,
      child: OpenStreetMapSearchAndPick(
          center: LatLong(23, 72),
          buttonColor: Colors.blue,
          buttonText: 'Set Location',
          onPicked: (pickedData) async {
            loc.setLocation(pickedData.latLong.toString());
            await WeatherController().picLocationWeather(
                pickedData.latLong.latitude, pickedData.latLong.longitude);
          }),
    );
  }
}
