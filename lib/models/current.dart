import 'description.dart';
import 'icon.dart';
import 'main_condition.dart';
import 'rain.dart';
import 'weather.dart';

class Current {
  final double temp;
  final int pressure;
  final int humidity;
  final int clouds;
  final double windSpeed;
  final List<Weather> weather;

  Current({
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.clouds,
    required this.windSpeed,
    required this.weather,
  });

  factory Current.fromMap(Map<String, dynamic> json) {
   return Current(
      temp: json["temp"]?.toDouble(),
      pressure: json["pressure"],
      humidity: json["humidity"],
      clouds: json["clouds"],
      windSpeed: json["wind_speed"]?.toDouble(),
      weather:
      List<Weather>.from(json["weather"].map((x) => Weather.fromMap(x))),
    );
  }


  Map<String, dynamic> toMap() => {
        "temp": temp,
        "pressure": pressure,
        "humidity": humidity,
        "clouds": clouds,
        "wind_speed": windSpeed,
        "weather": weather.map((w) => w.toMap()).toList(),
      };
}
