import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'constants.dart' as k;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoaded = true;
  num? temp;
  num? press;
  num? hum;
  num? cover;
  String? cityname;
  TextEditingController citycontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    fetchfromDevice();

    super.initState();
  }

  Future fetchfromDevice() async {
    bool status = await requestPermission();
    if (status) {
      getCurrentLocation();
    }
  }

  //  request for permission of storage
  Future requestPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      print('true');
      return true;
    } else {
      print('false');
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xffa8c0ff),
            Color(0xff91EAE4),
          ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
          child: Visibility(
            visible: isLoaded,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.07,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Center(
                    child: TextFormField(
                      onFieldSubmitted: (String s) {
                        setState(() {
                          cityname = s;
                          getCityWeather(s);
                          isLoaded = false;
                          citycontroller.clear();
                        });
                      },
                      controller: citycontroller,
                      cursorColor: Colors.white,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Search city',
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            size: 25,
                            color: Colors.white.withOpacity(0.7),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: Colors.red,
                        size: 40,
                      ),
                      Text(
                        cityname??'Unknown',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.10,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade900,
                            blurRadius: 4,
                            spreadRadius: 1)
                      ]),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/pngwing.com (6).png',
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Temperature: ${temp?.toStringAsFixed(2)} ℃',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.10,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade900,
                            blurRadius: 4,
                            spreadRadius: 1)
                      ]),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/pngwing.com (3).png',
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Pressure: ${press?.toStringAsFixed(2)} hPa',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.10,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade900,
                            blurRadius: 4,
                            spreadRadius: 1)
                      ]),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/pngwing.com (5).png',
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Humidity: ${hum?.toStringAsFixed(2)} %',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.10,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade900,
                            blurRadius: 4,
                            spreadRadius: 1)
                      ]),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/pngwing.com (4).png',
                        width: MediaQuery.of(context).size.width * 0.2,
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Cloud Cover: ${cover?.toStringAsFixed(2)} ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ],
            ),
            replacement: Center(child: CircularProgressIndicator()),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              getCurrentLocation();
            },
            child: Icon(Icons.location_on)),
      ),
    );
  }

  getCurrentLocation() async {
    var p = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );
    // if (p != null) {
    //   print('lat:${p.latitude} , long:${p.longitude}');
    //   getCurrentCityWeather(p);
    // } else {
    //   print('unavailable');
    // }
    log(p.toString());
    getCurrentCityWeather(p);
  }
  // getCurrentCityWeather(p);

  getCurrentCityWeather(Position position) async {
    var client = http.Client();
    var uri =
        '${k.domain}lat=${position.latitude}&lon=${position.longitude}&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    print(client);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      updateUi(decodedData);
      print(data);
      setState(() {
        isLoaded = true;
      });
    }
  }

  updateUi(var decodedData) {
    setState(() {
      if (decodedData == null) {
        temp = 0;
        press = 0;
        hum = 0;
        cover = 0;
        cityname = 'not available';
      } else {
        temp = decodedData['main']['temp'] - 273;
        press = decodedData['main']['pressure'];
        hum = decodedData['main']['humidity'];
        cover = decodedData['clouds']['all'];
        cityname = decodedData['name'];
      }
    });
  }

  getCityWeather(String cityname) async {
    var client = http.Client();
    var uri = '${k.domain}q=$cityname&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    print(client);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      updateUi(decodedData);
      print(data);
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    citycontroller.dispose();
    super.dispose();
  }
}
