
import 'package:device_daily/view/home_screen.dart';
import 'package:device_daily/view/splash_screen.dart';
import 'package:device_daily/view/stripe_payment_view.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String homeView = '/home_view';
  static const String paymentView = '/payment';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      initialRoute: (context) => const SplashScreen(),
      homeView: (context) => const HomeScreen(),
      paymentView:(context) => const StripePaymentView(),
    };
  }
}