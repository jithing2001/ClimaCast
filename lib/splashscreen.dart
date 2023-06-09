import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weatherapp/homescreen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
     Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 77, 171, 238),
      body: Column(
        children: [
          SizedBox(
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
                  'ClimaCast',
                  style: GoogleFonts.acme(
                      color: const Color.fromARGB(255, 254, 252, 252), fontSize: 60),
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
