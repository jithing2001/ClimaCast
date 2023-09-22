import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/controllers/weather_controller.dart';
import 'package:weatherapp/services/authentication_service.dart';
import 'package:weatherapp/view/home/widgets/tile.dart';
import 'package:weatherapp/view/map_screen/map.dart';
import 'package:weatherapp/view/map_screen/widgets/map_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController citycontroller = TextEditingController();

  WeatherController weatherObj = WeatherController();

  @override
  Widget build(BuildContext context) {
    log('datas ; $datas');
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
            child: Obx(() {
              return Visibility(
                visible: weatherObj.isLoaded.value,
                replacement: const Center(child: CircularProgressIndicator()),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.07,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20))),
                      child: Center(
                        child: TextFormField(
                          onFieldSubmitted: (String s) {
                            weatherObj.cityname.value = s;
                            weatherObj.isLoaded.value = false;
                            log("first${weatherObj.isLoaded.value.toString()}");
                            weatherObj.getCityWeather(s);
                            citycontroller.clear();
                          },
                          controller: citycontroller,
                          cursorColor: Colors.white,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
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
                    const SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(
                                Icons.pin_drop,
                                color: Colors.red,
                                size: 40,
                              ),
                              Text(
                                weatherObj.cityname.value ?? 'Unknown',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 28, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                Get.to(const MapPage());
                              },
                              icon: const Icon(
                                Icons.map_outlined,
                                size: 40,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Tile(
                            content:
                                'Temperature: ${weatherObj.temp.value?.toStringAsFixed(2)} ℃',
                            img: 'assets/images/pngwing.com (6).png'),
                        Tile(
                            content:
                                'Pressure: ${weatherObj.press.value?.toStringAsFixed(2)} hPa',
                            img: 'assets/images/pngwing.com (3).png'),
                        Tile(
                            content:
                                'Humidity: ${weatherObj.hum.value?.toStringAsFixed(2)} %',
                            img: 'assets/images/pngwing.com (5).png'),
                        Tile(
                            content:
                                'Cloud Cover: ${weatherObj.cover.value?.toStringAsFixed(2)} ',
                            img: 'assets/images/pngwing.com (4).png'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () => Authentication().signOut(),
                      child: const CircleAvatar(
                        radius: 30,
                        child: Icon(
                          Icons.logout,
                          size: 30,
                        ),
                      ),
                    )
                  ],
                ),
              );
            })),
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              log('press');
              weatherObj.getCurrentLocation();
            },
            child: const Icon(Icons.location_on)),
      ),
    );
  }
}
