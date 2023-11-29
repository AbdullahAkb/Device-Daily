import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home_view');
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/splash_pic.jpg",
              fit: BoxFit.cover,
              width: width * 0.99,
              height: height * 0.4,
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Text(
              "Everything is News",
              style: GoogleFonts.poppins(
                  color: Colors.grey.shade700,
                  letterSpacing: .6,
                  fontWeight: FontWeight.w600,
                  fontSize: 20),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            const SpinKitChasingDots(
              color: Color.fromARGB(255, 141, 37, 25),
            ),
          ],
        ),
      ),
    );
  }
}
