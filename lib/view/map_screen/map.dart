import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherapp/core/style.dart';
import 'package:weatherapp/view/map_screen/widgets/map_widget.dart';


class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'PIN YOUR GOOGLE LOCATION',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              kheight10,
              const MapScreen(),
              kheight10,
              SizedBox(
                height: 15,
                width: 200,
                child: Obx(() => Text(
                      loc.address.value == '' ? 'Select' : loc.address.value,
                      overflow: TextOverflow.ellipsis,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
