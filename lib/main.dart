import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/current.dart';
import 'package:weather_app/pages/home_page.dart';
import 'package:weather_app/provider/location_provider.dart';
import 'package:weather_app/provider/weather_provider.dart';

import 'pages/full_report_page.dart';

  class MyHttpOverrides extends HttpOverrides {
    @override
    HttpClient createHttpClient(SecurityContext? context) {
      return super.createHttpClient(context)
        ..badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
    }
  }

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        ChangeNotifierProvider(   create: (context) => LocationProvider(),),
     //   ChangeNotifierProvider(   create: (context) => WeatherProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Weather',
        theme: ThemeData(
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: Colors.lightGreen[400]
          ),
          fontFamily: 'Poppins',
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              centerTitle: true,
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
          ),
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          scaffoldBackgroundColor: const Color(0xff08082d),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Colors.white, fontSize: 44),
            titleMedium: TextStyle(color: Colors.white, fontSize: 18),
            titleSmall:  TextStyle(color: Colors.white, fontSize: 16)

          ),
          useMaterial3: true,
        ),
        home:  const HomePage(),
      ),
    );
  }
}
