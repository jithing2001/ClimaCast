import 'dart:convert';
import 'dart:developer';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/view/home/homescreen.dart';
import 'package:weatherapp/view/map_screen/widgets/map_widget.dart';

import '../../constants.dart' as k;

class WeatherController extends GetxController {
  RxBool isLoaded = true.obs;
  RxDouble temp = 0.0.obs;
  RxDouble press = 0.0.obs;
  RxDouble hum = 0.0.obs;
  RxDouble cover = 0.0.obs;
  RxString cityname = 'Unavailable'.obs;

  getCurrentLocation() async {
    var p = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low,
      forceAndroidLocationManager: true,
    );

    log("position:${p.toString()}");
    getCurrentCityWeather(p);
  }

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
      // log(data);

      isLoaded.value = true;
      // log(isLoaded.value.toString());
    }
  }

  updateUi(var decodedData) {
    log("------${decodedData}");
    if (decodedData == null) {
      temp.value = 0;
      press.value = 0;
      hum.value = 0;
      cover.value = 0;
      cityname.value = 'not available';
    } else {
      log('hello');

      temp.value = (decodedData['main']['temp'] - 273).toDouble();
      log(temp.value.toString());
      press.value = (decodedData['main']['pressure']).toDouble();
      hum.value = (decodedData['main']['humidity']).toDouble();
      cover.value = (decodedData['clouds']['all']).toDouble();
      cityname.value = decodedData['name'];
    }
    isLoaded.value = true;
    log('=======${isLoaded.value}');
    update();
  }

  getCityWeather(String cityname) async {
    var client = http.Client();
    var uri = '${k.domain}q=$cityname&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      var decodedData = jsonDecode(data);
      updateUi(decodedData);

      isLoaded.value = true;
      log('=${isLoaded.value}');
      update();
    }
  }

  picLocationWeather(final lat, final long) async {
    var client = http.Client();
    var uri = '${k.domain}lat=${lat}&lon=${long}&appid=${k.apiKey}';
    var url = Uri.parse(uri);
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var data = response.body;
      log('====================$data');
      var decodedData = jsonDecode(data);
      datas = decodedData;
      Get.to(HomeScreen());
      updateUi(decodedData);
      isLoaded.value = true;
      update();
    }
  }
}
