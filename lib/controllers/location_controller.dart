import 'package:get/get.dart';

class LocationController extends GetxController {
  RxString address = ''.obs;

  setLocation(String pickedData) {
    address.value = pickedData;
  }
}
