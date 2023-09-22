import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/view/home/homescreen.dart';
import 'package:weatherapp/view/register/register.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 1));
      final userLogin = FirebaseAuth.instance.currentUser;
      if (userLogin == null) {
        Get.off(const Register());
      } else {
        Get.off(HomeScreen());
      }
    });
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 77, 171, 238),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 100),
            child: Image.asset(
              'assets/images/pngwing.com (6).png',
              height: 220,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.028,
          ),
          Row(
            children: [
              const SizedBox(width: 90),
              Center(
                child: Text(
                  'WeatherMate',
                  style: GoogleFonts.acme(
                      color: const Color.fromARGB(255, 254, 252, 252),
                      fontSize: 50),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 90,
          ),
          const Text('Version 1.0.0')
        ],
      ),
    );
  }
}
