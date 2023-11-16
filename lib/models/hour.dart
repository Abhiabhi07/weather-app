import 'description.dart';
import 'icon.dart';
import 'main_condition.dart';
import 'weather.dart';

// To parse this JSON data, do
//
//     final hourly = hourlyFromMap(jsonString);

import 'dart:convert';

class Hour {
  int dt;
  num temp;
  int pressure;
  int humidity;
  double windSpeed;
  List<Weather> weather;

  Hour({
    required this.dt,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.weather,
  });

  factory Hour.fromMap(Map<String, dynamic> json) => Hour(
        dt: json["dt"],
        temp: json["temp"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        windSpeed: json["wind_speed"]?.toDouble(),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "dt": dt,
        "temp": temp,
        "pressure": pressure,
        "humidity": humidity,
        "wind_speed": windSpeed,
        "weather": weather.map((w) => w.toMap()).toList(),
      };
}

class Weather {
  int id;
  Main? main;
  Description? description;
  Icon? icon;

  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  factory Weather.fromMap(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: mainValues.map[json["main"]],
        description: descriptionValues.map[json["description"]],
        icon: iconValues.map[json["icon"]],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "main": mainValues.reverse[main],
        "description": descriptionValues.reverse[description],
        "icon": iconValues.reverse[icon],
      };
}

// class Weather {
//   int id;
//   String main;
//   String description;
//   String icon;
//
//   Weather({
//     required this.id,
//     required this.main,
//     required this.description,
//     required this.icon,
//   });
//
//   factory Weather.fromMap(Map<String, dynamic> json) => Weather(
//     id: json["id"],
//     main: json["main"],
//     description: json["description"],
//     icon: json["icon"],
//   );
//
//   Map<String, dynamic> toMap() => {
//     "id": id,
//     "main": main,
//     "description": description,
//     "icon": icon,
//   };
// }

// class Hourly {
//   int dt;
//   num temp;
//   List<Weather> weather;
//
//   Hourly({
//     required this.dt,
//     required this.temp,
//    required this.weather,
//   });
//
//   Map<String, dynamic> toMap() {
//     return {
//       'dt': dt,
//       'temp': temp,
//      'weather': weather.map((w) => w.toMap()).toList(),
//     };
//   }
//
//   factory Hourly.fromMap(Map<String, dynamic> json) {
//     return Hourly(
//       dt: json['dt'],
//       temp: json['temp'],
//      weather:
//      List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
//     );
//   }
// }
