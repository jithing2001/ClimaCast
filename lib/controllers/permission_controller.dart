import 'dart:developer';

import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weatherapp/controllers/weather_controller.dart';

class PermissionController extends GetxController {
  WeatherController weatherObj = WeatherController();
  @override
  void onInit() {
    // TODO: implement initState
    fetchfromDevice();

    super.onInit();
  }

  Future fetchfromDevice() async {
    log('oninit');
    bool status = await requestPermission();
    if (status) {
      log('Permission Gratded');
      weatherObj.getCurrentLocation();
    } else {
      log('No permission');
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
}
