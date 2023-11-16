import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/models/current.dart';

import 'package:weather_app/provider/weather_provider.dart';



class LocationProvider extends ChangeNotifier {
  double _latitude = 0.0;
  double _longitude = 0.0;

  WeatherProvider weatherProvider = WeatherProvider();

  double getLatitude() => _latitude;

  double getLongitude() => _longitude;

  Future<Current?> getLocation(BuildContext context) async {
    bool isServiceAvailable;
    LocationPermission locationPermission;

    isServiceAvailable = await Geolocator.isLocationServiceEnabled();

    if (!isServiceAvailable) {
      return Future.error('Location service for this device isnt available');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error('Location permission denied forever');
    } else if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      _latitude = value.latitude;
      _longitude = value.longitude;

      return weatherProvider.getCurrentWeather(_latitude, _longitude);
    });
  }
}
