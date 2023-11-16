import 'description.dart';
import 'feels_like.dart';
import 'icon.dart';
import 'main_condition.dart';
import 'temp.dart';
import 'weather.dart';

class Daily {
  final int dt;
  final int sunrise;
  final int sunset;
  final int moonrise;
  final int moonset;
  final double moonPhase;
  final String summary;
  final Temp temp;
  final FeelsLike feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double windSpeed;
  final int windDeg;
  final double windGust;
  final List<Weather>? weather;
  final int clouds;
  final double pop;
  final double uvi;
  final double? rain;

  Daily({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.moonrise,
    required this.moonset,
    required this.moonPhase,
    required this.summary,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.clouds,
    required this.pop,
    required this.uvi,
    this.rain,
  });

  factory Daily.fromMap(Map<String, dynamic> json) => Daily(
    dt: json["dt"],
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    moonrise: json["moonrise"],
    moonset: json["moonset"],
    moonPhase: json["moon_phase"]?.toDouble(),
    summary: json["summary"],
    temp: Temp.fromMap(json["temp"]),
    feelsLike: FeelsLike.fromMap(json["feels_like"]),
    pressure: json["pressure"],
    humidity: json["humidity"],
    dewPoint: json["dew_point"]?.toDouble(),
    windSpeed: json["wind_speed"]?.toDouble(),
    windDeg: json["wind_deg"],
    windGust: json["wind_gust"]?.toDouble(),
    weather: List<Weather>.from(json["weather"]?.map((x) => Weather.fromMap(x))),
    clouds: json["clouds"],
    pop: json["pop"]?.toDouble(),
    uvi: json["uvi"]?.toDouble(),
    rain: json["rain"]?.toDouble(),
  );

  Map<String, dynamic> toMap() => {
    "dt": dt,
    "sunrise": sunrise,
    "sunset": sunset,
    "moonrise": moonrise,
    "moonset": moonset,
    "moon_phase": moonPhase,
    "summary": summary,
    "temp": temp.toMap(),
    "feels_like": feelsLike.toMap(),
    "pressure": pressure,
    "humidity": humidity,
    "dew_point": dewPoint,
    "wind_speed": windSpeed,
    "wind_deg": windDeg,
    "wind_gust": windGust,
    "weather": List<dynamic>.from(weather!.map((x) => x.toMap())),
    "clouds": clouds,
    "pop": pop,
    "uvi": uvi,
    "rain": rain,
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