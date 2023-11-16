import 'current.dart';
import 'daily.dart';

class Temperatures {
  final double lat;
  final double lon;
  final String timezone;
  final int timezoneOffset;
  final Current current;
  final List<Current> hourly;
  final List<Daily> daily;

  Temperatures({
    required this.lat,
    required this.lon,
    required this.timezone,
    required this.timezoneOffset,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory Temperatures.fromMap(Map<String, dynamic> json) => Temperatures(
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    timezone: json["timezone"],
    timezoneOffset: json["timezone_offset"],
    current: Current.fromMap(json["current"]),
    hourly: List<Current>.from(json["hourly"].map((x) => Current.fromMap(x))),
    daily: List<Daily>.from(json["daily"].map((x) => Daily.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "lat": lat,
    "lon": lon,
    "timezone": timezone,
    "timezone_offset": timezoneOffset,
    "current": current.toMap(),
    "hourly": List<dynamic>.from(hourly.map((x) => x.toMap())),
    "daily": List<dynamic>.from(daily.map((x) => x.toMap())),
  };
}
